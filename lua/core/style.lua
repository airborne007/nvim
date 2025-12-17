--[[
Style and color settings module
]]

vim.opt.background = "dark"   -- Use a dark background
vim.opt.termguicolors = true  -- Enable true color support

-- Display of invisible characters
vim.opt.list = true           -- Show invisible characters
vim.opt.listchars = {
  space = "·",  -- Show spaces as dots
  tab = "··"    -- Show tabs as two dots
}
