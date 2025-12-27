return {
  'lewis6991/gitsigns.nvim',
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = '▎' },
      change       = { text = '▎' },
      delete       = { text = '' },
      topdelete    = { text = '' },
      changedelete = { text = '▎' },
      untracked    = { text = '▎' },
    },
    signcolumn = true,
    numhl      = false,
    linehl     = false,
    word_diff  = false,
    watch_gitdir = {
      interval = 1000,
      follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 500,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = 'rounded',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation (Jump between changes)
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({']c', bang = true})
        else
          gitsigns.nav_hunk('next')
        end
      end, { desc = "Next Git hunk" })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({'[c', bang = true})
        else
          gitsigns.nav_hunk('prev')
        end
      end, { desc = "Previous Git hunk" })

      -- Actions (Mapped to <leader>g...)
      
      -- Hunk Management
      map('n', '<leader>gp', gitsigns.preview_hunk, { desc = "Preview hunk" })
      map('n', '<leader>gr', gitsigns.reset_hunk, { desc = "Reset hunk" })
      map('n', '<leader>gS', gitsigns.stage_hunk, { desc = "Stage hunk" }) -- Capital S to avoid conflict with gs (status)
      map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
      
      -- Buffer Management
      map('n', '<leader>gR', gitsigns.reset_buffer, { desc = "Reset buffer" })
      
      -- Blame
      map('n', '<leader>gb', function() gitsigns.blame_line{full=true} end, { desc = "Blame line (Full)" })
      map('n', '<leader>gt', gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
      
      -- Diff
      map('n', '<leader>gd', gitsigns.diffthis, { desc = "Diff against index" })
      map('n', '<leader>gD', function() gitsigns.diffthis('~') end, { desc = "Diff against last commit" })

      -- Visual Mode Actions
      map('v', '<leader>gS', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage hunk" })
      map('v', '<leader>gr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset hunk" })

      -- Smart Git History (Re-mapped to <leader>gl for Log)
      local git_wrapper = require('core.git_wrapper')
      map({ "n", "v" }, "<leader>gl", git_wrapper.smart_git_history, { desc = "Git history (Smart)" })

      -- Text Object (Select inside hunk)
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk" })
    end
  }
}
