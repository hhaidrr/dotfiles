#!/bin/bash

if command -v apt-get &> /dev/null; then
    echo "APT is available. Installing dependencies..."
    sudo apt-get update
    sudo apt-get install -y \
        stow \
        zsh \

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
mv ~/.bashrc ~/.bashrc.bak
/usr/bin/stow .


