return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
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
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
