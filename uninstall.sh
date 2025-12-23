#!/bin/bash

# Configuration
NVIM_CONFIG_DIR="${NVIM_CONFIG_DIR:-$HOME/.config/nvim}"
NVIM_DATA_DIRS=(
    "${NVIM_SHARE_DIR:-$HOME/.local/share/nvim}"
    "${NVIM_STATE_DIR:-$HOME/.local/state/nvim}"
    "${NVIM_CACHE_DIR:-$HOME/.cache/nvim}"
)
YES_TO_ALL="${YES_TO_ALL:-false}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

confirm() {
    if [ "$YES_TO_ALL" = "true" ]; then
        return 0
    fi
    
    read -p "$1 [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

remove_config() {
    if [ -e "$NVIM_CONFIG_DIR" ] || [ -L "$NVIM_CONFIG_DIR" ]; then
        if confirm "Remove Neovim configuration at $NVIM_CONFIG_DIR?"; then
            log_info "Removing $NVIM_CONFIG_DIR"
            rm -rf "$NVIM_CONFIG_DIR"
        fi
    else
        log_info "No configuration found at $NVIM_CONFIG_DIR"
    fi
}

remove_data() {
    for dir in "${NVIM_DATA_DIRS[@]}"; do
        if [ -d "$dir" ]; then
            if confirm "Remove Neovim data directory at $dir?"; then
                log_info "Removing $dir"
                rm -rf "$dir"
            fi
        fi
    done
}

main() {
    log_warn "This script will remove your Neovim configuration and data."
    
    remove_config
    remove_data
    
    log_info "Uninstallation complete."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
