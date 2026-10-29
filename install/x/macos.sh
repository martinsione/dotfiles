#!/usr/bin/env bash

set -euo pipefail

repo_url="https://github.com/martinsione/dotfiles.git"
dotfiles_dir="$HOME/Developer/martinsione/dotfiles"
symlinks=(
  src/.claude/settings.json
  src/.config/ghostty
  src/.config/git
  src/.config/nvim
  src/.config/tmux
  src/.config/zed
  src/.config/zsh
  src/.local/bin/ai-gateway-key
  src/.ssh/config
  src/.zshrc
  src/Library/Application\ Support/Cursor/User/keybindings.json
  src/Library/Application\ Support/Cursor/User/settings.json
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

install_brew() {
    # Install Homebrew if not installed
    if ! command -v brew &>/dev/null; then
        log "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add brew to PATH for current and future sessions
        if [[ -f /opt/homebrew/bin/brew ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -f /usr/local/bin/brew ]]; then
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zprofile"
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        log "Homebrew already installed"
    fi

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


# pstack for the agents that read ~/.agents/skills (Codex, opencode, pi, fx), from the pinned submodule.
# Claude keeps the pstack plugin: a build of the same skills adapted to Claude Code (it doesn't read this folder).
link_skills() {
    local src_dir="$dotfiles_dir/src/.agents/vendor/cursor-plugins/pstack/skills"
    local dst_dir="$HOME/.agents/skills"
    local backup="$HOME/.agents/skills-backup-$(date +%Y%m%d%H%M%S)"
    mkdir -p "$dst_dir"
    for skill in "$src_dir"/*/; do
        skill="${skill%/}"
        local dst="$dst_dir/$(basename "$skill")"
        # Move stale copies out of the folder, or agents load them as extra skills
        if [ -e "$dst" ] && [ ! -L "$dst" ]; then
            mkdir -p "$backup" && mv "$dst" "$backup/"
            warn "Moved old copy of $(basename "$skill") to $backup"
        fi
        ln -sfn "$skill" "$dst"
    done
    log "Linked $(ls "$src_dir" | wc -l | tr -d ' ') pstack skills into $dst_dir"
}

# Parse flags
install_deps_flag=false
for arg in "$@"; do
    case "$arg" in
        --install-deps) install_deps_flag=true ;;
    esac
done

# Homebrew brings git (via the Command Line Tools), so it goes before the clone
if $install_deps_flag; then
    install_brew
fi

clone_repo

if $install_deps_flag; then
    log "Installing brew packages..."
    brew bundle --file="$dotfiles_dir/install/packages/macos/Brewfile"
fi

# Create symlinks
log "Creating symlinks..."
for link in "${symlinks[@]}"; do
    create_symlink "$link"
done

# One AGENTS.md for every coding agent, linked where each reads its global instructions
for dst in .claude/CLAUDE.md .codex/AGENTS.md .config/opencode/AGENTS.md .pi/agent/AGENTS.md; do
    create_symlink src/.agents/AGENTS.md "$HOME/$dst"
done
# fx refuses symlinked instruction files, so it gets a copy (refreshed on every run of this script)
[ -L "$HOME/.fx/AGENTS.md" ] && rm "$HOME/.fx/AGENTS.md"
mkdir -p "$HOME/.fx" && cp "$dotfiles_dir/src/.agents/AGENTS.md" "$HOME/.fx/AGENTS.md"
log "Copied AGENTS.md to $HOME/.fx/AGENTS.md"

link_skills

log "Installation complete! ✨"
