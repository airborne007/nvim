--[[
Indentation and tab settings module
]]

-- Tab width
vim.opt.tabstop = 4           -- Tab character width is 4 spaces
vim.opt.softtabstop = 4       -- Width of a tab character when editing
vim.opt.shiftwidth = 4        -- Indentation width is 4 spaces
vim.opt.expandtab = true      -- Convert tabs to spaces
vim.opt.shiftround = true     -- Use multiples of shiftwidth when indenting

-- Auto-indent settings
vim.opt.autoindent = true     -- New lines inherit the indentation of the previous line
vim.opt.smartindent = true    -- Smart indentation based on syntax
