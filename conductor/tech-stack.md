# Tech Stack - Modern Neovim Configuration

## Core Components
- **Configuration Language**: **Lua** - Neovim's native and highly performant scripting language.
- **Plugin Manager**: **lazy.nvim** - A modern plugin manager for Neovim that focuses on performance and ease of use.
- **Parser Generator**: **nvim-treesitter** - Provides a structured way to interact with source code, enabling superior highlighting and navigation.
- **Testing Framework**: **plenary.nvim** - Used for unit testing Lua modules to ensure configuration reliability.

## Intelligent Coding
- **Completion Engine**: **blink.cmp** - A high-performance completion engine.
- **Language Server Protocol (LSP)**: Integrated support for multiple languages:
    - **Go**: `gopls`
    - **Rust**: `rust-analyzer`
    - **Python**: `pylsp` / `pyright`
    - **Lua**: `lua-language-server`
    - **Bash**: `bashls`
    - **JSON**: `jsonls`

## User Interface & Navigation
- **Statusline**: **lualine.nvim** - A blazing fast and customizable statusline.
- **Bufferline**: **bufferline.nvim** - A modern tabs/bufferline.
- **File Explorer**: **nvim-tree.lua** - A fast and highly configurable file tree.
- **Fuzzy Finder**: **Snacks.picker** - A fast and integrated fuzzy finder.
- **Fast Navigation**: **flash.nvim** - Lightning-fast movement within the editor.
- **Keybinding UI**: **which-key.nvim** - Displays available keybindings in a popup.
- **UI Framework**: **snacks.nvim** - Provides unified notification, input/select UI, and minimalist dashboard.

## Utilities & Git
- **Git Integration**: **gitsigns.nvim** - Provides git decorations and hunk management.
- **Utility Suite**: **snacks.nvim** - A collection of high-quality utilities including a floating terminal and optimized file handling (bigfile/quickfile).

## Setup & Automation
- **Installer**: **Bash Shell Script** - Automated dependency installation and configuration deployment for Arch Linux systems.
- **Package Management**: **pacman** & **yay** - Leveraging Arch Linux's native package manager and the Arch User Repository for seamless dependency resolution.