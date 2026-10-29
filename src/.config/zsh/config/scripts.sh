# Vercel AI Gateway key
# - Claude Code: settings.json apiKeyHelper reads it at request time from Keychain (macOS) or
#   systemd-creds (Linux, host-bound: re-create after a reinstall). To store/update:
#     macOS: security add-generic-password -U -s 'Vercel AI Gateway' -a vercel-desktop-key -w '<key>'
#     Linux: printf '%s' '<key>' | systemd-creds encrypt --user --name=anthropic_auth_token - \
#              ~/.config/claude/anthropic_auth_token.cred
# - Zed, Kit, opencode: read VERCEL_/KIT_/AI_GATEWAY_API_KEY, exported from the Keychain in .zshrc (macOS)

# Repos live at ~/Developer/{owner}/{repo} (plus a few at the top level), so glob those instead of walking every tree.
function find_projects() {
  local selected_dir=$(print -l ~/Developer/{*,*/*}/.git(N:h) | fzf --layout=reverse --height 40%)

  if [[ -n "$selected_dir" ]]; then
    cd "$selected_dir"
  fi
}

bindkey -s '^F' 'find_projects\n'

# Clone into ~/Developer/{owner}/{repo} (lowercased) and cd there; cds straight in if it's already cloned.
# Accepts git@host:owner/repo.git, https://host/owner/repo[/tree/...], or owner/repo (GitHub).
# GitHub repos are cloned over SSH. Extra args go to git clone: grab owner/repo --depth 1
GRAB_BASE="$HOME/Developer"
function grab() {
  local url="$1"
  if [[ -z "$url" ]]; then
    echo "Usage: grab <git-url|owner/repo> [git clone args...]" >&2
    return 1
  fi
  shift

  local host="github.com" rest
  case "$url" in
    *://*) rest="${url#*://}"; rest="${rest#*@}"; host="${rest%%/*}"; rest="${rest#*/}" ;;
    *@*:*) rest="${url#*:}"; host="${url#*@}"; host="${host%%:*}" ;;
    */*)   rest="$url" ;;
    *)     echo "grab: can't parse '$url'" >&2; return 1 ;;
  esac

  local parts=("${(@s:/:)rest}")
  local owner="${parts[1]}" repo="${parts[2]%.git}"
  if [[ -z "$owner" || -z "$repo" ]]; then
    echo "grab: can't find owner/repo in '$url'" >&2
    return 1
  fi

  [[ "$host" == "github.com" ]] && url="git@github.com:$owner/$repo.git"
  local dest="$GRAB_BASE/${owner:l}/${repo:l}"

  if [[ -d "$dest/.git" ]]; then
    echo "already cloned: $dest"
  else
    mkdir -p "${dest:h}" && git clone "$@" "$url" "$dest" || return 1
  fi
  cd "$dest"
}
