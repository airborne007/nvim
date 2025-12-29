# Modern Neovim Configuration

[中文文档](README_zh-CN.md)

A highly modular, feature-rich, and blazing fast Neovim configuration crafted for efficiency. Built with [lazy.nvim](https://github.com/folke/lazy.nvim), it features full LSP support, Git management, and a polished UI.

## ✨ Features

- **⚡ Performance:** Blazing fast startup time optimized by `lazy.nvim`.
- **🧩 Modular Architecture:** Clean code structure, easy to customize and extend.
- **🧠 Intelligent Coding:**
    - Full **LSP** support (Go, Rust, Python, Lua, Bash, JSON).
    - **DAP** integration (Go with Delve, Python with Debugpy) for professional debugging.
    - **Blink.cmp** for high-performance auto-completion.
    - **Treesitter** for better syntax highlighting and code navigation.
    - **Trouble.nvim** for organized diagnostics.

- **🔍 Navigation:**
    - **Snacks.picker** for fuzzy finding files, text, and buffers.
    - **Snacks.picker.explorer** for file system exploration.
    - **Flash.nvim** for lightning-fast movement.
- **🛡️ Git Integration:**
    - **Gitsigns** for inline blame, hunk preview/stage/reset.
    - Custom **Git History** viewer.
- **💻 Terminal:** **Snacks.nvim** floating terminal for quick command-line access.
- **🎨 UI:** Aesthetic interface with modern **lualine** (global status, LSP info), **bufferline**, and **which-key** support.

## 🛠️ Prerequisites

Before installing, ensure you have the following requirements:

- **Neovim** >= **0.9.0** (Recommended: 0.10.0+)
- **Git** (for plugin management)
- **Ripgrep** (required for Snacks.picker live grep)
- **Nerd Font** (recommended for icons)
- **C Compiler** (gcc/clang, required for Treesitter parsers)
- **Language Servers:**
    - **Go:** `gopls` and `delve` (for debugging)
    - **Python:** `pylsp`/`pyright` and `debugpy` (for debugging)
    - **Rust:** `rust-analyzer`
    - **Lua:** `lua-language-server`
    - **Node.js:** (required for some LSPs like `bashls`, `jsonls`)

## 🚀 Installation

### Arch Linux (Recommended)

If you are on Arch Linux or its derivatives (Manjaro, EndeavourOS, etc.), you can use the provided setup script to install all dependencies and the configuration automatically:

```bash
git clone https://github.com/airborne007/nvim.git ~/projects/nvim
cd ~/projects/nvim
make install
```

The script will:
- Check for or install `yay` (AUR helper).
- Install all necessary system packages (Neovim, LSPs, Runtimes, etc.).
- Backup your existing `~/.config/nvim` if it exists.
- Link the configuration to `~/.config/nvim`.

To uninstall:
```bash
make uninstall
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

### 📋 Clipboard Support

Neovim needs external tools to communicate with the system clipboard (`"+y`, `"+p`).

- **Linux (X11):** `xclip` or `xsel` (Installed automatically by the script)
- **Linux (Wayland):** `wl-clipboard` (Installed automatically by the script)
- **WSL2:** Please refer to [wsl-clipboard](https://github.com/memoryInject/wsl-clipboard) for syncing with Windows.

## ⌨️ Keybindings

The Leader key is set to **Space**.

### 📂 File Management

| Key | Description |
| :--- | :--- |
| `<F3>` | Toggle File Explorer (Snacks Explorer) |
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

### 🌳 Code Selection (Treesitter)

| Key | Description |
| :--- | :--- |
| `<Enter>` | Incremental Selection (Expand) |
| `<Backspace>` | Shrink Selection |

### 🌯 Surround (nvim-surround)

| Key | Description |
| :--- | :--- |
| `ys{motion}{char}` | Add surround (e.g. `ysiw"`) |
| `ds{char}` | Delete surround (e.g. `ds"`) |
| `cs{old}{new}` | Change surround (e.g. `cs"'`) |
| `gS{char}` | Add surround (Visual mode) |

### 🐞 Debugging (DAP)

| Key | Description |
| :--- | :--- |
| `<F5>` | Start / Continue |
| `<F9>` | Toggle Breakpoint |
| `<F10>` | Step Over |
| `<F11>` | Step Into |
| `<F12>` | Step Out |
| `<Leader>du` | Toggle Debug UI |
| `<Leader>dt` | Terminate Session |

### 🛡️ Git

| Key | Description |
| :--- | :--- |
| `]c` / `[c` | Next / Previous Hunk |
| `<Leader>gl` | Show Git History (File in Normal / Line in Visual) |
| `<Leader>gs` | Show Git Status (Snacks) |
| `<Leader>gp` | Preview Hunk |
| `<Leader>gS` | Stage Hunk |
| `<Leader>gr` | Reset Hunk |
| `<Leader>gb` | Blame Line |

### ⚡ Others

| Key | Description |
| :--- | :--- |
| `<Alt-d>` | Toggle Floating Terminal |
| `s` | Flash Jump (Fast navigation) |
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
