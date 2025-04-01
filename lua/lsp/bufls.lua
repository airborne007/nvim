-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#buf_ls
local opts = {
  cmd = { 'buf', 'beta', 'lsp', '--timeout=0', '--log-format=text' },
  filetypes = { 'proto' },
  root_dir = require('lspconfig.util').root_pattern('buf.yaml', '.git'),
  on_attach = require('lsp.utils').on_attach,
}
return opts
