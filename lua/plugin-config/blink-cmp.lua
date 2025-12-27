return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
  },
  version = '*',

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
}