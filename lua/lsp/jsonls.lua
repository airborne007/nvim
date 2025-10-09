-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local opts = {
  capabilities = capabilities,
  on_attach = require('lsp.utils').on_attach
}

return opts
