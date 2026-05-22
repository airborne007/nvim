# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

- **Run all tests:** `make test` (uses plenary.nvim Busted-style tests)
- **Run a single test file:** `nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedDirectory tests/core/ { minimal_init = 'tests/minimal_init.lua' }"` (change directory path as needed)
- **Run install:** `make install` (Arch Linux only, installs deps via paru)
- **Run uninstall:** `make uninstall` (removes config + data dirs)
- **Dry-run install:** `DRY_RUN=true make install`
- **LSP/tools:** No standalone linter/formatter — all via LSP servers

## Architecture

This is a modular Neovim config managed by **lazy.nvim**.

### Startup order (`init.lua`)
1. `keybindings.lua` — sets `mapleader` to space (must be first)
2. `core.config.setup()` — loads 3 submodules: `editor`, `ui`, `clipboard`
3. `core.hot_reload.setup()` — `:ReloadConfig` / `:ReloadModule` commands
4. `plugins` — lazy.nvim init, auto-imports all specs from `lua/plugin-config/`
5. `extensions/` — autoloads all `.lua` files (e.g. `theme_manager.lua`)
6. `auto-command.lua` — autocommands (yank highlight, cursorline, etc.)

### Core modules (`lua/core/`)
| File | Responsibility |
|------|---------------|
| `config.lua` | Orchestrator, requires the other 4 modules |
| `editor.lua` | History, file handling, search, indent, keyboard, folding, completion |
| `ui.lua` | Visual/display options, style, command-line, window splits |
| `clipboard.lua` | `unnamedplus` + WSL-specific clipboard config |
| `hot_reload.lua` | `:ReloadConfig` / `:ReloadModule`, BufWritePost watchers |

### Plugin config pattern
Each plugin gets its own file in `lua/plugin-config/`. Each file returns a lazy.nvim spec table (or list of tables). No manual `require` — lazy.nvim's `{ import = "plugin-config" }` auto-discovers them. Keybindings are typically defined in the spec's `keys` table (lazy-loading) rather than in `lua/keybindings.lua`.

### LSP setup
- **Server configs:** `lua/lsp/` — one file per server (gopls, pylsp, rust_analyzer, lua_ls, bashls, jsonls; bufls commented out)
- **Entry:** `lua/lsp/init.lua` initializes Mason + mason-lspconfig, iterates and loads each server file
- **On-attach:** `lua/lsp/utils/init.lua` — shared keymaps (gd, gr, K, gD, gi, gh, go, gp/gn, `<leader>rn`, `<leader>a`, `<leader>=`) and format-on-save logic (`BufWritePre`)
- **Auto-format exclusion:** Python, Lua, JavaScript, TypeScript are excluded from auto-format
- **Go special:** `OrgImports()` runs `gopls` import organization on `BufWritePre`

### Filetype indent overrides
`after/ftplugin/` — 2-space for CSS/HTML/JS/Lua/Ruby, 4-space for Python.

### Test structure
Tests live in `tests/` using plenary.nvim's Busted-style (`describe`/`it` blocks). Uses `tests/minimal_init.lua` as the minimal init for headless test runs. Tests are organized mirroring `lua/` module structure:
- `tests/core/` — core module tests
- `tests/plugin_config/` — plugin configuration tests
- `tests/utils/` — utility tests

### Key tools
- **Snacks.nvim** — mega-plugin: picker (`<leader>e/f/b/s/sd/qf`), terminal (`<A-d>`), lazygit (`<leader>gg`), file explorer (`<F3>`), notifier, statuscolumn, indent guides
- **blink.cmp** — autocompletion (LSP/path/snippets/buffer sources) with inline autopair for `()`, `[]`, `{}`, quotes
- **Flash.nvim** — fast navigation: `s` for jump, `S` for treesitter jump
- **bufferline.nvim** — tabline with LSP diagnostics on tabs
- **lualine.nvim** — statusline (mode, git, diagnostics, LSP clients, python venv, location)
- **gitsigns.nvim** — git signs in signcolumn, hunk ops (`]c`/`[c`), blame (`<leader>gb`), hunk stage/reset
- **which-key.nvim** — keybinding popup (modern preset)
- **trouble.nvim** — diagnostics/quickfix/loclist panel (`<leader>xx/xw/xd/xq/xl/xr`)
- **Windsurf** — AI code completion via `windsurf.vim`
- **`:ThemeSwitch`** — cycles and persists colorscheme (tokyonight, onedark, everforest, gruvbox)
