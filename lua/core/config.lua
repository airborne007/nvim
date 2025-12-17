--[[
Configuration management module
Loads and manages all functional modules in a unified way
]]

local M = {}

-- Load all configuration modules
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
