local M = {}

function M.on_attach(client, bufnr)
  local function buf_set_keymap(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Bind keybindings
  require("keybindings").maplsp(buf_set_keymap)
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