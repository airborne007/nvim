--[[
Editor settings module
General editing options: history, file handling, search, indentation,
keyboard/input, folding, and completion.
]]

-- History & Encoding
vim.opt.history = 2000
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- File handling
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Keyboard & Input
vim.opt.timeoutlen = 500
vim.opt.updatetime = 300
vim.opt.whichwrap = "<,>,[,]"
vim.opt.mouse = "a"

-- Folding
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
vim.opt.pumheight = 10
vim.opt.wildmenu = true
vim.opt.shortmess:append("c")
