return {
  {
    "williamboman/mason.nvim",
    description = "Package manager for LSP servers and tools",
    build = ":MasonUpdate",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    description = "Bridge between Mason and lspconfig",
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    'neovim/nvim-lspconfig',
    description = "Neovim built-in LSP client configuration",
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require('lsp')
    end,
  },
}