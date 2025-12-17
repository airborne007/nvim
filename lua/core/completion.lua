--[[
Completion settings module
]]

vim.opt.completeopt = {"menu", "menuone", "noselect", "noinsert"}  -- Completion options
vim.opt.pumheight = 10        -- Maximum height of the completion menu
vim.opt.wildmenu = true       -- Enhanced command-line completion
vim.opt.shortmess:append("c") -- Do not pass messages to the completion menu
