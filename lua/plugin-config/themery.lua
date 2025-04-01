local M = {

  -- 主题管理
  "zaldih/themery.nvim",
  dependencies = {
    -- 安装的主题列表
    'navarasu/onedark.nvim',
    'sainnhe/everforest',
    'ellisonleao/gruvbox.nvim',
    'folke/tokyonight.nvim',
  }
}

function M.config()
  -- 配置主题选择
  require("themery").setup({
    globalBefore = [[
      -- 配置termguicolors
      vim.o.termguicolors = true
      vim.opt.termguicolors = true

      -- 设置默认背景
      vim.o.background=dark
    ]],
    themes = {
      {
        name = "onedark darker",
        colorscheme = "onedark",
        before = [[
          vim.g.onedark_style = 'darker'
          vim.opt.background = "dark"
        ]]
      },
      {
        name = "gruvbox dark",
        colorscheme = "gruvbox",
        before = [[
          vim.opt.background = "dark"
        ]]
      },
      {
        name = "everforest soft",
        colorscheme = "everforest",
        before = [[
          vim.g.everforest_background = 'soft'
          vim.g.everforest_better_performace = 1
          vim.opt.background = "dark"
        ]]
      },
      {
        name = "tokyonight",
        colorscheme = "tokyonight",
        before = [[
          vim.opt.background = "dark"
        ]]
      }
    }
  })
end

return M
