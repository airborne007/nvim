--[[
文件处理设置模块
]]

vim.opt.autoread = true       -- 文件被外部修改时自动重新读取
vim.opt.hidden = true         -- 允许隐藏未保存的缓冲区

-- 备份设置
vim.opt.backup = false        -- 禁止创建备份文件
vim.opt.writebackup = false   -- 写入文件时不创建备份
vim.opt.swapfile = false      -- 禁止创建交换文件