return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { "BufReadPost", "BufNewFile" },
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = { "vim", "lua", "typescript", "python", "go", "gomod", "gowork", "bash", "yaml", "make" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    },
    incremental_selection = {
      enable = false,
      keymaps = {
        init_selection = '<CR>',
        node_incremental = '<CR>',
        node_decremental = '<BS>',
        scope_incremental = '<TAB>',
      }
    },
    indent = {
      enable = false
    }
  }
}
