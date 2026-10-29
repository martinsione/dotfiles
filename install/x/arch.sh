#!/usr/bin/env bash
# Set up an Arch machine (the devbox): packages with --install-deps, then clone and symlink.

set -euo pipefail

repo_url="https://github.com/martinsione/dotfiles.git"
dotfiles_dir="$HOME/Developer/martinsione/dotfiles"
packages_dir="$dotfiles_dir/install/packages/arch"
# Headless box: no ghostty/zed/Cursor, and ssh config stays the Mac's (it describes how to reach this box)
symlinks=(
  src/.claude/settings.json
  src/.config/git
  src/.config/nvim
  src/.config/tmux
  src/.config/zsh
  src/.local/bin/ai-gateway-key
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

install_packages() {
    log "Installing pacman packages..."
    # shellcheck disable=SC2046 # one package per line
    sudo pacman -Syu --needed $(cat "$packages_dir/pacman.list")

    # paru builds from the AUR, so bootstrap it from source the first time (needs base-devel, in pacman.list)
    if ! command -v paru &>/dev/null; then
        log "Bootstrapping paru..."
        local tmp
        tmp="$(mktemp -d)"
        git clone https://aur.archlinux.org/paru.git "$tmp/paru"
        (cd "$tmp/paru" && makepkg -si)
        rm -rf "$tmp"
    fi

    log "Installing AUR packages..."
    # shellcheck disable=SC2046
    paru -S --needed $(cat "$packages_dir/aur.list")

    if [ "$(getent passwd "$USER" | cut -d: -f7)" != "/usr/bin/zsh" ]; then
        log "Making zsh the login shell..."
        chsh -s /usr/bin/zsh
    fi
}

# create_symlink <repo path> [destination, default: same path under $HOME]
create_symlink() {
    local src="$dotfiles_dir/$1"
    local dst="${2:-$HOME/${1#src/}}"

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
        local backup="$dst.bak.$(date +%Y%m%d%H%M%S)"
        warn "File/directory exists at $dst, moving it to $backup"
        mv "$dst" "$backup"
    fi

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$dst")"

    # Create symlink
    ln -sf "$src" "$dst"
    log "Created symlink: $dst -> $src"
}


# Parse flags
install_deps_flag=false
for arg in "$@"; do
    case "$arg" in
        --install-deps) install_deps_flag=true ;;
    esac
done

# A fresh Arch install may not have git yet
if $install_deps_flag && ! command -v git &>/dev/null; then
    sudo pacman -S --needed git
fi

clone_repo

if $install_deps_flag; then
    install_packages
fi

# Create symlinks
log "Creating symlinks..."
for link in "${symlinks[@]}"; do
    create_symlink "$link"
done

# One AGENTS.md for every coding agent, linked where each reads its global instructions
for dst in .claude/CLAUDE.md .codex/AGENTS.md .config/opencode/AGENTS.md .pi/agent/AGENTS.md .fx/AGENTS.md; do
    create_symlink src/.agents/AGENTS.md "$HOME/$dst"
done

log "Installation complete! ✨"
