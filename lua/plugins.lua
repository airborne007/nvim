--[[
Plugin configuration file
Uses lazy.nvim as the plugin manager
Plugins are grouped by function for readability and maintainability
--]]

-- ============================================
-- Lazy.nvim Plugin Manager Configuration
-- ============================================
-- Automatically install Lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Latest stable version
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize Lazy.nvim and configure plugins
require("lazy").setup({
  -- ============================================
  -- Plugin Manager Itself
  -- ============================================
  {
    'folke/lazy.nvim',
    version = "*",
  },

  -- ============================================
  -- Basic Dependency Plugins
  -- ============================================
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
    description = "General utility library developed for Neovim Lua",
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    description = "Provides icon support for various plugins",
  },

  -- ============================================
  -- Themes & Appearance
  -- ============================================  
  -- Themes
  { 'navarasu/onedark.nvim' },
  { 'sainnhe/everforest' },
  { 'ellisonleao/gruvbox.nvim' },
  { 'folke/tokyonight.nvim' },

  -- ============================================
  -- UI Components
  -- ============================================
  require('plugin-config.nvim-tree'),  -- File explorer
  require('plugin-config.bufferline'), -- Buffer tabline
  require('plugin-config.lualine'),    -- Status line
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
        opts = {
          terminal = { 
            enabled = true,
            win = {
              position = "float",
              backdrop = 60, -- 背景变暗程度 (0-100)
              width = 0.8,   -- 屏幕宽度的 80%
              height = 0.8,  -- 屏幕高度的 80%
              border = "rounded",
              wo = {
                winblend = 15, -- 窗口透明度 (0-100)，15 是比较舒适的半透明
              },
            },
          },
          bigfile = { enabled = true },      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  {
    'kevinhwang91/nvim-bqf',
    description = "Enhanced quickfix window",
  },
  require("plugin-config/sentiment"), -- Scrollbar enhancement

  -- ============================================
  -- Editing Enhancements
  -- ============================================
  require('plugin-config.nvim-autopairs'), -- Automatic parenthesis completion
  {
    'echasnovski/mini.comment',
    version = '*',
    opts = {},
  },        -- Code commenting
  require('plugin-config.flash'),          -- Quick jump
  require('plugin-config.trouble'),        -- Diagnostics list
  {
    'machakann/vim-sandwich',
    description = "Enhanced surrounding operations for brackets, quotes, etc.",
    keys = {'s', 'ds', 'cs'},
  },

  -- ============================================
  -- Git Tools
  -- ============================================
  require('plugin-config.gitsigns'),        -- Git status indicator

  -- ============================================
  -- Fuzzy Search
  -- ============================================
  require('plugin-config.telescope'),      -- Fuzzy search tool

  -- ============================================
  -- Syntax Parsing
  -- ============================================
  require('plugin-config.nvim-treesitter'), -- Syntax highlighting and parsing
  -- { "p00f/nvim-ts-rainbow", description = "Rainbow parentheses" },

  -- ============================================
  -- LSP Related
  -- ============================================
  {
    "williamboman/mason.nvim",
    description = "Package manager for LSP servers and tools",
    build = ":MasonUpdate",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    description = "Bridge between Mason and lspconfig",
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    'neovim/nvim-lspconfig',
    description = "Neovim built-in LSP client configuration",
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = { "williamboman/mason-lspconfig.nvim" },
  },

  -- ============================================
  -- Auto-completion
  -- ============================================
  require('plugin-config.blink-cmp'),       -- Auto-completion UI
  require("plugin-config.which-key"),      -- Key-hint

  -- ============================================
  -- AI Assistance
  -- ============================================
  require('plugin-config.gemini-cli'),      -- Gemini AI integration
  require('plugin-config.windsurf'),        -- Code completion
})