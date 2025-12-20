--[[
Plugin configuration entry point
Uses lazy.nvim as the plugin manager.
Plugin specifications are modularized and automatically imported from the 'lua/plugin-config/' directory.
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
  -- Import All Configurations
  -- ============================================
  -- This will automatically load any file returning a plugin spec 
  -- in the lua/plugin-config/ directory.
  { import = "plugin-config" },

})