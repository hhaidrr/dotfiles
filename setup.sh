#!/bin/bash

if command -v apt-get &> /dev/null; then
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

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    # Install Oh My Zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if ! command -v brew &> /dev/null; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Homebrew packages
~/linuxbrew/.linuxbrew/bin/brew bundle --file=./.config/homebrew/Brewfile

# Initialize Symlinks
/usr/bin/stow .


