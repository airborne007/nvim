--[[
插件扩展机制核心文件
提供插件的动态加载、扩展和管理功能
--]]

---@class Extension
---@field name string 扩展名称
---@field enabled boolean 是否启用
---@field dependencies table<string> 依赖插件列表
---@field config function 配置函数

local M = {}

---@type table<Extension> 存储扩展的插件列表
local extensions = {}

---@type table<string, boolean> 存储禁用的插件列表
local disabled_plugins = {}

---@type table<string, function|table> 存储插件配置的覆盖项
local plugin_overrides = {}

---检查插件是否被禁用
---@param plugin_name string 插件名称
---@return boolean 是否被禁用
function M.is_plugin_disabled(plugin_name)
  return disabled_plugins[plugin_name] == true
end

---禁用指定插件
---@param plugin_name string 插件名称
function M.disable_plugin(plugin_name)
  disabled_plugins[plugin_name] = true
end

---启用指定插件
---@param plugin_name string 插件名称
function M.enable_plugin(plugin_name)
  disabled_plugins[plugin_name] = false
end

---获取禁用的插件列表
---@return table<string> 禁用的插件名称列表
function M.get_disabled_plugins()
  local result = {}
  for plugin_name, disabled in pairs(disabled_plugins) do
    if disabled then
      table.insert(result, plugin_name)
    end
  end
  return result
end

---添加插件扩展
---@param extension Extension 扩展配置
---@return boolean 是否添加成功
function M.add_extension(extension)
  if not extension.name then
    vim.notify("插件扩展必须包含name字段", vim.log.levels.ERROR)
    return false
  end
  
  -- 检查是否已存在同名扩展
  for _, ext in ipairs(extensions) do
    if ext.name == extension.name then
      vim.notify(string.format("已存在同名插件扩展: %s", extension.name), vim.log.levels.WARN)
      return false
    end
  end
  
  -- 设置默认值
  extension.enabled = extension.enabled ~= false
  extension.dependencies = extension.dependencies or {}
  extension.config = extension.config or function() end
  
  table.insert(extensions, extension)
  return true
end

---获取所有扩展
---@return table<Extension> 所有扩展列表
function M.get_extensions()
  return extensions
end

---根据名称获取扩展
---@param name string 扩展名称
---@return Extension|nil 扩展配置，如果不存在则返回nil
function M.get_extension(name)
  for _, extension in ipairs(extensions) do
    if extension.name == name then
      return extension
    end
  end
  return nil
end

---启用扩展
---@param name string 扩展名称
---@return boolean 是否启用成功
function M.enable_extension(name)
  local extension = M.get_extension(name)
  if extension then
    extension.enabled = true
    return true
  end
  return false
end

---禁用扩展
---@param name string 扩展名称
---@return boolean 是否禁用成功
function M.disable_extension(name)
  local extension = M.get_extension(name)
  if extension then
    extension.enabled = false
    return true
  end
  return false
end

---设置插件配置覆盖
---@param plugin_name string 插件名称
---@param config function|table 配置覆盖内容
function M.override_plugin_config(plugin_name, config)
  plugin_overrides[plugin_name] = config
end

---获取插件配置覆盖
---@return table<string, function|table> 插件配置覆盖列表
function M.get_plugin_overrides()
  return plugin_overrides
end

---应用插件配置覆盖
---@param plugin table|string 插件配置
---@return table|string 应用覆盖后的插件配置
function M.apply_plugin_overrides(plugin)
  if not plugin then
    return nil
  end
  
  local plugin_name = type(plugin) == "string" and plugin or plugin[1]
  if type(plugin_name) == "table" then
    plugin_name = plugin_name[1]
  end
  
  local override = plugin_overrides[plugin_name]
  if not override then
    return plugin
  end
  
  -- 合并配置
  if type(plugin) == "table" then
    local new_plugin = vim.deepcopy(plugin)
    if type(override) == "function" then
      return override(new_plugin)
    elseif type(override) == "table" then
      for k, v in pairs(override) do
        new_plugin[k] = v
      end
      return new_plugin
    end
  end
  
  return plugin
end

---获取所有启用的插件（包括核心插件和扩展插件）
---@return table 所有启用的插件列表
function M.get_all_plugins()
  local plugins = {}
  
  -- 加载核心插件
  local core_plugins = require("plugins")
  
  -- 应用插件配置覆盖
  for _, plugin in ipairs(core_plugins) do
    if type(plugin) == "table" and plugin[1] then
      local plugin_name = plugin[1]
      if not M.is_plugin_disabled(plugin_name) then
        table.insert(plugins, M.apply_plugin_overrides(plugin))
      end
    else
      -- 处理require方式的插件配置
      table.insert(plugins, plugin)
    end
  end
  
  -- 添加启用的扩展插件
  for _, extension in ipairs(extensions) do
    if extension.enabled then
      table.insert(plugins, extension)
    end
  end
  
  return plugins
end

---初始化扩展机制
function M.setup()
  -- 可以在这里添加初始化逻辑
  vim.notify("插件扩展机制已初始化", vim.log.levels.INFO)
end

return M