# Modern Neovim Configuration

[中文文档](README_zh-CN.md)

A highly modular, feature-rich, and blazing fast Neovim configuration crafted for efficiency. Built with [lazy.nvim](https://github.com/folke/lazy.nvim), it features full LSP support, Git management, and a polished UI.

## ✨ Features

- **⚡ Performance:** Blazing fast startup time optimized by `lazy.nvim`.
- **🧩 Modular Architecture:** Clean code structure, easy to customize and extend.
- **🧠 Intelligent Coding:**
    - Full **LSP** support (Go, Rust, Python, Lua, Bash, JSON).
    - **Blink.cmp** for high-performance auto-completion.
    - **Treesitter** for better syntax highlighting and code navigation.
    - **Trouble.nvim** for organized diagnostics.

- **🔍 Navigation:**
    - **Snacks.picker** for fuzzy finding files, text, and buffers.
    - **Nvim-tree** for file system exploration.
    - **Flash.nvim** for lightning-fast movement.
- **🛡️ Git Integration:**
    - **Gitsigns** for hunks management.
    - Custom **Git History** viewer.
- **💻 Terminal:** **Snacks.nvim** floating terminal for quick command-line access.
- **🎨 UI:** Aesthetic interface with `lualine`, `bufferline`, and `which-key` support.

## 🛠️ Prerequisites

Before installing, ensure you have the following requirements:

- **Neovim** >= **0.9.0** (Recommended: 0.10.0+)
- **Git** (for plugin management)
- **Ripgrep** (required for Snacks.picker live grep)
- **Nerd Font** (recommended for icons)
- **C Compiler** (gcc/clang, required for Treesitter parsers)
- **Language Servers:**
    - **Go:** `gopls`
    - **Python:** `pylsp` or `pyright`
    - **Rust:** `rust-analyzer`
    - **Lua:** `lua-language-server`
    - **Node.js:** (required for some LSPs like `bashls`, `jsonls`)

## 🚀 Installation

### Arch Linux (Recommended)

If you are on Arch Linux or its derivatives (Manjaro, EndeavourOS, etc.), you can use the provided setup script to install all dependencies and the configuration automatically:

```bash
git clone https://github.com/airborne007/nvim.git ~/projects/nvim
cd ~/projects/nvim
./install.sh
```

The script will:
- Check for or install `yay` (AUR helper).
- Install all necessary system packages (Neovim, LSPs, Runtimes, etc.).
- Backup your existing `~/.config/nvim` if it exists.
- Link the configuration to `~/.config/nvim`.

To uninstall:
```bash
./uninstall.sh
```

### Manual Installation (Other Distributions)

1.  **Backup your existing configuration:**

    ```bash
    mv ~/.config/nvim ~/.config/nvim.bak
    mv ~/.local/share/nvim ~/.local/share/nvim.bak
    mv ~/.local/state/nvim ~/.local/state/nvim.bak
    mv ~/.cache/nvim ~/.cache/nvim.bak
    ```

2.  **Clone the repository:**

    ```bash
    git clone https://github.com/airborne007/nvim.git ~/.config/nvim
    ```

3.  **Start Neovim:**

    ```bash
    nvim
    ```

    *Lazy.nvim will automatically install all plugins on the first launch. Restart Neovim after the installation is complete.*

## ⌨️ Keybindings

The Leader key is set to **Space**.

### 📂 File Management

| Key | Description |
| :--- | :--- |
| `<Leader>t` | Toggle File Explorer (Snacks Explorer) |
| `<Leader>e` | Find files (Snacks.picker) |
| `<Leader>f` | Grep text (Snacks.picker) |
| `<Leader>b` | Find buffers (Snacks.picker) |

### 🖥️ Window & Buffer

| Key | Description |
| :--- | :--- |
| `<Leader>h` / `<Leader>v` | Split window horizontal / vertical |
| `<Ctrl-h/j/k/l>` | Navigate windows |
| `<Leader>q` / `<Leader>w` | Previous / Next buffer |
| `<Leader>c` | Close current buffer |
| `sc` | Close current window |
| `so` | Close other windows |

### 🧠 LSP & Coding

| Key | Description |
| :--- | :--- |
| `gd` | Go to Definition |
| `gr` | Go to References |
| `K` | Hover Documentation |
| `<Leader>rn` | Rename symbol |
| `<Leader>a` | Code Action |
| `<Leader>=` | Format code |
| `<Leader>xx` | Toggle Diagnostics (Trouble) |

### 🛡️ Git

| Key | Description |
| :--- | :--- |
| `]c` / `[c` | Next / Previous Hunk |
| `<Leader>gh` | Show Git History |
| `<Leader>gs` | Show Git Status |

### ⚡ Others

| Key | Description |
| :--- | :--- |
| `<Alt-d>` | Toggle Floating Terminal |
| `<Leader>d` | Flash Jump (Fast navigation) |
| `<Leader><Space>` | Clear search highlight |

*Press `<Space>` (Leader) and wait a second to see the `which-key` menu for more available commands.*

## 🛠️ Development

### Running Tests

This configuration uses [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) for unit testing core logic.

To run all tests in headless mode:

```bash
make test
```

Tests are located in the `tests/` directory and follow the module structure of the `lua/` directory.

## 📂 Project Structure

```text
~/.config/nvim/
├── init.lua              # Entry point
├── lua/
│   ├── auto-command.lua  # Autocommands
│   ├── keybindings.lua   # Keymaps
│   ├── plugins.lua       # Lazy.nvim setup
│   ├── core/             # Core configurations (options, ui, etc.)
│   ├── extensions/       # Custom local extensions
│   ├── lsp/              # LSP server configurations
│   └── plugin-config/    # Plugin specifications & setups
```

## 📜 License

MIT
