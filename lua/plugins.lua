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
  require('plugin-config.themery'), -- Theme switcher

  -- ============================================
  -- UI Components
  -- ============================================
  require('plugin-config.nvim-tree'),  -- File explorer
  require('plugin-config.bufferline'), -- Buffer tabline
  require('plugin-config.lualine'),    -- Status line
  {
    "numToStr/FTerm.nvim",
    description = "Floating terminal",
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
  require('plugin-config.comment'),        -- Code commenting
  require('plugin-config.flash'),          -- Quick jump
  require('plugin-config.trouble'),        -- Diagnostics list
  {
    'hrsh7th/vim-vsnip',
    description = "Code snippet engine",
    event = 'InsertEnter',
  },
  {
    'rafamadriz/friendly-snippets',
    description = "Collection of common code snippets",
    event = 'InsertEnter',
  },
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