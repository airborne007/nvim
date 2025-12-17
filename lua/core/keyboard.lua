--[[
Keyboard and input settings module
]]

vim.opt.timeoutlen = 500      -- Keymap timeout in milliseconds
vim.opt.updatetime = 300      -- Time until auto-save and CursorHold event trigger

-- Cursor movement settings
vim.opt.whichwrap = "<,>,[,]" -- Allow arrow keys to move to the next line at the beginning/end of a line

-- Mouse support
vim.opt.mouse = "a"           -- Enable mouse support in all modes
