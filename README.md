# Neovim Configuration Guide

This is a modern Neovim configuration with a modular design, written in Lua, providing a great user experience and an efficient development environment.

## Configuration Features

- **Modular Structure**: Grouped by functionality for easy maintenance and extension.
- **Modern Lua API**: Uses new features and APIs from Neovim 0.11+.
- **Efficient Plugin Management**: Plugin loading system based on Lazy.nvim.
- **Optimized User Experience**: Well-designed keybindings and auto-commands.
- **Customizability**: Clear configuration structure, easy to adjust and extend.

## Requirements

- **Neovim Version**: Latest stable version (0.11+ recommended).
- **Font**: Nerd Font recommended for icon support.
- **System**: Supports Linux, macOS, and Windows (WSL).

## Directory Structure

```
~/.config/nvim/
├── init.lua              # Configuration entry point
├── README.md             # This documentation file
├── LICENSE               # License file
├── .gitignore            # Git ignore file
└── lua/
    ├── basic.lua         # Basic configuration (editor behavior, UI, etc.)
    ├── plugins.lua       # Plugin configuration (loading and management)
    ├── keybindings.lua   # Key mappings
    ├── auto-command.lua  # Auto-command configuration
    ├── core/             # Modular core configuration components
    │   ├── clipboard.lua     # Clipboard configuration
    │   ├── command.lua       # Command-line configuration
    │   ├── completion.lua    # Auto-completion configuration
    │   ├── config.lua        # Core configuration management
    │   ├── extension.lua     # Extension mechanism
    │   ├── file.lua          # File handling configuration
    │   ├── folding.lua       # Code folding configuration
    │   ├── history.lua       # History configuration
    │   ├── hot_reload.lua    # Configuration hot-reload feature
    │   ├── indent.lua        # Indentation configuration
    │   ├── keyboard.lua      # Keyboard settings
    │   ├── search.lua        # Search configuration
    │   ├── security.lua      # Security protection mechanism
    │   ├── style.lua         # Style and color configuration
    │   ├── visual.lua        # Visual effects configuration
    │   └── window.lua        # Window management configuration
    ├── extensions/       # User extensions directory
    │   └── example.lua   # Example extension
    ├── lsp/              # LSP language server configuration
    │   ├── init.lua      # Main LSP configuration
    │   ├── bashls.lua    # Bash language server
    │   ├── bufls.lua     # Buffer language server
    │   ├── gopls.lua     # Go language server
    │   ├── jsonls.lua    # JSON language server
    │   ├── lua.lua       # Lua language server
    │   ├── pylsp.lua     # Python language server
    │   └── rust.lua      # Rust language server
    └── plugin-config/    # Plugin configuration directory
        ├── advanced-git-search.lua  # Advanced Git search configuration
        ├── alpha.lua                 # Startup screen configuration
        ├── blink-cmp.lua             # Auto-completion configuration
        ├── bufferline.lua            # Bufferline tab configuration
        ├── comment.lua               # Code comment configuration
        ├── flash.lua                 # Quick jump configuration
        ├── gemini-cli.lua            # Gemini AI integration configuration
        ├── gitsigns.lua              # Git status indicator configuration
        ├── lualine.lua               # Status bar configuration
        ├── nvim-autopairs.lua        # Auto-pairs configuration
        ├── nvim-tree.lua             # File explorer configuration
        ├── nvim-treesitter.lua       # Syntax highlighting configuration
        ├── sentiment.lua             # Scrollbar enhancement configuration
        ├── telescope.lua             # Fuzzy search configuration
        ├── themery.lua               # Theme switcher configuration
        ├── trouble.lua               # Diagnostics list configuration
        ├── which-key.lua             # Key-hint configuration
        └── windsurf.lua              # Window navigation enhancement configuration
```

## Configuration File Descriptions

### 1. init.lua
The entry point of the configuration, which loads modules in order:
```lua
-- Modular core configuration
require('core.config').setup()

-- Core extension module
require('core.extension')

-- Hot-reload feature
require('core.hot_reload').setup()

-- Security protection mechanism
require('core.security').setup()

-- Plugin management
require('plugins')

-- Load user extensions
-- If the extensions directory exists, load all extensions
local extensions_dir = vim.fn.stdpath('config') .. '/lua/extensions'
if vim.loop.fs_stat(extensions_dir) then
  for _, file in ipairs(vim.fn.readdir(extensions_dir)) do
    if file:match('%.lua$') then
      local extension_name = file:gsub('%.lua$', '')
      pcall(require, 'extensions.' .. extension_name)
    end
  end
end

-- Key mappings
require('keybindings')

-- LSP configuration
require('lsp')

-- Auto-commands
require("auto-command")
```

### 2. basic.lua
Contains basic Neovim settings, grouped by function:
- **History & Encoding**: Command history length, UTF-8 encoding.
- **Visual & UI**: Line numbers, cursor highlighting, sign column, guides.
- **Indentation & Tabs**: Tab width, auto-indent, smart-indent.
- **Search**: Case-insensitive search, smart search, incremental search.
- **Command-line & UI**: Command-line height, tab bar display.
- **File Handling**: Auto-read, hidden buffers, backup settings.
- **Keyboard & Input**: Key-press delay, mouse support.
- **Window & Splitting**: Window splitting direction.
- **Completion**: Completion menu settings.
- **Style & Color**: Dark background, true color support, invisible character display.
- **Code Folding**: Folding method, fold level.
- **Clipboard**: System clipboard integration.
- **WSL Specific Settings**: Windows Subsystem for Linux adaptations.

**Note**: The configuration in `basic.lua` has also been split into modular core components (located in `lua/core/`), which can be managed and loaded uniformly via `core.config`.

### 3. plugins.lua
Manages all plugins using Lazy.nvim, grouped by function:
- Plugin manager itself
- Basic dependency plugins
- Themes & Appearance
- UI Components
- Editing Enhancements
- Git Tools
- Fuzzy Search
- Syntax Parsing
- LSP Related
- Auto-completion
- AI Assistance

### 4. keybindings.lua
Defines all custom keybindings, grouped by function:
- Basic editing shortcuts
- Window management shortcuts
- Plugin shortcuts (nvim-tree, bufferline, telescope, etc.)

### 5. auto-command.lua
Manages auto-commands, grouped by function:
- Yank highlight group
- Cursor line management group
- File position memory group
- File update detection group
- Temporary file handling group
- Format options setting group
- Language-specific settings group
- File type detection group
- WSL specific settings group

### 6. lsp/init.lua
LSP language server configuration, managed with Mason and mason-lspconfig:
- Supported language servers: gopls, pylsp, rust_analyzer, lua_ls, bashls, jsonls
- Automatic installation and configuration
- Default on_attach function (binds LSP shortcuts)

### 7. plugin-config/
Individual configuration files for each plugin, using a uniform style for easy management and extension.

## Installation and Usage

1. Ensure Neovim 0.11+ is installed.
2. Back up your existing Neovim configuration (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```
3. Clone or copy this configuration to `~/.config/nvim/`.
4. Start Neovim, and Lazy.nvim will automatically install the required plugins:
   ```bash
   nvim
   ```
5. Wait for the plugin installation to complete, and you're ready to go.

## Main Plugins

### Plugin Manager
- **Lazy.nvim**: A modern plugin manager supporting lazy loading, auto-installation, and updates.

### Syntax & LSP
- **nvim-treesitter**: Syntax highlighting and parsing, supporting multiple programming languages.
- **nvim-lspconfig**: LSP client configuration, providing code completion, diagnostics, and refactoring.
- **mason.nvim**: LSP server and tool installer, simplifying LSP setup.
- **mason-lspconfig.nvim**: Bridge between Mason and lspconfig, automatically configuring LSP servers.

### Auto-completion
- **blink.cmp**: High-performance completion, supporting multiple completion sources.
- **vim-vsnip**: Code snippet engine.
- **friendly-snippets**: A collection of common code snippets.

### Search & Navigation
- **telescope.nvim**: Fuzzy search tool for files, buffers, commands, etc.
- **flash.nvim**: A quick jump plugin to improve editing efficiency.

### UI Components
- **nvim-tree.lua**: A file explorer for intuitive file navigation.
- **lualine.nvim**: A status line showing current file info, LSP status, etc.
- **bufferline.nvim**: A buffer tab bar for easy switching and management of multiple files.
- **FTerm.nvim**: A floating terminal for convenient command-line access.

### Git Tools
- **gitsigns.nvim**: Git status indicators showing line-level Git changes.
- **advanced-git-search.nvim**: Advanced Git search functionality.

### Editing Enhancements
- **nvim-autopairs**: Auto-completion for pairs of characters.
- **comment.nvim**: A code commenting tool.
- **vim-sandwich**: Enhanced surrounding operations for brackets, quotes, etc.
- **trouble.nvim**: A diagnostics list to centralize LSP diagnostic messages.

### AI Assistance
- **gemini-cli.nvim**: Gemini AI integration, providing code generation and explanation.

## Keybinding Reference

### Basic Keybindings
- `<Leader>w`: Save file
- `<Leader>q`: Close current window
- `<Leader>c`: Close current buffer
- `<C-h>`/`<C-j>`/`<C-k>`/`<C-l>`: Switch between windows

### Plugin Keybindings
- `<Leader>e`: Open/close file explorer
- `<Leader>ff`: Find files
- `<Leader>fg`: Find string
- `<Leader>fb`: Find buffers
- `<Leader>fh`: Find help documents

### LSP Keybindings
- `K`: Show documentation
- `gd`: Go to definition
- `gD`: Go to declaration
- `gi`: Go to implementation
- `go`: Go to type definition
- `gr`: Find references
- `<C-k>`: Show signature help
- `<F2>`: Rename
- `<F4>`: Code action
- `gl`: Show diagnostics

## Customization and Extension

### Adding a New Plugin
1. Add the plugin declaration in `plugins.lua`, including name, description, loading conditions, and dependencies.
2. (Optional) Create a plugin configuration file in the `plugin-config/` directory, using the standard format:

```lua
local M = {
  'plugin-name',
  -- Loading condition
  event = 'InsertEnter',
  -- Dependencies
  dependencies = { 'other-plugin' },
}

function M.config()
  -- Plugin configuration code
  require('plugin-name').setup({
    -- Configuration options
  })
end

return M
```

### Modifying Keybindings
Edit the `keybindings.lua` file, adding or modifying key mappings in the existing format:

```lua
-- Basic editing shortcuts
vim.keymap.set('n', '<Leader>w', '<cmd>w<CR>', { desc = 'Save file' })
```

### Modifying Basic Configuration
Edit the `basic.lua` file to change the corresponding configuration items. The settings are grouped by function for easy lookup and modification:

```lua
-- Line number settings
vim.opt.number = true          -- Show absolute line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
```

### Adding Auto-commands
Edit the `auto-command.lua` file to add new auto-command groups and commands:

```lua
-- File type specific settings
local filetype_grp = vim.api.nvim_create_augroup('user_filetype', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = filetype_grp,
  pattern = { 'lua', 'python' },
  callback = function()
    vim.opt_local.shiftwidth = 4
  end,
})
```

## Performance Optimization

### Plugin Loading Strategy
- **Lazy Loading**: All plugins are configured with explicit loading conditions (event/ft/keys) to reduce startup time.
- **On-demand Loading**: Plugins and their dependencies are loaded only when needed.
- **Group Management**: Plugins are grouped by function for easy management and optimization.

### Startup Performance Metrics
- Average startup time: < 300ms (depends on system performance and the number of installed plugins).
- Memory usage: ~50MB on startup, ~100-150MB when editing large files.

### Optimization Suggestions
- Regularly clean up unused plugins.
- Avoid using too many auto-commands and event listeners.
- Configure appropriate LSP server settings for large projects.

## Plugin Loading Conditions Explained

All plugins are configured with explicit loading conditions to improve startup performance:

- **event**: Load on a specific event (e.g., `InsertEnter`, `BufReadPre`).
- **ft**: Load when a specific file type is opened (e.g., `lua`, `python`).
- **keys**: Load when a specific key is pressed.
- **lazy**: Load only when explicitly called.

Example:
```lua
{
  'hrsh7th/vim-vsnip',
  event = 'InsertEnter', -- Load on entering insert mode
  description = "Code snippet engine",
}
```

## Troubleshooting

1. If you encounter errors on startup, check if your Neovim version meets the requirements.
2. View the plugin installation log: `:Lazy log`.
3. Check for syntax errors: `nvim --headless +qa`.
4. Disable some plugins to isolate the problem: comment out the plugin declaration in `plugins.lua`.

## Changelog

- **v2.0**: Complete refactoring to a modular Lua configuration.
- **v1.0**: Initial configuration based on Vimscript.

## License

MIT License