#!/bin/bash

# Configuration setup script for Arch Linux environments.

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

echo "Installing user programs via pacman..."

# Update the system and install required packages.
# We use --noconfirm for non-interactive installation, which is suitable for scripts.
# Note: On Arch, it's generally good practice to run a full update (-Syyu) before installing new packages.

sudo pacman -Syyu --noconfirm || { echo "Error syncing system. Continuing dependency install."; }
sudo pacman -S --noconfirm \
    base-devel \
    zsh \
    tmux \
    stow \
    wget \
    git \
    neovim \
    fd \
    fzf \
    ripgrep \
    zoxide \
    eza \
    starship \
    xclip \
    direnv \
    github-cli \
    glab \
    fnm \
    bitwarden
    || { echo "Error: Failed to install core dependencies using pacman. Exiting."; exit 1; }

# --- AUR Helper Installation (yay) ---

if ! command -v yay &> /dev/null; then
    echo "Installing yay (AUR helper)..."
    # Create a temporary directory for building yay
    mkdir -p /tmp/yay-build
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-build/yay-bin
    cd /tmp/yay-build/yay-bin || exit
    makepkg -si --noconfirm
    cd - || exit
    rm -rf /tmp/yay-build
else
    echo "yay is already installed."
fi


# --- Install AUR Packages ---
echo "Installing AUR packages..."
yay -S --noconfirm \
    brave-bin \
    dbeaver

# --- Tmux Plugin Manager (TPM) Setup ---

TMUX_TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TMUX_TPM_DIR" ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "$TMUX_TPM_DIR"
else
    echo "Tmux Plugin Manager is already installed."
fi


# --- 6. Stow Initialization ---

echo "Initializing Stow symlinks..."

# Run backup functions *before* stowing
backup_file "$HOME/.bashrc"
backup_file "$HOME/.zshrc"
backup_file "$HOME/.config/nvim"
backup_file "$HOME/.config/starship.toml"
backup_file "$HOME/.config/alacritty/alacritty.toml"
backup_file "$HOME/.config/hypr/bindings.conf"
backup_file "$HOME/.config/hypr/hypridle.conf"
backup_file "$HOME/.config/hypr/looknfeel.conf"
backup_file "$HOME/.config/waybar/config.jsonc"
backup_file "$HOME/.config/waybar/style.css"


# Create .config to avoid stow symlinking the directory itself
mkdir -p "$HOME/.config"

# Perform stowing
/usr/bin/stow .

# Install tmux plugins. Assumes ~/.tmux.conf exists (via stow) and contains the TPM configuration.
if [ -f "$HOME/.tmux.conf" ]; then
    echo "Sourcing Tmux configuration and installing plugins..."
    tmux source-file "$HOME/.tmux.conf"
    # This command may require the user to press 'I' inside tmux, depending on their config.
    "$TMUX_TPM_DIR/bin/install_plugins"
else
    echo "Warning: ~/.tmux.conf not found. Skipping Tmux plugin installation."
fi

echo "Setup complete. If you want Zsh as your default shell, you must run: 'chsh -s /bin/zsh'."


