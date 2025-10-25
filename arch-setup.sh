#!/bin/bash

# Configuration setup script for Arch Linux environments.

# --- Helper Functions ---

backup_file() {
    # Add .bak suffix to existing common files (.bashrc, .zshrc, etc) to prevent our copies from
    # overwriting them if they are not already stow symlinks.
    local file="$1"
    local base_name=$(basename "$file")
    local parent_dir=$(dirname "$file")
    local backup_dir="$parent_dir/.bak"
    local backup_path="$backup_dir/$base_name"
    
    # If the file is not a symlink
    if [ ! -L "$file" ]; then
      echo "Backing up existing file/folder: $file -> $backup_path"
      mkdir -p "$backup_dir"
      mv "$file" "$backup_path"

    fi
}

# --- 1. Install System Dependencies via Pacman ---

echo "Installing core dependencies using pacman..."

# Update the system and install required packages.
# We use --noconfirm for non-interactive installation, which is suitable for scripts.
# Note: On Arch, it's generally good practice to run a full update (-Syyu) before installing new packages.

# Install dependencies: stow, zsh, make, and gcc (build tools)
sudo pacman -Syyu --noconfirm || { echo "Error syncing system. Continuing dependency install."; }
sudo pacman -S --noconfirm \
    stow \
    zsh \
    make \
    gcc \
    || { echo "Error: Failed to install core dependencies using pacman. Exiting."; exit 1; }

# --- 2. Install Oh My Zsh ---

echo "Installing Oh My Zsh..."
# KEEP_ZSHRC=yes preserves existing .zshrc (which is handled by backup_file later)
# RUNZSH=no prevents immediate switch to zsh shell
# CHSH=no prevents changing the default shell automatically
KEEP_ZSHRC=yes RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# --- 3. Homebrew Installation (Optional/Fallback) ---

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew (Linuxbrew)..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Attempt to source the Homebrew environment variables after install
    if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    elif [ -f "$HOME/.linuxbrew/bin/brew" ]; then
        eval "$($HOME/.linuxbrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew is already installed."
fi

# --- 4. Install Homebrew Packages ---

if command -v brew &> /dev/null; then
    echo "Installing Homebrew packages from Brewfile..."
    # Relying on `brew` being in PATH after the sourcing above
    brew bundle --file=./.config/homebrew/Brewfile
else
    echo "Warning: Homebrew not found in PATH. Skipping Brewfile install."
fi


# --- 5. Tmux Plugin Manager (TPM) Setup ---

TMUX_TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TMUX_TPM_DIR" ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "$TMUX_TPM_DIR"
else
    echo "Tmux Plugin Manager is already installed."
fi

# Install plugins. Assumes ~/.tmux.conf exists (via stow) and contains the TPM configuration.
if [ -f "$HOME/.tmux.conf" ]; then
    echo "Sourcing Tmux configuration and installing plugins..."
    tmux source-file "$HOME/.tmux.conf"
    # This command may require the user to press 'I' inside tmux, depending on their config.
    "$TMUX_TPM_DIR/bin/install_plugins"
else
    echo "Warning: ~/.tmux.conf not found. Skipping Tmux plugin installation."
fi


# --- 6. Stow Initialization ---

echo "Initializing Stow symlinks..."

# Run backup functions *before* stowing
backup_file "$HOME/.bashrc"
backup_file "$HOME/.zshrc"
backup_file "$HOME/.config/nvim"
backup_file "$HOME/.config/starship.toml"


# Create .config to avoid stow symlinking the directory itself
mkdir -p "$HOME/.config"

# Perform stowing
/usr/bin/stow .

echo "Setup complete. If you want Zsh as your default shell, you must run: 'chsh -s /bin/zsh'."

