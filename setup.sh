#!/bin/bash

if command -v apt-get &> /dev/null; then
    echo "APT is available. Installing dependencies..."
    sudo apt-get update
    sudo apt-get install -y \
        stow \
        zsh \
	make \
	gcc \

    sudo apt autoremove -y
    sudo apt clean

else
    echo "APT is not available on $(uname -s). Please install dependencies manually."
    exit 1
fi

echo "Installing Oh My Zsh..."
KEEP_ZSHRC=yes RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Homebrew..."
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing Homebrew packages..."
/home/linuxbrew/.linuxbrew/bin/brew bundle --file=./.config/homebrew/Brewfile

echo "Initializing Stow symlinks..."
backup_file() {
  local file="$1"
  # Check if file is not already a stow symlink
  if [ -e "$file" ] && [ ! -L "$file" ]; then
    mv "$file" "$file.bak"
  fi
}

backup_file ~/.bashrc 
backup_file ~/.zshrc 

# Create .config to avoid stow symlinking the directory itself
mkdir -p  ~/.config
/usr/bin/stow .


