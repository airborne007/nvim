--[[
缩进与制表符设置模块
]]

-- 制表符宽度
vim.opt.tabstop = 4           -- Tab字符宽度为4个空格
vim.opt.softtabstop = 4       -- 编辑时Tab字符的宽度
vim.opt.shiftwidth = 4        -- 缩进宽度为4个空格
vim.opt.expandtab = true      -- 将Tab转换为空格
vim.opt.shiftround = true     -- 缩进时使用整数倍的shiftwidth

-- 自动缩进设置
vim.opt.autoindent = true     -- 新行继承上一行的缩进
vim.opt.smartindent = true    -- 根据语法智能缩进