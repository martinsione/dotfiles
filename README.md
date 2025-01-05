# Setup MacOS from a clean install

1. Set up SSH keys for github

``` bash

ssh-keygen -t ed25519 -C <email>

# Add this to https://github.com/settings/keys
pbcopy < ~/.ssh/id_ed25519.pub

```

2. Clone repo and symlink files
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/martinsione/dotfiles/refs/heads/macos/install/x/macos.sh)"
```

3. Install packages
	a App Store
		- Bitwarden (so that safari can use web extension)
	b Homebrew
```bash

# Install executable
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# After installation, make it executable
echo >> /Users/martin/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/martin/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

```

```bash

brew install --cask \
	cursor \
	ghostty \
	google-chrome \
	raycast \
	spotify \
	zed

brew install \
	eza \
	neovim \
	ripgrep \
	starship

```

4. UI/UX tweaks
	- Disable hot corners
	- Automatically hide and show the Dock
	- Remap CAPS Lock to Control. (Settings > Keyboard >  Keyboard Shortcuts)
	- Increase mouse and trackpad speed
	- Increase Key Repetition Speed and Remove Delay
```bash

# Set key repeat rate to maximum (fastest)
defaults write -g KeyRepeat -int 1

# Set initial delay before repetition to minimum (no delay)
defaults write -g InitialKeyRepeat -int 10

```
  - Replace Spotlight with Raycast
    * Enable "Magnet" preset for window management
