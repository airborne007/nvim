-- 基础配置
require('basic')

-- Packer插件管理
require('plugins')

-- 快捷键映射
require('keybindings')

-- lsp 配置
require('lsp')

-- autocmd
require("auto-command")

-- 皮肤设置
require("colorscheme")

-- 设置nvim-tree
require("nvim-tree").setup({
  view = {
    side = "left", -- 设置文件树显示在左侧
    width = 30,    -- 设置文件树的宽度
  },
  update_focused_file = {
    enable = false, -- 禁止自动更新焦点文件
  },
})
