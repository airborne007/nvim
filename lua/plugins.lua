--[[
插件配置文件
使用 lazy.nvim 作为插件管理器
插件按功能分组管理，提高可读性和可维护性
--]]

-- ============================================
-- Lazy.nvim 插件管理器配置
-- ============================================
-- 自动安装 Lazy.nvim 插件管理器
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 最新稳定版本
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 初始化 Lazy.nvim 并配置插件
require("lazy").setup({
  -- ============================================
  -- 插件管理器自身
  -- ============================================
  {
    'folke/lazy.nvim',
    version = "*",
  },

  -- ============================================
  -- 基础依赖插件
  -- ============================================
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
    description = "Neovim Lua 开发的通用工具库",
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    description = "为各种插件提供图标支持",
  },

  -- ============================================
  -- 主题与外观
  -- ============================================  
  require('plugin-config.themery'), -- 主题切换工具
  require('plugin-config.alpha'),   -- 启动界面

  -- ============================================
  -- UI 组件
  -- ============================================
  require('plugin-config.nvim-tree'),  -- 文件资源管理器
  require('plugin-config.bufferline'), -- 缓冲区标签栏
  require('plugin-config.lualine'),    -- 状态栏
  {
    "numToStr/FTerm.nvim",
    description = "浮动终端",
  },
  {
    'kevinhwang91/nvim-bqf',
    description = "增强的快速修复窗口",
  },
  require("plugin-config/sentiment"), -- 滚动条增强

  -- ============================================
  -- 编辑增强
  -- ============================================
  require('plugin-config.nvim-autopairs'), -- 自动括号补全
  require('plugin-config.comment'),        -- 代码注释
  require('plugin-config.flash'),          -- 快速跳转
  require('plugin-config.trouble'),        -- 诊断列表
  {
    'hrsh7th/vim-vsnip',
    description = "代码片段引擎",
    event = 'InsertEnter',
  },
  {
    'rafamadriz/friendly-snippets',
    description = "通用代码片段集合",
    event = 'InsertEnter',
  },
  {
    'machakann/vim-sandwich',
    description = "括号、引号等环绕操作增强",
    keys = {'s', 'ds', 'cs'},
  },

  -- ============================================
  -- Git 工具
  -- ============================================
  require('plugin-config.gitsigns'),        -- Git 状态指示器
  require('plugin-config.advanced-git-search'), -- 高级 Git 搜索

  -- ============================================
  -- 模糊搜索
  -- ============================================
  require('plugin-config.telescope'),      -- 模糊搜索工具

  -- ============================================
  -- 语法解析
  -- ============================================
  require('plugin-config.nvim-treesitter'), -- 语法高亮与解析
  -- { "p00f/nvim-ts-rainbow", description = "彩虹括号" },

  -- ============================================
  -- LSP 相关
  -- ============================================
  {
    "williamboman/mason.nvim",
    description = "LSP 服务器和工具的包管理器",
    build = ":MasonUpdate",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    description = "Mason 和 lspconfig 的桥接",
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    'neovim/nvim-lspconfig',
    description = "Neovim 内置 LSP 客户端配置",
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = { "williamboman/mason-lspconfig.nvim" },
  },

  -- ============================================
  -- 自动补全
  -- ============================================
  require('plugin-config.blink-cmp'),       -- 自动补全界面
  require("plugin-config.which-key"),      -- 按键提示

  -- ============================================
  -- AI 辅助
  -- ============================================
  require('plugin-config.gemini-cli'),      -- Gemini AI 集成
  require('plugin-config.windsurf'),        -- 代码补全
})

