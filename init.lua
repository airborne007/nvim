-- 模块化核心配置
require('core.config').setup()

-- 核心扩展模块
require('core.extension')

-- 热重载功能
require('core.hot_reload').setup()

-- 安全保护机制
require('core.security').setup()

-- 插件管理
require('plugins')

-- 加载用户扩展
-- 如果存在扩展目录，则加载所有扩展
local extensions_dir = vim.fn.stdpath('config') .. '/lua/extensions'
if vim.loop.fs_stat(extensions_dir) then
    for _, file in ipairs(vim.fn.readdir(extensions_dir)) do
        if file:match('%.lua$') then
            local extension_name = file:gsub('%.lua$', '')
            pcall(require, 'extensions.' .. extension_name)
        end
    end
end

-- 快捷键映射
require('keybindings')

-- lsp 配置
require('lsp')

-- autocmd
require("auto-command")
