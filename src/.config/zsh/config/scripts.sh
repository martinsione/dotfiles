# Codex → Vercel AI Gateway. The key comes from the same per-machine secret
# store that Claude Code's apiKeyHelper reads (Keychain on macOS, systemd-creds
# on Linux; see ~/.claude/get-auth-token.sh for how to store it).
#
# The "vercel" provider/profile lives in ~/.codex/config.toml, which is NOT
# symlinked to the dotfiles because codex rewrites it with per-machine state
# (project trust levels, tui nux). On a new machine add to ~/.codex/config.toml:
#   profile = "vercel"                      # top-level, makes it the default
#
#   [model_providers.vercel]
#   name = "Vercel AI Gateway"
#   base_url = "https://ai-gateway.vercel.sh/v1"
#   env_key = "AI_GATEWAY_API_KEY"
#   wire_api = "responses"
#
#   [profiles.vercel]
#   model_provider = "vercel"
#   model = "openai/gpt-5.5"
codex() {
  AI_GATEWAY_API_KEY="${AI_GATEWAY_API_KEY:-$(~/.claude/get-auth-token.sh)}" command codex "$@"
}

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

aleph() {
  if ! tmux has-session -t aleph 2>/dev/null; then
    tmux split-pane
    tmux split-pane
    tmux select-layout even-vertical

    tmux select-pane -t 0
    tmux send-keys 'cd ~/Developer/aleph/monorepo && yarn start:gs-addin:dev' C-m
    tmux select-pane -t 0
    tmux rename-window 'monorepo'

    tmux select-pane -t 1
    tmux send-keys 'cd ~/Developer/aleph/server && npm run start:dev' C-m
    tmux select-pane -t 1
    tmux rename-window 'server'

    tmux select-pane -t 2
    tmux send-keys 'cd ~/Developer/aleph/url-service && npm run start:dev' C-m
    tmux select-pane -t 2
    tmux rename-window 'url-service'
  fi
  # Attach to the session
  tmux attach-session -t aleph
}

# aleph() {
#     # Start a new tmux session named 'aleph'
#     tmux new-session -d -s aleph
#
#     # Split the window into three panes
#     tmux split-window -h  # Create a vertical split
#     tmux split-window -v  # Split the first pane horizontally
#     tmux select-pane -t 0
#     tmux split-window -v  # Split the second pane horizontally
#
#     # Name each pane accordingly
#     tmux select-pane -t 0
#     tmux send-keys 'cd ~/Developer/aleph/monorepo && yarn start:gs-addin:dev' C-m
#     tmux select-pane -t 0
#     tmux rename-window 'monorepo'
#
#     tmux select-pane -t 1
#     tmux send-keys 'cd ~/Developer/aleph/server && npm run start:dev' C-m
#     tmux select-pane -t 1
#     tmux rename-window 'server'
#
#     tmux select-pane -t 2
#     tmux send-keys 'cd ~/Developer/aleph/url-service && npm run start:dev' C-m
#     tmux select-pane -t 2
#     tmux rename-window 'url-service'
#   fi
#   # Attach to the session
#   tmux attach-session -t aleph
# }
