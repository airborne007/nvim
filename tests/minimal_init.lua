-- tests/minimal_init.lua

-- Add lazy.nvim to runtime path
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Add project root to runtime path to load local modules
vim.opt.rtp:prepend(".")

-- Add installed plugins to rtp for testing
local data_path = vim.fn.stdpath("data")
vim.opt.rtp:prepend(data_path .. "/lazy/plenary.nvim")
vim.opt.rtp:prepend(data_path .. "/lazy/snacks.nvim")
vim.opt.rtp:prepend(data_path .. "/lazy/nvim-dap")
vim.opt.rtp:prepend(data_path .. "/lazy/nvim-dap-ui")
vim.opt.rtp:prepend(data_path .. "/lazy/nvim-dap-virtual-text")
vim.opt.rtp:prepend(data_path .. "/lazy/mason-nvim-dap.nvim")
vim.opt.rtp:prepend(data_path .. "/lazy/mason.nvim")
vim.opt.rtp:prepend(data_path .. "/lazy/nvim-nio")
vim.opt.rtp:prepend(data_path .. "/lazy/nvim-dap-go")
vim.opt.rtp:prepend(data_path .. "/lazy/nvim-dap-python")

-- Configure lazy.nvim to load necessary plugins for testing
local snacks_spec = require("plugin-config.snacks")
local dap_spec = require("plugin-config.dap")

require("lazy").setup({
  { "nvim-lua/plenary.nvim", lazy = false },
  snacks_spec[1],
  {
    "williamboman/mason.nvim",
    config = true,
  },
  dap_spec[1],
}, {
  defaults = { lazy = false },
})

-- Load keybindings
require("keybindings")