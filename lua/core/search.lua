--[[
搜索设置模块
]]

vim.opt.ignorecase = true     -- 搜索时忽略大小写
vim.opt.smartcase = true      -- 如果搜索包含大写，则区分大小写
vim.opt.incsearch = true      -- 边输入边搜索
-- vim.opt.hlsearch = false     -- 关闭搜索高亮（默认开启）