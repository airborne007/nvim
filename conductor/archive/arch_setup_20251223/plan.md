# Implementation Plan: Arch Linux Setup Scripts

## Phase 1: Install Script Implementation
- [x] Task: Create `install.sh` skeleton
    - [x] Sub-task: Create file with shebang and execution permissions
    - [x] Sub-task: Implement `check_os` function to verify Arch Linux (or compatible)
- [x] Task: Implement Package Management Logic
    - [x] Sub-task: Implement `check_yay` function to detect or install `yay`
    - [x] Sub-task: Implement `install_packages` function for core dependencies (`neovim`, `git`, `make`, `gcc`, `ripgrep`, `fd`)
    - [x] Sub-task: Add language runtimes to `install_packages` (`go`, `rustup`, `python`, `nodejs`, `npm`)
    - [x] Sub-task: Add extra tools to `install_packages` (`python-pynvim`, `xclip`)
- [x] Task: Implement Configuration Deployment Logic
    - [x] Sub-task: Implement `backup_config` function to handle existing `~/.config/nvim`
    - [x] Sub-task: Implement `link_config` function to create symlink
- [x] Task: Finalize `install.sh`
    - [x] Sub-task: Add post-install instructions (echo message)
    - [x] Sub-task: Manual Verification: Run script in a dry-run or safe environment
- [x] Task: Conductor - User Manual Verification 'Phase 1' (Protocol in workflow.md)

## Phase 2: Uninstall Script Implementation
- [x] Task: Create `uninstall.sh` skeleton
    - [x] Sub-task: Create file with shebang and execution permissions
    - [x] Sub-task: Implement confirmation prompt function
- [x] Task: Implement Cleanup Logic
    - [x] Sub-task: Implement `remove_config` function (symlink/directory)
    - [x] Sub-task: Implement `remove_data` function (cache, state, share)
- [x] Task: Finalize `uninstall.sh`
    - [x] Sub-task: Manual Verification: Run script to verify cleanup
- [x] Task: Conductor - User Manual Verification 'Phase 2' (Protocol in workflow.md)

## Phase 3: Documentation
- [x] Task: Update README.md
    - [x] Sub-task: Add "Installation on Arch Linux" section
    - [x] Sub-task: Add usage instructions for `install.sh` and `uninstall.sh`
- [x] Task: Update README_zh-CN.md
    - [x] Sub-task: Add "Arch Linux 安装" section
    - [x] Sub-task: Add usage instructions for `install.sh` and `uninstall.sh` in Chinese
- [x] Task: Conductor - User Manual Verification 'Phase 3' (Protocol in workflow.md)
