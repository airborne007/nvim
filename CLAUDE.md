# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

- **Run tests:** `make test` (uses plenary.nvim Busted-style tests)
- **Run install:** `make install` (Arch Linux only, installs deps via paru)
- **Run uninstall:** `make uninstall` (removes config + data dirs)
- **LSP/tools:** No standalone linter/formatter — all via LSP servers

## Architecture

This is a modular Neovim config managed by **lazy.nvim**.

### Startup order (`init.lua`)
1. `keybindings.lua` — sets `mapleader` to space (must be first)
2. `core.config.setup()` — loads 12 submodules (visual, indent, search, file, clipboard, etc.)
3. `core.extension` — plugin extension framework
4. `core.hot_reload.setup()` — `:ReloadConfig` / `:ReloadModule` commands
5. `core.security.setup()` — dangerous command blocking, file protection
6. `plugins` — lazy.nvim init, auto-imports all specs from `lua/plugin-config/`
7. `auto-command.lua` — autocommands (yank highlight, cursorline, etc.)

### Plugin config pattern
Each plugin gets its own file in `lua/plugin-config/`. Each file returns a lazy.nvim spec table (or list of tables). No manual `require` — lazy.nvim's `{ import = "plugin-config" }` auto-discovers them.

### LSP setup
- **Server configs:** `lua/lsp/` — one file per server (gopls, pylsp, rust_analyzer, lua_ls, bashls, jsonls)
- **Entry:** `lua/lsp/init.lua` initializes Mason + lspconfig, iterates and loads each server file
- **On-attach:** `lua/lsp/utils/init.lua` — shared keymaps (gd, gr, K, etc.) and format-on-save logic
- **Auto-format exclusion:** Python, Lua, JavaScript, TypeScript are excluded from auto-format on `BufWritePre`
- **Go special:** `OrgImports()` runs `gopls` import organization on `BufWritePre`

### DAP
- Debuggers: Go (Delve) and Python (debugpy via Mason)
- DAP UI auto-opens on session start, auto-closes on termination
- Keybindings: F5 (continue), F9 (toggle breakpoint), F10 (step over), F11 (step into), F12 (step out)

### Filetype indent overrides
`after/ftplugin/` — 2-space for CSS/HTML/JS/Lua/Ruby, 4-space for Python.

### Test structure
Tests live in `tests/` using plenary.nvim's Busted-style (`describe`/`it` blocks). Uses `tests/minimal_init.lua` as the minimal init for headless test runs.

### Key tools
- **Snacks.nvim** replaces Telescope, `vim.notify`, `vim.ui.input`, `vim.ui.select`, plus provides picker, terminal, lazygit, dashboard, statuscolumn
- **Flash.nvim** for fast navigation (sneak-like, `<leader>s`)
- **blink.cmp** for autocompletion
- **Windsurf** AI code completion via `windsurf.vim`
- **`:ThemeSwitch`** command cycles and persists colorscheme
