--[[
视觉与界面设置模块
]]

-- 光标移动时周围保留的行数
vim.opt.scrolloff = 4      -- 垂直方向
vim.opt.sidescrolloff = 4  -- 水平方向

-- 行号设置
vim.opt.number = true          -- 显示绝对行号
vim.opt.relativenumber = true  -- 显示相对行号

-- 光标与列设置
vim.opt.cursorline = true      -- 高亮当前行
vim.opt.signcolumn = "yes"      -- 始终显示左侧符号列
vim.opt.colorcolumn = "120"     -- 右侧120列参考线

-- 换行设置
vim.opt.wrap = false           -- 禁止自动换行