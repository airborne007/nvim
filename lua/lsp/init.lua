-- 检测并加载mason
local status, mason = pcall(require, "mason")
if not status then
  vim.notify("Plugin `mason.nvim` not found")
  return
end

-- 检测并加载mason-lspconfig
local mason_lspconfig
status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
  vim.notify("Plugin `mason-lspconfig` not found")
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  },
  -- ~/.local/share/nvim/mason
  install_root_dir = vim.fn.stdpath("data") .. "/mason",
})

-- Install List
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
-- { key: lsp_name, value: lsp_config }
local servers = {
  gopls = require("lsp.gopls"),
  pylsp = require("lsp.pylsp"),
  rust_analyzer = require("lsp.rust"),
  lua_ls = require("lsp.lua"),
  bashls = require("lsp.bashls"),
  jsonls = require("lsp.jsonls"),
  -- buf_ls = require("lsp.bufls"),
}

local ensure_installed = { type = "list" }
for name, _ in pairs(servers) do
  table.insert(ensure_installed, name)
end

mason_lspconfig.setup({
  ensure_installed = ensure_installed,
  automatic_enable = false,
})

-- 加载配置
for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
