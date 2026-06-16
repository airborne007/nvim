return {
  'nvim-treesitter/nvim-treesitter',
  event = { "BufReadPost", "BufNewFile" },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup()

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        if vim.treesitter.language.get_lang(vim.bo[args.buf].filetype) then
          pcall(vim.treesitter.start, args.buf)
        end
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        -- Skip indentexpr for languages that use LSP formatters or built-in indent
        local skip = { 'go', 'rust', 'python', 'lua', 'sh' }
        if not vim.tbl_contains(skip, vim.bo[args.buf].filetype) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
