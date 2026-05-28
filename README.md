# Setup MacOS from a clean install

1. Set up SSH keys for github

```bash

ssh-keygen -t ed25519 -C <email>

# Add this to https://github.com/settings/keys
pbcopy < ~/.ssh/id_ed25519.pub

```

2. Clone repo and symlink files

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/martinsione/dotfiles/refs/heads/macos/install/x/macos.sh)"
```

3. Install packages
   a App Store - Bitwarden (so that safari can use web extension)
   b Homebrew

```bash

# Install executable
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# After installation, make it executable
echo >> /Users/$USER/.zprofile echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$USER/.zprofile eval "$(/opt/homebrew/bin/brew shellenv)"

```

```bash

brew install --cask \
    1password \
    cursor \
    discord \
    font-jetbrains-mono-nerd-font \
    font-zed-mono \
    ghostty \
    google-chrome \
    raycast \
    slack \
    spotify \
    whatsapp \
    zed \
    zoom

brew install \
    eza \
    fnm \
    neovim \
    ripgrep \
    starship \
    tmux

```

4. UI/UX tweaks
   - Add ⌃ + number to switch desktops
      1. Create 9 desktops
      2. Go to System Preferences > Keyboard > Keyboard Shortcuts > Mission Control > Mission Control (enable all)
   - Replace Spotlight with Raycast
      - Enable "Magnet" preset for window management
   - Remap CAPS Lock to Control. (Settings > Keyboard > Keyboard Shortcuts)
   - Increase mouse and trackpad speed

```bash

# Prefer tabs when opening documents -> Always
defaults write NSGlobalDomain AppleWindowTabbingMode -string always

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Disable all hot corners
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-br-corner -int 0

# Apply Dock changes
killall Dock

# Set key repeat rate to maximum (fastest)
defaults write -g KeyRepeat -int 1

# Set initial delay before repetition to minimum (no delay)
defaults write -g InitialKeyRepeat -int 10

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false
```
