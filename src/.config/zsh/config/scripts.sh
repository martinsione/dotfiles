function find_projects() {
  local selected_dir=$(find ~/Developer \
    -type d \( -name node_modules -o -name build -o -name dist \) -prune \
    -o \( -name .git -prune -print \) \
    | sed 's/\/\.git$//' | fzf --layout=reverse --height 40%)
  
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
