function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

local util = require "lspconfig/util"
local opts = {
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  single_file_support = true,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  on_attach = function(client, bufnr)
    require('lsp.utils').on_attach(client, bufnr)
    -- 自动执行goimports
    vim.cmd("autocmd BufWritePre *.go lua OrgImports(1000)")
    -- To make your Ctrl+x,Ctrl+o work
    vim.cmd("autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc")
  end,
}

return opts
