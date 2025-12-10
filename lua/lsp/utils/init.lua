local M = {}

function M.on_attach(client, bufnr)
  local function buf_set_keymap(...) 
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- 绑定快捷键
  require("keybindings").maplsp(buf_set_keymap)
  -- 保存时自动格式化
  vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
end

return M
