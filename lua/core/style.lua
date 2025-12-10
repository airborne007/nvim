--[[
样式与颜色设置模块
]]

vim.opt.background = "dark"   -- 使用深色背景
vim.opt.termguicolors = true  -- 启用真彩色支持

-- 不可见字符显示
vim.opt.list = true           -- 显示不可见字符
vim.opt.listchars = {
  space = "·",  -- 空格显示为点
  tab = "··"    -- Tab显示为两个点
}