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
      enable = true,
      keymaps = {
        init_selection = '<CR>',      -- Start selection with Enter
        node_incremental = '<CR>',    -- Expand selection with Enter
        node_decremental = '<BS>',    -- Shrink selection with Backspace
        scope_incremental = '<TAB>',  -- Expand to scope (rarely used but handy)
      }
    },
    indent = {
      enable = true -- Enable based indentation
    }
  }
}