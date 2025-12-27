--[[
LSP configuration main file
Manages LSP servers using mason.nvim and mason-lspconfig
--]]

-- ============================================
-- Plugin Dependencies
-- ============================================

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")


-- ============================================
-- Mason Basic Configuration
-- ============================================

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",  -- Installed icon
      package_pending = "➜",     -- Installing icon
      package_uninstalled = "✗"   -- Uninstalled icon
    },
    border = "rounded",            -- UI border style
    keymaps = {
      toggle_package_expand = "<CR>",
      install_package = "i",
      update_package = "u",
      check_package_version = "c",
      update_all_packages = "U",
      check_outdated_packages = "C",
      uninstall_package = "X",
      cancel_installation = "<C-c>",
      apply_language_filter = "f",
    },
  },
  -- Installation root directory
  -- Default path: ~/.local/share/nvim/mason
  install_root_dir = vim.fn.stdpath("data") .. "/mason",
  -- Number of concurrent downloads
  max_concurrent_installers = 4,
})


-- ============================================
-- Language Server Configuration
-- ============================================

-- List of language servers
-- Format: { server_name = config_file_path }
local server_configs = {
  gopls = require("lsp.gopls"),      -- Go language server
  pylsp = require("lsp.pylsp"),      -- Python language server
  rust_analyzer = require("lsp.rust"), -- Rust language server
  lua_ls = require("lsp.lua"),       -- Lua language server
  bashls = require("lsp.bashls"),    -- Bash language server
  jsonls = require("lsp.jsonls"),    -- JSON language server
  -- buf_ls = require("lsp.bufls"),    -- Protocol Buffers language server (commented out)
}

-- Extract server names to install
local servers_to_install = {}
for server_name, _ in pairs(server_configs) do
  table.insert(servers_to_install, server_name)
end


-- ============================================
-- Mason-LSPConfig Configuration
-- ============================================

mason_lspconfig.setup({
  ensure_installed = servers_to_install, -- Ensure these servers are installed
  automatic_installation = true,         -- Automatically install servers not in the list
  -- Automatically enable servers (not recommended, manual configuration is suggested)
  automatic_enable = false,
})


-- ============================================
-- Load Language Server Configuration
-- ============================================

local lsp_utils = require("lsp.utils")

for server_name, server_config in pairs(server_configs) do
  -- Ensure config table exists
  server_config = server_config or {}

  -- Add default on_attach function
  if not server_config.on_attach then
    server_config.on_attach = lsp_utils.on_attach
  end

  -- Load server configuration
  local ok, err = pcall(function()
      vim.lsp.config(server_name, server_config)
      vim.lsp.enable(server_name)
  end)

  if not ok then
    vim.notify(
      string.format("Failed to load LSP server %s configuration: %s", server_name, err),
      vim.log.levels.ERROR
    )
  end
end