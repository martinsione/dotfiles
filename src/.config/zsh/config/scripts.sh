# Vercel AI Gateway auth for codex and Claude Code, from the per-machine
# secret store: Keychain on macOS, a systemd-creds encrypted file on Linux
# (bound to the machine's host key, so the .cred file is useless off-box and
# must be re-created after a reinstall).
#
# To store/update the key (get one at https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fapi-keys):
#   macOS: security add-generic-password -U -a "$USER" -s ANTHROPIC_AUTH_TOKEN -w '<key>'
#   Linux: mkdir -p ~/.config/claude && printf '%s' '<key>' | systemd-creds encrypt --user \
#            --name=anthropic_auth_token - ~/.config/claude/anthropic_auth_token.cred
# Then run `claude /logout` once so Claude Code drops any OAuth login, and make
# sure ANTHROPIC_BASE_URL points where you want (default in .zshrc, per-machine
# override in zsh/config/local.sh, e.g. https://ai-gateway.vercel.sh).
#
# These must be real exported vars, not wrapper functions or apiKeyHelper: the
# Codex desktop app reaches this machine over SSH and boots `codex app-server`
# through `$SHELL -l -i -c '... /bin/sh -c ...'` — exports survive into that
# /bin/sh, functions don't. Claude Code reads ANTHROPIC_AUTH_TOKEN directly
# (ANTHROPIC_API_KEY must stay unset/empty — it takes precedence).
#
# The "vercel" provider lives in ~/.codex/config.toml, which is NOT symlinked
# to the dotfiles because codex rewrites it with per-machine state (project
# trust levels, tui nux). On a new machine add to ~/.codex/config.toml
# (top-level keys before any [table]; note [profiles] / `profile =` were
# removed in codex 0.142, so the provider is set as the base default):
#   model_provider = "vercel"
#   model = "openai/gpt-5.5"
#
#   [model_providers.vercel]
#   name = "Vercel AI Gateway"
#   base_url = "https://ai-gateway.vercel.sh/v1"
#   env_key = "AI_GATEWAY_API_KEY"
#   wire_api = "responses"
#
# One-off fallback to the ChatGPT login: codex -c model_provider=openai -c model=gpt-5.5
# if [[ -z "$AI_GATEWAY_API_KEY" ]]; then
#   if [[ "$(uname)" == "Darwin" ]]; then
#     export AI_GATEWAY_API_KEY="$(security find-generic-password -a "$USER" -s ANTHROPIC_AUTH_TOKEN -w 2>/dev/null)"
#   else
#     export AI_GATEWAY_API_KEY="$(systemd-creds decrypt --user --name=anthropic_auth_token "$HOME/.config/claude/anthropic_auth_token.cred" - 2>/dev/null)"
#   fi
# fi
# export ANTHROPIC_AUTH_TOKEN="$AI_GATEWAY_API_KEY"

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
