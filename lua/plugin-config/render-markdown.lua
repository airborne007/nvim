return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>um', function() require('render-markdown').toggle() end, desc = 'Toggle markdown render', ft = 'markdown' },
  },
  opts = {
    enabled = true,
    max_file_size = 10.0,
    win_options = {
      wrap = {
        default = false,
        rendered = true,
      },
    },
    heading = {
      icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    },
    code = {
      style = 'normal',
    },
    checkbox = {
      unchecked = { icon = '󰄱 ' },
      checked = { icon = '󰄲 ' },
    },
  },
}
