--[[
Auto-command configuration file
Uses modern Lua API to manage auto-commands, grouped by function for improved maintainability
--]]

local api = vim.api

-- ============================================
-- Auto-command Group Definitions
-- ============================================

-- 1. Yank Highlight Group
local yank_group = api.nvim_create_augroup('YankHighlight', {
  clear = true
})

api.nvim_create_autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',  -- Use search highlight color
      timeout = 200,          -- Highlight duration (milliseconds)
      on_visual = true        -- Also effective in visual mode
    })
  end,
  desc = 'Show highlight when text is yanked'
})


-- 2. Cursor Line Management Group
local cursorline_group = api.nvim_create_augroup('CursorLineManagement', {
  clear = true
})

api.nvim_create_autocmd({'InsertLeave', 'WinEnter'}, {
  group = cursorline_group,
  pattern = '*',
  callback = function()
    local ok, cl = pcall(api.nvim_win_get_var, 0, 'auto-cursorline')
    if ok and cl then
      vim.wo.cursorline = true
      api.nvim_win_del_var(0, 'auto-cursorline')
    end
  end,
  desc = 'Show cursor line when leaving insert mode or entering a window'
})

api.nvim_create_autocmd({'InsertEnter', 'WinLeave'}, {
  group = cursorline_group,
  pattern = '*',
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      api.nvim_win_set_var(0, 'auto-cursorline', cl)
      vim.wo.cursorline = false
    end
  end,
  desc = 'Hide cursor line when entering insert mode or leaving a window'
})


-- 3. File Position Memory Group
local file_pos_group = api.nvim_create_augroup('FilePositionMemory', {
  clear = true
})

api.nvim_create_autocmd('BufReadPost', {
  group = file_pos_group,
  pattern = '*',
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
  desc = 'Jump to last edit position when opening a file'
})


-- 4. File Update Detection Group
local file_update_group = api.nvim_create_augroup('FileUpdateDetection', {
  clear = true
})

api.nvim_create_autocmd('FocusGained', {
  group = file_update_group,
  pattern = '*',
  callback = function()
    vim.cmd('checktime')
  end,
  desc = 'Check if file was modified externally when gaining focus'
})


-- 5. Temporary File Handling Group
local temp_file_group = api.nvim_create_augroup('TempFileHandling', {
  clear = true
})

api.nvim_create_autocmd('FileType', {
  group = temp_file_group,
  pattern = {
    'qf',
    'help',
    'man',
    'notify',
    'lspinfo',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'PlenaryTestPopup',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false  -- Do not show in buffer list
    vim.keymap.set('n', 'q', '<cmd>close<cr>', {
      buffer = event.buf,
      silent = true,
      desc = 'Close current window'
    })
  end,
  desc = 'Add "q" key to close for temporary files'
})


-- 6. Format Options Setting Group
local format_opts_group = api.nvim_create_augroup('FormatOptions', { clear = true })

api.nvim_create_autocmd('BufEnter', {
  group = format_opts_group,
  pattern = '*',
  callback = function()
    -- Apply only to normal file types, avoid affecting special buffers
    if vim.bo.buftype == '' then
      vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    end
  end,
  desc = 'Disable automatic commenting for new lines'
})

api.nvim_create_autocmd('FileType', {
  group = format_opts_group,
  pattern = { 'markdown' },
  callback = function()
    vim.opt.formatoptions:append('t')  -- Allow text auto-wrapping
  end,
  desc = 'Enable text auto-wrapping for Markdown files'
})