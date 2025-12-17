local M = {

  -- Theme management
  "zaldih/themery.nvim",
  dependencies = {
    -- List of installed themes
    'navarasu/onedark.nvim',
    'sainnhe/everforest',
    'ellisonleao/gruvbox.nvim',
    'folke/tokyonight.nvim',
  }
}

function M.config()
  -- Configure theme selection
  require("themery").setup({
    globalBefore = [[
      -- Configure termguicolors
      vim.o.termguicolors = true
      vim.opt.termguicolors = true

      -- Set default background
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