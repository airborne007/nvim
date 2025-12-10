-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#buf_ls
local opts = {
  on_attach = require('lsp.utils').on_attach,
}
return opts
