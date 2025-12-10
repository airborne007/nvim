--[[
剪贴板设置模块
]]

-- 启用系统剪贴板支持
vim.opt.clipboard = "unnamedplus"

-- WSL 特定设置
-- 检测是否在WSL环境中运行
local function is_wsl()
  local version_file = io.open("/proc/version", "rb")
  if version_file then
    local content = version_file:read("*a")
    version_file:close()
    return string.find(content, "microsoft") ~= nil
  end
  return false
end

-- 如果在WSL中，配置剪贴板工具
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