--[[
LSP 配置主文件
使用 mason.nvim 和 mason-lspconfig 管理 LSP 服务器
--]]

-- ============================================
-- 插件依赖
-- ============================================

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")


-- ============================================
-- Mason 基础配置
-- ============================================

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",  -- 已安装图标
      package_pending = "➜",     -- 安装中图标
      package_uninstalled = "✗"   -- 未安装图标
    },
    border = "rounded",            -- UI 边框样式
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
  -- 安装根目录
  -- 默认路径: ~/.local/share/nvim/mason
  install_root_dir = vim.fn.stdpath("data") .. "/mason",
  -- 并发下载数量
  max_concurrent_installers = 4,
})


-- ============================================
-- 语言服务器配置
-- ============================================

-- 语言服务器列表
-- 格式: { 服务器名称 = 配置文件路径 }
local server_configs = {
  gopls = require("lsp.gopls"),      -- Go 语言服务器
  pylsp = require("lsp.pylsp"),      -- Python 语言服务器
  rust_analyzer = require("lsp.rust"), -- Rust 语言服务器
  lua_ls = require("lsp.lua"),       -- Lua 语言服务器
  bashls = require("lsp.bashls"),    -- Bash 语言服务器
  jsonls = require("lsp.jsonls"),    -- JSON 语言服务器
  -- buf_ls = require("lsp.bufls"),    -- Protocol Buffers 语言服务器 (注释掉了)
}

-- 提取需要安装的服务器名称
local servers_to_install = {}
for server_name, _ in pairs(server_configs) do
  table.insert(servers_to_install, server_name)
end


-- ============================================
-- Mason-LSPConfig 配置
-- ============================================

mason_lspconfig.setup({
  ensure_installed = servers_to_install, -- 确保这些服务器被安装
  automatic_installation = true,         -- 自动安装不在列表中的服务器
  -- 自动启用服务器 (不推荐，建议手动配置)
  automatic_enable = false,
})


-- ============================================
-- 加载语言服务器配置
-- ============================================

-- 获取插件快捷键映射
local pluginKeys = require("keybindings")

for server_name, server_config in pairs(server_configs) do
  -- 确保配置表存在
  server_config = server_config or {}

  -- 添加默认的 on_attach 函数
  if not server_config.on_attach then
    server_config.on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      -- 设置 LSP 快捷键
      pluginKeys.maplsp(buf_set_keymap)
    end
  end

  -- 加载服务器配置
  local ok, err = pcall(function()
      vim.lsp.config(server_name, server_config)
      vim.lsp.enable(server_name)
  end)

  if not ok then
    vim.notify(
      string.format("LSP 服务器 %s 配置加载失败: %s", server_name, err),
      vim.log.levels.ERROR
    )
  end
end
