--[[
Core file for the plugin extension mechanism
Provides dynamic loading, extension, and management of plugins
--]]

---@class Extension
---@field name string Extension name
---@field enabled boolean Whether it is enabled
---@field dependencies table<string> List of dependent plugins
---@field config function Configuration function

local M = {}

---@type table<Extension> Stores the list of extension plugins
local extensions = {}

---@type table<string, boolean> Stores the list of disabled plugins
local disabled_plugins = {}

---@type table<string, function|table> Stores the overrides for plugin configurations
local plugin_overrides = {}

---Checks if a plugin is disabled
---@param plugin_name string Plugin name
---@return boolean Whether it is disabled
function M.is_plugin_disabled(plugin_name)
  return disabled_plugins[plugin_name] == true
end

---Disables a specific plugin
---@param plugin_name string Plugin name
function M.disable_plugin(plugin_name)
  disabled_plugins[plugin_name] = true
end

---Enables a specific plugin
---@param plugin_name string Plugin name
function M.enable_plugin(plugin_name)
  disabled_plugins[plugin_name] = false
end

---Gets the list of disabled plugins
---@return table<string> List of disabled plugin names
function M.get_disabled_plugins()
  local result = {}
  for plugin_name, disabled in pairs(disabled_plugins) do
    if disabled then
      table.insert(result, plugin_name)
    end
  end
  return result
end

---Adds a plugin extension
---@param extension Extension Extension configuration
---@return boolean Whether the addition was successful
function M.add_extension(extension)
  if not extension.name then
    vim.notify("Plugin extension must include a name field", vim.log.levels.ERROR)
    return false
  end
  
  -- Check if an extension with the same name already exists
  for _, ext in ipairs(extensions) do
    if ext.name == extension.name then
      vim.notify(string.format("Plugin extension with the same name already exists: %s", extension.name), vim.log.levels.WARN)
      return false
    end
  end
  
  -- Set default values
  extension.enabled = extension.enabled ~= false
  extension.dependencies = extension.dependencies or {}
  extension.config = extension.config or function() end
  
  table.insert(extensions, extension)
  return true
end

---Gets all extensions
---@return table<Extension> List of all extensions
function M.get_extensions()
  return extensions
end

---Gets an extension by name
---@param name string Extension name
---@return Extension|nil Extension configuration, or nil if it does not exist
function M.get_extension(name)
  for _, extension in ipairs(extensions) do
    if extension.name == name then
      return extension
    end
  end
  return nil
end

---Enables an extension
---@param name string Extension name
---@return boolean Whether the enabling was successful
function M.enable_extension(name)
  local extension = M.get_extension(name)
  if extension then
    extension.enabled = true
    return true
  end
  return false
end

---Disables an extension
---@param name string Extension name
---@return boolean Whether the disabling was successful
function M.disable_extension(name)
  local extension = M.get_extension(name)
  if extension then
    extension.enabled = false
    return true
  end
  return false
end

---Sets a plugin configuration override
---@param plugin_name string Plugin name
---@param config function|table Configuration override content
function M.override_plugin_config(plugin_name, config)
  plugin_overrides[plugin_name] = config
end

---Gets the plugin configuration overrides
---@return table<string, function|table> List of plugin configuration overrides
function M.get_plugin_overrides()
  return plugin_overrides
end

---Applies plugin configuration overrides
---@param plugin table|string Plugin configuration
---@return table|string Plugin configuration after applying overrides
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
  
  -- Merge configurations
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

---Gets all enabled plugins (including core and extension plugins)
---@return table List of all enabled plugins
function M.get_all_plugins()
  local plugins = {}
  
  -- Load core plugins
  local core_plugins = require("plugins")
  
  -- Apply plugin configuration overrides
  for _, plugin in ipairs(core_plugins) do
    if type(plugin) == "table" and plugin[1] then
      local plugin_name = plugin[1]
      if not M.is_plugin_disabled(plugin_name) then
        table.insert(plugins, M.apply_plugin_overrides(plugin))
      end
    else
      -- Handle plugin configurations loaded via require
      table.insert(plugins, plugin)
    end
  end
  
  -- Add enabled extension plugins
  for _, extension in ipairs(extensions) do
    if extension.enabled then
      table.insert(plugins, extension)
    end
  end
  
  return plugins
end

---Initializes the extension mechanism
function M.setup()
  -- Initialization logic can be added here
  vim.notify("Plugin extension mechanism initialized", vim.log.levels.INFO)
end

return M
