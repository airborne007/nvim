-- 插件安装目录
-- ~/.local/share/nvim/lazy/lazy.nvim
-- 自动安装 Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Lazy can manage itself
  'folke/lazy.nvim',

  -- Dependency required by other plugins
  'nvim-lua/plenary.nvim',
  'nvim-tree/nvim-web-devicons',

  -- Colorscheme
  'navarasu/onedark.nvim',
  'sainnhe/everforest',
  'ellisonleao/gruvbox.nvim',
  'folke/tokyonight.nvim',

  -- UI
  require('plugin-config.nvim-tree'),
  require('plugin-config.bufferline'),
  require('plugin-config.lualine'),
  "numToStr/FTerm.nvim",
  'kevinhwang91/nvim-bqf',
  require("plugin-config/sentiment"),

  -- Edit
  require('plugin-config.nvim-autopairs'),
  require('plugin-config.comment'),
  require('plugin-config.flash'),
  require('plugin-config.trouble'),
  require('plugin-config.marks'),
  'hrsh7th/vim-vsnip',
  'rafamadriz/friendly-snippets',
  -- 'Exafunction/codeium.vim',
  'machakann/vim-sandwich',

  -- Git
  require('plugin-config.gitsigns'),

  -- Fuzzy Search
  require('plugin-config.telescope'),

  -- treesitter
  require('plugin-config.nvim-treesitter'),
  -- use("p00f/nvim-ts-rainbow")

  -- LSP
  { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  { 'neovim/nvim-lspconfig' },

  -- Autocomplete
  require('plugin-config.nvim-cmp'),
  require("plugin-config.which-key"),
  'hrsh7th/cmp-vsnip',
})
