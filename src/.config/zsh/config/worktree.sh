# Git Worktree Helper Functions
# Run multiple Claude Code instances in parallel using git worktrees

WT_BASE="$HOME/Developer/worktrees"
WT_CONFIG_FILE=".worktree"

# Validate worktree/branch name
_wt_validate_name() {
  local name="$1"

  # Check for empty
  [[ -z "$name" ]] && echo "Name cannot be empty" && return 1

  # Check for invalid characters (git branch rules)
  if [[ "$name" =~ [[:space:]] ]]; then
    echo "Name cannot contain spaces"
    return 1
  fi

  if [[ "$name" =~ [\~\^\:\?\*\[\\\] ]]; then
    echo "Name cannot contain ~ ^ : ? * [ \\"
    return 1
  fi

  if [[ "$name" == .* || "$name" == -* ]]; then
    echo "Name cannot start with . or -"
    return 1
  fi

  if [[ "$name" == *.lock ]]; then
    echo "Name cannot end with .lock"
    return 1
  fi

  if [[ "$name" == *..* ]]; then
    echo "Name cannot contain .."
    return 1
  fi

  return 0
}

# Get the repo name from the current git directory
_wt_repo_name() {
  local repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -z "$repo_root" ]]; then
    echo "Error: Not in a git repository" >&2
    return 1
  fi
  basename "$repo_root"
}

# Get the repo root (handles both main repo and worktrees)
_wt_repo_root() {
  local git_dir=$(git rev-parse --git-dir 2>/dev/null)
  if [[ -z "$git_dir" ]]; then
    echo "Error: Not in a git repository" >&2
    return 1
  fi

  # If we're in a worktree, git-dir points to .git/worktrees/<name>
  if [[ "$git_dir" == *"/worktrees/"* ]]; then
    git_dir=$(git rev-parse --git-common-dir 2>/dev/null)
  fi

  # git_dir is .git, so parent is the repo root
  dirname "$git_dir"
}

# Main worktree command
wt() {
  local cmd="${1:-}"

  # No args = go to root repo
  if [[ -z "$cmd" ]]; then
    local repo_root=$(_wt_repo_root) || return 1
    cd "$repo_root"
    return 0
  fi

  # wt - = cd -
  if [[ "$cmd" == "-" ]]; then
    cd -
    return 0
  fi

  # Subcommands
  case "$cmd" in
    ls)           shift; _wt_list "$@" ;;
    rm)           shift; _wt_remove "$@" ;;
    path)         shift; _wt_path "$@" ;;
    help|--help|-h) _wt_help ;;
    *)            _wt_checkout "$@" ;;
  esac
}

_wt_help() {
  cat <<EOF
Git Worktree Helper - Run multiple Claude Code instances in parallel

Usage: wt [name] [branch]

Commands:
  wt                      Go to root repo
  wt <name>               Create/switch to worktree (creates branch if needed)
  wt <name> <branch>      Create worktree from existing branch
  wt ls                   List all worktrees
  wt rm <name>            Remove worktree
  wt path <name>          Print path to worktree

Examples:
  wt feature-auth         # Create worktree, install deps, cd there
  wt hotfix main          # Create worktree from main branch
  wt                      # Go to root repo
  wt ls                   # List all worktrees
  wt rm feature-auth      # Remove worktree

Config: Add files to copy in .worktree (one glob pattern per line)
Worktrees stored in: $WT_BASE/<repo-name>/<worktree-name>
EOF
}

_wt_checkout() {
  local name="$1"
  local branch="$2"

  if [[ -z "$name" ]]; then
    echo "Error: Worktree name required"
    echo "Usage: wt <name> [branch]"
    return 1
  fi

  # Validate name
  local validation_error
  if ! validation_error=$(_wt_validate_name "$name"); then
    echo "Error: Invalid worktree name '$name'"
    echo "  $validation_error"
    return 1
  fi

  local repo_name=$(_wt_repo_name) || return 1
  local repo_root=$(_wt_repo_root) || return 1
  local wt_path="$WT_BASE/$repo_name/$name"

  # Default branch to worktree name
  [[ -z "$branch" ]] && branch="$name"

  # Check if worktree already exists
  if [[ -d "$wt_path" ]]; then
    cd "$wt_path"
    return 0
  fi

  echo "Creating worktree '$name' at $wt_path..."
  mkdir -p "$WT_BASE/$repo_name"

  # Check if branch exists
  if git -C "$repo_root" show-ref --verify --quiet "refs/heads/$branch"; then
    echo "Using existing branch: $branch"
    git -C "$repo_root" worktree add "$wt_path" "$branch"
  else
    echo "Creating new branch: $branch"
    git -C "$repo_root" worktree add -b "$branch" "$wt_path"
  fi

  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to create worktree"
    return 1
  fi

  # Copy files listed in .worktree config
  if [[ -f "$repo_root/$WT_CONFIG_FILE" ]]; then
    while IFS= read -r pattern || [[ -n "$pattern" ]]; do
      [[ -z "$pattern" || "$pattern" == \#* ]] && continue
      for file in "$repo_root"/$~pattern(N); do
        [[ -f "$file" ]] || continue
        local rel_path="${file#$repo_root/}"
        local dest_dir="$wt_path/$(dirname "$rel_path")"
        mkdir -p "$dest_dir"
        cp "$file" "$dest_dir/"
        echo "  Copied $rel_path"
      done
    done < "$repo_root/$WT_CONFIG_FILE"
  fi

  # Auto-detect package manager and install dependencies
  local pkg_manager=""
  if [[ -f "$repo_root/bun.lockb" || -f "$repo_root/bun.lock" ]]; then
    pkg_manager="bun"
  elif [[ -f "$repo_root/pnpm-lock.yaml" ]]; then
    pkg_manager="pnpm"
  elif [[ -f "$repo_root/yarn.lock" ]]; then
    pkg_manager="yarn"
  elif [[ -f "$repo_root/package-lock.json" ]]; then
    pkg_manager="npm"
  fi

  if [[ -n "$pkg_manager" ]]; then
    echo "Installing dependencies with $pkg_manager..."
    (cd "$wt_path" && $pkg_manager install)
  fi

  echo ""
  echo "Worktree created: $wt_path"
  cd "$wt_path"
}

_wt_list() {
  local repo_name=$(_wt_repo_name) || return 1
  local repo_root=$(_wt_repo_root) || return 1

  echo "Worktrees for $repo_name:"
  echo ""
  git -C "$repo_root" worktree list
}

_wt_remove() {
  local name="$1"

  if [[ -z "$name" ]]; then
    echo "Error: Worktree name required"
    echo "Usage: wt remove <name>"
    return 1
  fi

  local repo_name=$(_wt_repo_name) || return 1
  local repo_root=$(_wt_repo_root) || return 1
  local wt_path="$WT_BASE/$repo_name/$name"

  if [[ ! -d "$wt_path" ]]; then
    echo "Error: Worktree not found: $wt_path"
    return 1
  fi

  if [[ "$(pwd)" == "$wt_path"* ]]; then
    echo "Error: Cannot remove worktree while inside it"
    echo "Please cd to a different directory first"
    return 1
  fi

  echo "Removing worktree: $wt_path"
  git -C "$repo_root" worktree remove "$wt_path" --force

  if [[ $? -eq 0 ]]; then
    echo "Worktree removed"
    echo ""
    read -q "REPLY?Delete branch '$name' as well? [y/N] "
    echo ""
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      git -C "$repo_root" branch -D "$name" 2>/dev/null && echo "Branch deleted" || echo "Branch not found"
    fi
  else
    echo "Error: Failed to remove worktree"
    return 1
  fi
}

_wt_path() {
  local name="$1"

  if [[ -z "$name" ]]; then
    echo "Error: Worktree name required" >&2
    return 1
  fi

  local repo_name=$(_wt_repo_name) || return 1
  local wt_path="$WT_BASE/$repo_name/$name"

  if [[ -d "$wt_path" ]]; then
    echo "$wt_path"
  else
    echo "Error: Worktree not found: $wt_path" >&2
    return 1
  fi
}

# Tab completion
_wt_completion() {
  local repo_name=$(_wt_repo_name 2>/dev/null)
  local -a wts

  if [[ -n "$repo_name" && -d "$WT_BASE/$repo_name" ]]; then
    wts=($(command ls -t "$WT_BASE/$repo_name" 2>/dev/null))
  fi

  compadd -a wts
}

(( $+functions[compdef] )) && compdef _wt_completion wt
