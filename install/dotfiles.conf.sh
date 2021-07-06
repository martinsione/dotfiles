export repo_host="https://github.com"
export repo_path="/martinsione/dotfiles"
export repo_branch="master"
export dotfiles_dir="$HOME/.dotfiles"
export symlinks_file="${dotfiles_dir}/links.conf"

_symlinks=(
  .config/git
  .config/htop
  .config/kitty
  .config/luaformatter
  .config/nvim
  .config/ranger
  .config/tmux
  .config/zsh
  .zprofile
)

_dirs=(
  ~/Documents
  ~/Downloads
  ~/Pictures
  ~/Workspace
  ~/.cache/zsh
)

