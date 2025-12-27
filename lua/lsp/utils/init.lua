local M = {}

function M.on_attach(client, bufnr)
  local function map(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = bufnr, silent = true, desc = desc })
  end

  -- Rename symbol
  map('n', '<leader>rn', vim.lsp.buf.rename, "Rename symbol")

  -- Code action
  map('n', '<leader>a', vim.lsp.buf.code_action, "Code action")

  -- Go to definition
  map('n', 'gd', function() require("snacks").picker.lsp_definitions() end, "Go to definition")

  -- Show hover documentation
  map('n', 'gh', vim.lsp.buf.hover, "Show documentation")

  -- Go to declaration
  map('n', 'gD', vim.lsp.buf.declaration, "Go to declaration")

  -- Go to implementation
  map('n', 'gi', function() require("snacks").picker.lsp_implementations() end, "Go to implementation")

  -- Go to references
  map('n', 'gr', function() require("snacks").picker.lsp_references() end, "Go to references")

  -- Show diagnostics
  map('n', 'go', vim.diagnostic.open_float, "Show diagnostics")

  -- Go to previous diagnostic
  map('n', 'gp', vim.diagnostic.goto_prev, "Previous diagnostic")

  -- Go to next diagnostic
  map('n', 'gn', vim.diagnostic.goto_next, "Next diagnostic")

  -- Format code
  map('n', '<leader>=', function() vim.lsp.buf.format({ async = true }) end, "Format code")

  -- Auto-format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      local ft = vim.bo[bufnr].filetype
      local ignore_filetypes = { "python", "lua", "javascript", "typescript" }
      if not vim.tbl_contains(ignore_filetypes, ft) then
        vim.lsp.buf.format()
      end
    end,
  })
end

return M
