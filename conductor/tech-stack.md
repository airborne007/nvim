# Tech Stack - Modern Neovim Configuration

## Core Components
- **Configuration Language**: **Lua** - Neovim's native and highly performant scripting language.
- **Plugin Manager**: **lazy.nvim** - A modern plugin manager for Neovim that focuses on performance and ease of use.
- **Parser Generator**: **nvim-treesitter** - Provides a structured way to interact with source code, enabling superior highlighting and navigation.

## Intelligent Coding & AI
- **Completion Engine**: **blink.cmp** - A high-performance completion engine.
- **Language Server Protocol (LSP)**: Integrated support for multiple languages:
    - **Go**: `gopls`
    - **Rust**: `rust-analyzer`
    - **Python**: `pylsp` / `pyright`
    - **Lua**: `lua-language-server`
    - **Bash**: `bashls`
    - **JSON**: `jsonls`
- **AI Integration**: **gemini-cli** - Seamless AI assistance for coding and analysis.

## User Interface & Navigation
- **Statusline**: **lualine.nvim** - A blazing fast and customizable statusline.
- **Bufferline**: **bufferline.nvim** - A modern tabs/bufferline.
- **File Explorer**: **nvim-tree.lua** - A fast and highly configurable file tree.
- **Fuzzy Finder**: **telescope.nvim** - A highly extendable fuzzy finder over lists.
- **Fast Navigation**: **flash.nvim** - Lightning-fast movement within the editor.
- **Keybinding UI**: **which-key.nvim** - Displays available keybindings in a popup.

## Utilities & Git
- **Git Integration**: **gitsigns.nvim** - Provides git decorations and hunk management.
- **Utility Suite**: **snacks.nvim** - A collection of high-quality utilities including a floating terminal and dashboard.
