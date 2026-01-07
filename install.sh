#!/bin/bash

# Configuration
OS_RELEASE_FILE="${OS_RELEASE_FILE:-/etc/os-release}"
NVIM_CONFIG_DIR="${NVIM_CONFIG_DIR:-$HOME/.config/nvim}"
BASEDIR=$(pwd)

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_os() {
    if [ ! -f "$OS_RELEASE_FILE" ]; then
        log_error "Cannot determine OS. $OS_RELEASE_FILE not found."
        exit 1
    fi

    source "$OS_RELEASE_FILE"
    
    # Check for Arch Linux or derivatives (often ID_LIKE contains arch)
    if [[ "$ID" == "arch" || "$ID_LIKE" == *"arch"* ]]; then
        log_info "Detected Arch Linux compatible system: $NAME"
    else
        log_error "This script is intended for Arch Linux and derivatives only."
        log_error "Detected: $NAME ($ID)"
        exit 1
    fi
}

check_paru() {
    if command -v paru >/dev/null 2>&1; then
        log_info "paru is already installed."
    else
        log_info "paru not found. Installing paru from AUR..."
        if [ "$DRY_RUN" = "true" ]; then
            log_info "[DRY-RUN] Would install paru"
            return
        fi
        
        sudo pacman -S --needed --noconfirm base-devel git
        
        local temp_dir=$(mktemp -d)
        git clone https://aur.archlinux.org/paru.git "$temp_dir"
        cd "$temp_dir"
        makepkg -si --noconfirm
        cd - >/dev/null
        rm -rf "$temp_dir"
    fi
}

install_packages() {
    local packages=(
        # Core
        neovim make gcc ripgrep fd
        # Runtimes
        go rustup python nodejs npm
        # Extras
        python-pynvim xclip wl-clipboard
    )

    log_info "Installing dependencies..."
    if [ "$DRY_RUN" = "true" ]; then
        log_info "[DRY-RUN] Would run: paru -S --needed --noconfirm ${packages[*]}"
        return
    fi
    
    paru -S --needed --noconfirm "${packages[@]}"
}

backup_config() {
    if [ -e "$NVIM_CONFIG_DIR" ] || [ -L "$NVIM_CONFIG_DIR" ]; then
        local timestamp=$(date +%Y%m%d_%H%M%S)
        local backup_dir="${NVIM_CONFIG_DIR}.bak_${timestamp}"
        log_info "Backing up existing configuration to $backup_dir"
        
        if [ "$DRY_RUN" = "true" ]; then
            log_info "[DRY-RUN] Would rename $NVIM_CONFIG_DIR to $backup_dir"
            return
        fi
        
        mv "$NVIM_CONFIG_DIR" "$backup_dir"
    fi
}

link_config() {
    log_info "Linking configuration to $NVIM_CONFIG_DIR"
    if [ "$DRY_RUN" = "true" ]; then
        log_info "[DRY-RUN] Would symlink $BASEDIR to $NVIM_CONFIG_DIR"
        return
    fi
    
    mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"
    ln -s "$BASEDIR" "$NVIM_CONFIG_DIR"
}

main() {
    check_os
    check_paru
    install_packages
    backup_config
    link_config
    
    log_info "Installation complete! Please open Neovim to initialize plugins."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
