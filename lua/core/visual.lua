--[[
Visual and UI settings module
]]

-- Number of lines to keep around the cursor when scrolling
vim.opt.scrolloff = 4      -- Vertical direction
vim.opt.sidescrolloff = 4  -- Horizontal direction

-- Line number settings
vim.opt.number = true          -- Show absolute line numbers
vim.opt.relativenumber = true  -- Show relative line numbers

-- Cursor and column settings
vim.opt.cursorline = true      -- Highlight the current line
vim.opt.signcolumn = "yes"      -- Always show the sign column on the left
vim.opt.colorcolumn = "120"     -- Show a ruler at column 120

-- Wrap settings
vim.opt.wrap = false           -- Disable automatic wrapping

-- Startup settings
vim.opt.shortmess:append("I") -- Hide the introductory message on startup