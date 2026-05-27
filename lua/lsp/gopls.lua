local function org_imports(wait_ms)
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

local opts = {
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

    -- Automatically organize imports on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("gopls_org_imports", { clear = false }),
      buffer = bufnr,
      callback = function() org_imports(1000) end,
      desc = "gopls: organize imports on save",
    })

    -- Enable omnifunc for Go completion
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
}

return opts
