# Vercel AI Gateway key: only ever read from the OS credential store by ai-gateway-key (src/.local/bin),
# never exported, so it doesn't leak into every process, shell snapshot or log.
# - Claude Code: settings.json apiKeyHelper runs ai-gateway-key per request
# - Codex: the kit provider's auth.command reads the same store (written by the Vercel app)
# - pi: ~/.pi/agent/auth.json has "key": "!$HOME/.local/bin/ai-gateway-key", so pi runs it itself
# - opencode, fx only read $AI_GATEWAY_API_KEY, so it's set for each run of them
for _agent in opencode fx; do
  eval "$_agent() { AI_GATEWAY_API_KEY=\"\$(ai-gateway-key)\" command $_agent \"\$@\" }"
done
unset _agent

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
