--[[
UI settings module
Visual, style, command-line, and window layout options.
]]

-- Visual
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "120"
vim.opt.wrap = false
vim.opt.shortmess:append("I")

-- Style
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.listchars = { space = "·", tab = "··" }

-- Command line
vim.opt.cmdheight = 1
vim.opt.showmode = false
vim.opt.showtabline = 2

-- Window splits
vim.opt.splitbelow = true
vim.opt.splitright = true
