-- Enable the experimental Lua module loader for faster startup
if vim.loader then
  vim.loader.enable()
end

-- Load keybindings and set leader keys (Must be before plugins)
require('keybindings')

-- Modular core configuration
require('core.config').setup()

-- Hot-reload feature
require('core.hot_reload').setup()

-- Plugin management
require('plugins')

-- Load user extensions
-- If the extensions directory exists, load all extensions
local extensions_dir = vim.fn.stdpath('config') .. '/lua/extensions'
if vim.loop.fs_stat(extensions_dir) then
    for _, file in ipairs(vim.fn.readdir(extensions_dir)) do
        if file:match('%.lua$') then
            local extension_name = file:gsub('%.lua$', '')
            pcall(require, 'extensions.' .. extension_name)
        end
    end
end

-- Autocmd
require("auto-command")