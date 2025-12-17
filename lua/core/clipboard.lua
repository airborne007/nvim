--[[
Clipboard settings module
]]

-- Enable system clipboard support
vim.opt.clipboard = "unnamedplus"

-- WSL specific settings
-- Check if running in a WSL environment
local function is_wsl()
  local version_file = io.open("/proc/version", "rb")
  if version_file then
    local content = version_file:read("*a")
    version_file:close()
    return string.find(content, "microsoft") ~= nil
  end
  return false
end

-- If in WSL, configure the clipboard tool
if is_wsl() then
  vim.g.clipboard = {
    name = "wsl-clipboard",
    copy = {
      ["+"] = "wcopy",
      ["*"] = "wcopy"
    },
    paste = {
      ["+"] = "wpaste",
      ["*"] = "wpaste"
    },
    cache_enabled = true
  }
end
