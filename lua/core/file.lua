--[[
File handling settings module
]]

vim.opt.autoread = true       -- Automatically re-read file if modified externally
vim.opt.hidden = true         -- Allow hidden unsaved buffers

-- Backup settings
vim.opt.backup = false        -- Do not create backup files
vim.opt.writebackup = false   -- Do not create a backup when writing a file
vim.opt.swapfile = false      -- Do not create swap files
