-- Only load the active colorscheme eagerly; lazy-load the rest
local current_theme = (function()
  local f = io.open(vim.fn.stdpath('data') .. '/current_theme.txt', 'r')
  if f then
    local t = f:read('*a')
    f:close()
    if t then return t:gsub('%s+', '') end
  end
  return 'tokyonight' -- default fallback
end)()

return {
  { 'folke/tokyonight.nvim',    lazy = current_theme ~= 'tokyonight' },
  { 'navarasu/onedark.nvim',    lazy = current_theme ~= 'onedark' },
  { 'sainnhe/everforest',       lazy = current_theme ~= 'everforest' },
  { 'ellisonleao/gruvbox.nvim', lazy = current_theme ~= 'gruvbox' },
}
