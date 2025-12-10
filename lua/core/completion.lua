--[[
补全设置模块
]]

vim.opt.completeopt = {"menu", "menuone", "noselect", "noinsert"}  -- 补全选项
vim.opt.pumheight = 10        -- 补全菜单最大高度
vim.opt.wildmenu = true       -- 增强命令行补全
vim.opt.shortmess:append("c") -- 不将消息传递给补全菜单