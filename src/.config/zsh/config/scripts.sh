function find_projects() {
  local selected_dir=$(find ~/Developer \
    -type d \( -name node_modules -o -name build -o -name dist \) -prune \
    -o \( -name .git -prune -print \) \
    | sed 's/\/\.git$//' | fzf)
  
  if [[ -n "$selected_dir" ]]; then
    cd "$selected_dir"
  fi
}

bindkey -s '^F' 'find_projects\n'
