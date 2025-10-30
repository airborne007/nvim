-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
local util = require "lspconfig/util"
local opts = {
  on_attach = require('lsp.utils').on_attach,
  settings = {
    pylsp = {
      plugins = {
        ruff = {
          enabled = true,
          lineLength = 120
        },
      }
    }
  }
}

return opts
