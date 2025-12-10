--[[
配置管理模块
统一加载和管理所有功能模块
]]

local M = {}

-- 加载所有配置模块
M.setup = function()
  local modules = {
    'core.history',
    'core.visual',
    'core.indent',
    'core.search',
    'core.command',
    'core.file',
    'core.keyboard',
    'core.window',
    'core.completion',
    'core.style',
    'core.folding',
    'core.clipboard'
  }

  for _, module in ipairs(modules) do
    local status_ok, err = pcall(require, module)
    if not status_ok then
      vim.notify('Error loading ' .. module .. ': ' .. err, vim.log.levels.ERROR)
    end
  end
end

return M