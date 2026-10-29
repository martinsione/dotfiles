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


# Vendored skills, from the pinned submodules. Each vendor gets one folder: ~/.agents/skills/<vendor> links to
# its plugin build, so its skills sit at <vendor>/skills/<skill> and their ../../docs links resolve inside it.
# pi, opencode and Codex find skills that deep (Codex reads the plugin manifest and names them <vendor>:<skill>).
# fx only looks one level down and ignores symlinks inside ~/.fx, so it gets flat links in ~/.claw/skills, a root
# only fx reads. Claude installs each vendor as a plugin instead, which gives it the <vendor>:<skill> names.
link_vendor() {
    local name="$1" build="$2"
    local backup="$HOME/.agents/skills-backup-$(date +%Y%m%d%H%M%S)"
    local entry skill
    mkdir -p "$HOME/.agents/skills" "$HOME/.claw/skills"
    # Drop flat links from before vendors had their own folder
    for entry in "$HOME/.agents/skills"/* "$HOME/.fx/skills"/* "$HOME/.claw/skills"/*; do
        [ -L "$entry" ] && [ "$(readlink "$entry")" = "$build/skills/$(basename "$entry")" ] && rm "$entry"
    done
    for f in docs README.md; do
        [ -L "$HOME/.agents/$f" ] && [ "$(readlink "$HOME/.agents/$f")" = "$build/$f" ] && rm "$HOME/.agents/$f"
    done
    if [ -e "$HOME/.agents/skills/$name" ] && [ ! -L "$HOME/.agents/skills/$name" ]; then
        mkdir -p "$backup" && mv "$HOME/.agents/skills/$name" "$backup/"
        warn "Moved old $name folder to $backup"
    fi
    ln -sfn "$build" "$HOME/.agents/skills/$name"
    for skill in "$build"/skills/*/; do
        skill="${skill%/}"
        ln -sfn "$skill" "$HOME/.claw/skills/$(basename "$skill")"
    done
    log "Linked $name ($(ls "$build/skills" | wc -l | tr -d ' ') skills) into ~/.agents/skills/$name and ~/.claw/skills"
}

# Claude: register a vendor submodule as a plugin marketplace and install a plugin from it
install_claude_plugin() {
    local marketplace="$1" plugin="$2" vendor="$3"
    if ! command -v claude &>/dev/null; then
        warn "claude not on PATH; later run: claude plugin marketplace add $vendor && claude plugin install $plugin@$marketplace"
        return
    fi
    claude plugin marketplace add "$vendor" &>/dev/null || claude plugin marketplace update "$marketplace" &>/dev/null
    claude plugin install "$plugin@$marketplace" &>/dev/null
    # `marketplace add` writes this machine's absolute path into the shared settings.json; keep it portable
    perl -pi -e 's|"\Q$ENV{HOME}\E(/Developer/martinsione/dotfiles/src/\.agents/vendor/)|"~$1|' \
        "$dotfiles_dir/src/.claude/settings.json"
    log "Installed $plugin@$marketplace in Claude"
}

# Your own skills (src/.agents/skills/<skill>), linked flat for every agent: ~/.agents/skills (pi, opencode,
# Codex), ~/.claw/skills (fx) and ~/.claude/skills (Claude). A real folder of the same name is moved aside first.
link_own_skills() {
    local backup="$HOME/.agents/skills-backup-$(date +%Y%m%d%H%M%S)"
    local skill root dst
    for skill in "$dotfiles_dir"/src/.agents/skills/*/; do
        skill="${skill%/}"
        for root in "$HOME/.agents/skills" "$HOME/.claw/skills" "$HOME/.claude/skills"; do
            mkdir -p "$root"
            dst="$root/$(basename "$skill")"
            if [ -e "$dst" ] && [ ! -L "$dst" ]; then
                mkdir -p "$backup" && mv "$dst" "$backup/$(basename "$(dirname "$root")")-$(basename "$skill")"
                warn "Moved old $dst to $backup"
            fi
            ln -sfn "$skill" "$dst"
        done
    done
    log "Linked $(ls "$dotfiles_dir/src/.agents/skills" | wc -l | tr -d ' ') own skills for every agent"
}

link_skills() {
    local vendor="$dotfiles_dir/src/.agents/vendor"
    link_vendor pstack "$vendor/cursor-plugins/harness/pstack/claude-code"
    install_claude_plugin cursor-plugins pstack "$vendor/cursor-plugins"
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
for dst in .claude/CLAUDE.md .codex/AGENTS.md .config/opencode/AGENTS.md .pi/agent/AGENTS.md; do
    create_symlink src/.agents/AGENTS.md "$HOME/$dst"
done
# fx refuses symlinked instruction files, so it gets a copy (refreshed on every run of this script)
[ -L "$HOME/.fx/AGENTS.md" ] && rm "$HOME/.fx/AGENTS.md"
mkdir -p "$HOME/.fx" && cp "$dotfiles_dir/src/.agents/AGENTS.md" "$HOME/.fx/AGENTS.md"
log "Copied AGENTS.md to $HOME/.fx/AGENTS.md"

link_skills
link_own_skills

log "Installation complete! ✨"
