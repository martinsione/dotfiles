#!/usr/bin/env bash

set -euo pipefail

repo_url="https://github.com/martinsione/dotfiles.git"
dotfiles_dir="$HOME/Developer/martinsione/dotfiles"
symlinks=(
  src/.config/ghostty
  src/.config/git
  src/.config/nvim
  src/.config/tmux
  src/.config/zed
  src/.config/zsh
  src/.zshrc
)

# Colors for better visibility
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
log() {
    echo -e "${GREEN}[+]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[!]${NC} $1"
}

clone_repo() {
    # Clone repository if it doesn't exist
    if [ ! -d "$dotfiles_dir" ]; then
        log "Cloning dotfiles repository..."
        git clone "${repo_url}" "$dotfiles_dir"
    else
        log "Dotfiles directory already exists, skipping clone"
    fi

    # Change to dotfiles directory
    cd "$dotfiles_dir"

    # Update submodules
    log "Initializing and updating submodules..."
    git submodule update --init --recursive
}

create_symlink() {
    local src="$dotfiles_dir/$1"
    local dst="$HOME/${1#src/}"

    # Check if destination already exists
    if [ -L "$dst" ]; then
        local current_target=$(readlink "$dst")
        if [ "$current_target" = "$src" ]; then
            warn "Symlink already exists and points to correct target: $dst -> $src"
            return
        else
            warn "Symlink exists but points elsewhere, updating: $dst"
            rm "$dst"
        fi
    elif [ -e "$dst" ]; then
        warn "File/directory exists at $dst, removing..."
        rm -rf "$dst"
    fi

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$dst")"

    # Create symlink
    ln -sf "$src" "$dst"
    log "Created symlink: $dst -> $src"
}


# Clone repository
clone_repo

# Create symlinks
log "Creating symlinks..."
for link in "${symlinks[@]}"; do
    create_symlink "$link"
done

log "Installation complete! ✨"
