local status, mason = pcall(require, "mason")
if not status then
  vim.notify("Plugin `mason.nvim` not found")
  return
end

local mason_lspconfig
status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
  vim.notify("Plugin `mason-lspconfig` not found")
  return
end

local lspconfig
status, lspconfig = pcall(require, "lspconfig")
if not status then
  vim.notify("Plugin `lspconfig` not found")
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
  install_root_dir = vim.env.VIM .. "/abc/mason",
})

-- Install List
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
-- { key: lsp_name, value: lsp_config }
local servers = {
  gopls = require("lsp.gopls"),
  pylsp = require("lsp.pylsp"),
  rust_analyzer = require("lsp.rust"),
  sumneko_lua = require("lsp.lua"),
  bashls = require("lsp.bashls"),
  vimls = require("lsp.vimls"),
  jsonls = require("lsp.jsonls"),
}

local ensure_installed = { type = "list" }
for name, _ in pairs(servers) do
  table.insert(ensure_installed, name)
end

mason_lspconfig.setup({
  ensure_installed = ensure_installed,
  automatic_installation = true,
})

-- 加载配置
for name, config in pairs(servers) do
  lspconfig[name].setup(config)
end
