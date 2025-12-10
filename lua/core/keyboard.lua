--[[
键盘与输入设置模块
]]

vim.opt.timeoutlen = 500      -- 键盘快捷键等待时间（毫秒）
vim.opt.updatetime = 300      -- 自动保存和CursorHold事件触发时间

-- 光标移动设置
vim.opt.whichwrap = "<,>,[,]" -- 允许在行首/行尾使用方向键移动到下一行

-- 鼠标支持
vim.opt.mouse = "a"           -- 启用所有模式的鼠标支持