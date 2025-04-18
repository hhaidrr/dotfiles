#!/bin/bash


backup_file() {
    # add .bak suffix to existing common files (.bashrc, .zshrc, etc) to prevent our copies from 
    # overwriting them
  local file="$1"
  # Check if file is not already a stow symlink
  if [ -e "$file" ] && [ ! -L "$file" ]; then
    mv "$file" "$file.bak"
  fi
}


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

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

echo "Installing Homebrew packages..."
/home/linuxbrew/.linuxbrew/bin/brew bundle --file=./.config/homebrew/Brewfile

echo "Installing Tmux Plugin Manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Sourcing Tmux configuration..."
tmux source-file ~/.tmux.conf
echo "Installing Tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins


echo "Initializing Stow symlinks..."

backup_file ~/.bashrc 
backup_file ~/.zshrc 

# Create .config to avoid stow symlinking the directory itself
mkdir -p  ~/.config
/usr/bin/stow .


