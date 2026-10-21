# Vercel AI Gateway key
# - Claude Code: settings.json apiKeyHelper reads it at request time from Keychain (macOS) or
#   systemd-creds (Linux, host-bound: re-create after a reinstall). To store/update:
#     macOS: security add-generic-password -U -a "$USER" -s ANTHROPIC_AUTH_TOKEN -w '<key>'
#     Linux: printf '%s' '<key>' | systemd-creds encrypt --user --name=anthropic_auth_token - \
#              ~/.config/claude/anthropic_auth_token.cred
# - codex: reads $AI_GATEWAY_API_KEY (env_key in ~/.codex/config.toml, not symlinked since codex
#   rewrites it), so export it from the untracked local.sh. It must be a real export: the Codex
#   desktop app boots `codex app-server` through `$SHELL -l -i -c ...`.

function find_projects() {
  local selected_dir=$(find ~/Developer \
    -type d \( -name node_modules -o -name build -o -name dist \) -prune \
    -o \( -name .git -prune -print \) \
    | while IFS= read -r git_path; do
      local repo_dir="${git_path%/.git}"
      git -C "$repo_dir" rev-parse --show-toplevel 2>/dev/null
    done \
    | sort -u \
    | fzf --layout=reverse --height 40%)
  
  if [[ -n "$selected_dir" ]]; then
    cd "$selected_dir"
  fi
}

bindkey -s '^F' 'find_projects\n'
