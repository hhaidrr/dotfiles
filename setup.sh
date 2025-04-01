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

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sudo chsh -s $(which zsh) $(whoami)
else
    echo "Oh My Zsh is already installed."
fi

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

echo "Installing Homebrew packages..."
~/linuxbrew/.linuxbrew/bin/brew bundle --file=./.config/homebrew/Brewfile

echo "Initializing Stow symlinks..."
/usr/bin/stow .


