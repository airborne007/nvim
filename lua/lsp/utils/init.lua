local M = {}

function M.on_attach(client, bufnr)
  local function buf_set_keymap(...) 
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- Bind keybindings
  require("keybindings").maplsp(buf_set_keymap)
  -- Auto-format on save
  vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
end

return M