# Git Worktree Helper Functions
# Run multiple Claude Code instances in parallel using git worktrees

WT_BASE="$HOME/Developer/worktrees"
WT_CONFIG_FILE=".worktree"
WT_VERCEL_REPOS=("$HOME/Developer/vercel/v0" "$HOME/Developer/vercel/v1" "$HOME/Developer/vercel/v2")

# Get the repo root (handles both main repo and worktrees)
_wt_repo_root() {
  local toplevel=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -z "$toplevel" ]]; then
    echo "Error: Not in a git repository" >&2
    return 1
  fi

  # If we're in a worktree, show-toplevel gives the worktree path, not the main repo
  local git_dir=$(git rev-parse --git-dir 2>/dev/null)
  if [[ "$git_dir" == *"/worktrees/"* ]]; then
    local common_dir=$(git rev-parse --git-common-dir 2>/dev/null)
    # Avoid cd here — chpwd hooks (fnm, etc.) would pollute the captured stdout
    dirname "$common_dir"
    return 0
  fi

  echo "$toplevel"
}

_wt_tmux_rename() {
  [[ -n "$TMUX" ]] && tmux rename-window "$1" 2>/dev/null
}

# Main worktree command
wt() {
  local cmd="${1:-}"

  if [[ -z "$cmd" ]]; then
    local repo_root=$(_wt_repo_root) || return 1
    cd "$repo_root"
    return 0
  fi

  [[ "$cmd" == "-" ]] && { cd -; return 0; }

  case "$cmd" in
    ls)              shift; _wt_list "$@" ;;
    rm)              shift; _wt_remove "$@" ;;
    path)            shift; _wt_path "$@" ;;
    help|--help|-h)  _wt_help ;;
    *)               _wt_checkout "$@" ;;
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

Config: Add files to copy in .worktree (one glob pattern per line)
Worktrees stored in: $WT_BASE/<repo-name>/<worktree-name>
EOF
}

_wt_checkout() {
  local name="$1"
  local branch="${2:-$name}"

  if [[ -z "$name" ]]; then
    echo "Usage: wt <name> [branch]"
    return 1
  fi

  local repo_root=$(_wt_repo_root) || return 1
  local repo_name=$(basename "$repo_root")
  local wt_parent="$WT_BASE/$repo_name/$name"
  local wt_path="$wt_parent/$repo_name"
  local is_vercel=
  for _r in "${WT_VERCEL_REPOS[@]}"; do [[ "$repo_root" == "$_r" ]] && is_vercel=1 && break; done

  # Worktree already exists
  if [[ -d "$wt_path" ]]; then
    cd "$wt_path"
    _wt_tmux_rename "$name"
    return 0
  fi

  echo "Creating worktree '$name' at $wt_path..."
  mkdir -p "$wt_parent"

  # For vercel repos, refresh origin/main in background (new worktree uses current origin/main)
  if [[ -n "$is_vercel" ]]; then
    git -C "$repo_root" fetch origin main </dev/null &>/dev/null &
    disown
  fi

  # Create worktree: local branch > remote branch > new branch
  if git -C "$repo_root" show-ref --verify --quiet "refs/heads/$branch"; then
    if ! git -C "$repo_root" worktree add "$wt_path" "$branch" 2>/dev/null; then
      echo "Branch '$branch' already checked out, creating 'wt/$branch'"
      git -C "$repo_root" worktree add -b "wt/$branch" "$wt_path" "$branch" || { echo "Error: Failed to create worktree"; return 1; }
    fi
  elif git -C "$repo_root" show-ref --verify --quiet "refs/remotes/origin/$branch"; then
    git -C "$repo_root" worktree add --track -b "$branch" "$wt_path" "origin/$branch" || { echo "Error: Failed to create worktree"; return 1; }
  elif [[ -n "$is_vercel" ]]; then
    git -C "$repo_root" worktree add -b "$branch" "$wt_path" origin/main || { echo "Error: Failed to create worktree"; return 1; }
  else
    git -C "$repo_root" worktree add -b "$branch" "$wt_path" || { echo "Error: Failed to create worktree"; return 1; }
  fi

  # Vercel repos: cd into worktree, deps in background
  if [[ -n "$is_vercel" ]]; then
    cd "$wt_path"
    _wt_tmux_rename "$name"
    (pnpm install && pnpm setup-env) </dev/null &>"$wt_path/.wt-setup.log" &
    disown
    echo "Worktree ready. Deps installing in background (log: .wt-setup.log)"
    return 0
  fi

  # Copy files listed in .worktree config
  if [[ -f "$repo_root/$WT_CONFIG_FILE" ]]; then
    while IFS= read -r pattern || [[ -n "$pattern" ]]; do
      [[ -z "$pattern" || "$pattern" == \#* ]] && continue
      for file in "$repo_root"/$~pattern(N); do
        [[ -f "$file" ]] || continue
        local rel_path="${file#$repo_root/}"
        mkdir -p "$wt_path/$(dirname "$rel_path")"
        cp "$file" "$wt_path/$(dirname "$rel_path")/"
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

  echo "Worktree created: $wt_path"
  cd "$wt_path"
  _wt_tmux_rename "$name"
}

_wt_list() {
  local repo_root=$(_wt_repo_root) || return 1
  local repo_name=$(basename "$repo_root")
  local cwd=$(pwd)
  local RED=$'\e[31m' YEL=$'\e[33m' GRN=$'\e[32m' RST=$'\e[0m'
  local wt_path head branch detached

  git -C "$repo_root" worktree list --porcelain | while IFS= read -r line; do
    case "$line" in
      "worktree "*) wt_path="${line#worktree }"; head=""; branch=""; detached= ;;
      "HEAD "*)     head="${line#HEAD }"; head="${head:0:7}" ;;
      "branch "*)   branch="${line#branch refs/heads/}" ;;
      detached)     detached=1 ;;
      "")
        local name=""
        if [[ "$wt_path" == "$repo_root" ]]; then
          name="(main repo)"
        elif [[ "$wt_path" == "$WT_BASE/$repo_name/"* ]]; then
          local rel="${wt_path#$WT_BASE/$repo_name/}"
          name="${rel%/$repo_name}"
        else
          name=$(basename "$wt_path")
        fi
        local ref="${branch:-(detached)}"
        local mark=""
        [[ "$cwd" == "$wt_path"* ]] && mark=" ${GRN}*${RST}"
        printf "%s%s%s %s%s%s %s%s\n" "$RED" "$head" "$RST" "$YEL" "$ref" "$RST" "$name" "$mark"
        ;;
    esac
  done
}

_wt_remove() {
  local name="$1"

  if [[ -z "$name" ]]; then
    echo "Usage: wt rm <name>"
    return 1
  fi

  local repo_root=$(_wt_repo_root) || return 1
  local repo_name=$(basename "$repo_root")
  local wt_parent="$WT_BASE/$repo_name/$name"
  local wt_path="$wt_parent/$repo_name"

  if [[ ! -d "$wt_path" ]]; then
    echo "Error: Worktree not found: $wt_path"
    return 1
  fi

  if [[ "$(pwd)" == "$wt_parent"* ]]; then
    echo "Error: Cannot remove worktree while inside it"
    return 1
  fi

  git -C "$repo_root" worktree remove "$wt_path" --force || { echo "Error: Failed to remove worktree"; return 1; }
  rmdir "$wt_parent" 2>/dev/null

  echo "Worktree removed"
  read -q "REPLY?Delete branch '$name' as well? [y/N] "
  echo ""
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    git -C "$repo_root" branch -D "$name" 2>/dev/null && echo "Branch deleted" || echo "Branch not found"
  fi
}

_wt_path() {
  local name="$1"

  if [[ -z "$name" ]]; then
    echo "Usage: wt path <name>" >&2
    return 1
  fi

  local repo_root=$(_wt_repo_root) || return 1
  local repo_name=$(basename "$repo_root")
  local wt_path="$WT_BASE/$repo_name/$name/$repo_name"

  if [[ -d "$wt_path" ]]; then
    echo "$wt_path"
  else
    echo "Error: Worktree not found: $wt_path" >&2
    return 1
  fi
}

# Tab completion
_wt_completion() {
  local repo_name=$(basename "$(_wt_repo_root 2>/dev/null)" 2>/dev/null)
  [[ -n "$repo_name" && -d "$WT_BASE/$repo_name" ]] || return
  compadd $(command ls -t "$WT_BASE/$repo_name" 2>/dev/null)
}

(( $+functions[compdef] )) && compdef _wt_completion wt
