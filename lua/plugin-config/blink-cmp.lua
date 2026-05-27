return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
  },
  version = '*',
  event = 'InsertEnter',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'enter',

      -- Custom Tab logic: Windsurf (Codeium) > Snippet Forward > Fallback
      ['<Tab>'] = {
        function(cmp)
          if vim.fn['codeium#GetStatusString']() ~= "" then
            return vim.fn['codeium#Accept']()
          end
        end,
        'snippet_forward',
        'fallback'
      },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },

    completion = {
      ghost_text = { enabled = true },
      menu = {
        border = 'rounded',
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 }
          },
        }
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = 'rounded' }
      },
      list = {
        selection = { preselect = false, auto_insert = true }
      }
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    cmdline = {
      enabled = true,
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == '/' or type == '?' then return { 'buffer' } end
        if type == ':' then return { 'cmdline' } end
        return {}
      end
    },

    signature = {
      enabled = true,
      window = { border = 'rounded' }
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },

  config = function(_, opts)
    require('blink.cmp').setup(opts)

    -- Minimal autopair (replaces standalone nvim-autopairs)
    local pair_map = {
      ['('] = ')', ['['] = ']', ['{'] = '}',
      ['"'] = '"', ["'"] = "'", ['`'] = '`',
    }
    local close_pairs = {}
    for o, c in pairs(pair_map) do close_pairs[c] = o end

    local augroup = vim.api.nvim_create_augroup('blink_autopairs', { clear = true })

    -- Auto-close bracket pairs with synchronous keymaps (no vim.schedule)
    vim.keymap.set('i', '(',  '()<Left>',  { desc = 'Auto-close parens' })
    vim.keymap.set('i', '[',  '[]<Left>',  { desc = 'Auto-close brackets' })
    vim.keymap.set('i', '{',  '{}<Left>',  { desc = 'Auto-close braces' })

    -- Auto-close quotes with context awareness (InsertCharPre)
    vim.api.nvim_create_autocmd('InsertCharPre', {
      group = augroup,
      callback = function()
        local char = vim.v.char
        if char ~= '"' and char ~= "'" and char ~= '`' then return end

        local lnum, col = unpack(vim.api.nvim_win_get_cursor(0))
        local line = vim.api.nvim_get_current_line()
        -- col is 0-indexed, Lua strings are 1-indexed
        local next_char = line:sub(col + 1, col + 1)
        local prev_char = line:sub(col, col)

        -- Don't auto-close if preceded or followed by a word character
        if next_char:match('[%w_]') or prev_char:match('[%w_]') then return end

        vim.schedule(function()
          vim.api.nvim_buf_set_text(0, lnum - 1, col + 1, lnum - 1, col + 1, { char })
          vim.api.nvim_win_set_cursor(0, { lnum, col + 1 })
        end)
      end,
    })

    -- Skip over closing bracket when the matching char is already present
    vim.api.nvim_create_autocmd('InsertCharPre', {
      group = augroup,
      callback = function()
        local char = vim.v.char
        if not close_pairs[char] then return end

        local lnum, col = unpack(vim.api.nvim_win_get_cursor(0))
        local line = vim.api.nvim_get_current_line()
        local next_char = line:sub(col + 1, col + 1)

        if next_char == char then
          vim.v.char = ''
          vim.schedule(function()
            vim.api.nvim_win_set_cursor(0, { lnum, col + 1 })
          end)
        end
      end,
    })

    -- Backspace deletes both characters in an empty pair
    vim.keymap.set('i', '<BS>', function()
      local col = vim.fn.col('.') - 1 -- 0-indexed column
      if col == 0 then return '<BS>' end
      local line = vim.api.nvim_get_current_line()
      local prev = line:sub(col, col)         -- char left of cursor (Lua 1-indexed)
      local curr = line:sub(col + 1, col + 1) -- char at cursor
      if pair_map[prev] and curr == pair_map[prev] then
        return '<BS><Del>'
      end
      return '<BS>'
    end, { expr = true, desc = 'Delete pair brackets' })
  end,
}