# Specification: Arch Linux Setup Scripts (install.sh & uninstall.sh)

## Overview
Add specialized shell scripts to automate the installation and removal of this Neovim configuration on Arch Linux systems. These scripts will ensure all system-level dependencies are met and handle the configuration directory setup/cleanup safely.

## Functional Requirements

### install.sh
1.  **System Validation**: Ensure the OS is Arch Linux (check `/etc/os-release`).
2.  **Package Manager Setup**: Detect if `yay` is installed; if not, attempt to install it.
3.  **Dependency Installation**: Use `yay -S --needed` to install:
    *   **Core**: `neovim`, `git`, `make`, `gcc`, `ripgrep`, `fd`.
    *   **Runtimes**: `go`, `rustup`, `python`, `nodejs`, `npm`.
    *   **Extras**: `python-pynvim`, `xclip` (for clipboard support).
4.  **Configuration Deployment**:
    *   Check for existing `~/.config/nvim`.
    *   If found, backup to `~/.config/nvim.bak_<timestamp>`.
    *   Create a symlink from the current directory to `~/.config/nvim`.
5.  **Post-Install**: Provide a clear message instructing the user to open Neovim to trigger `lazy.nvim` plugin synchronization.

### uninstall.sh
1.  **Interactive Cleanup**: Prompt the user before performing any deletions.
2.  **Configuration Removal**: Option to delete `~/.config/nvim` (the symlink/directory).
3.  **Data/State Removal**: Option to purge Neovim's data and cache directories:
    *   `~/.local/share/nvim`
    *   `~/.local/state/nvim`
    *   `~/.cache/nvim`

### README Update
1. Update `README.md` and `README_zh-CN.md` to include installation instructions using the new scripts.
2. Ensure the instructions are user-friendly and clear.

## Non-Functional Requirements
- **Idempotency**: `install.sh` should be safe to run multiple times without causing errors or duplicate backups.
- **Portability (within Arch)**: Work on standard Arch Linux and derivatives like Manjaro or EndeavourOS.
- **Error Handling**: Fail gracefully if package installation fails or permissions are insufficient.

## Acceptance Criteria
- [ ] `install.sh` correctly installs all listed packages via `yay`.
- [ ] `install.sh` successfully backups an existing config.
- [ ] `uninstall.sh` prompts user and removes local config/data directories.
- [ ] Both scripts have execution permissions.
- [ ] README files are updated and accurately reflect the new installation method.

## Out of Scope
- Support for other distributions (Ubuntu, Fedora, etc.).
- Automated plugin installation (`Lazy sync` is left to the user's first launch).
- System-wide uninstallation of packages installed by `install.sh`.
