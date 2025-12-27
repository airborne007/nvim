-- Helper function to get the current python virtual environment
local function get_venv(variable)
  local venv = os.getenv(variable)
  if venv ~= nil and string.find(venv, '/') then
    local orig_venv = venv
    for w in orig_venv:gmatch('([^/]+)') do
      venv = w
    end
    venv = string.format('(%s)', venv)
  end
  return venv
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'auto',
      globalstatus = true,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' },
      },
    },
    sections = {
      lualine_a = {
        { 'mode', separator = { left = '' }, right_padding = 2 },
      },
      lualine_b = {
        'branch',
        {
          'diff',
          symbols = { added = ' ', modified = ' ', removed = ' ' },
        },
        -- Macro recording status
        {
          function()
            local reg = vim.fn.reg_recording()
            if reg == '' then return '' end
            return ' Rec @' .. reg
          end,
          color = { fg = '#ff9e64', gui = 'bold' },
        },
      },
      lualine_c = {
        {
          'diagnostics',
          symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        },
        { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
        {
          'filename',
          path = 1,
          symbols = { modified = '  ', readonly = ' 🔒', unnamed = ' [No Name]' },
        },
      },
      lualine_x = {
        -- Search count
        {
          'searchcount',
          maxcount = 999,
          timeout = 500,
        },
        -- LSP Status
        {
          function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if next(clients) == nil then
              return '' -- Keep silent when no LSP
            end
            local client_names = {}
            for _, client in ipairs(clients) do
              -- Filter out non-core LSPs if needed (e.g., null-ls)
              if client.name ~= 'null-ls' then
                table.insert(client_names, client.name)
              end
            end
            return ' ' .. table.concat(client_names, '|')
          end,
          color = { fg = '#9ece6a', gui = 'bold' }, -- Green when active
        },
        -- Python Virtual Env
        {
          function()
            local venv = get_venv('CONDA_DEFAULT_ENV') or get_venv('VIRTUAL_ENV')
            return venv or ''
          end,
          icon = '🐍',
          cond = function() return vim.bo.filetype == 'python' end,
          color = { fg = '#ffbc00' }, 
        },
        'encoding',
        'fileformat',
      },
      lualine_y = { 
        -- Indentation info
        {
            function()
                local type = vim.bo.expandtab and 'Spc' or 'Tab'
                local size = vim.bo.shiftwidth
                if size == 0 then
                  size = vim.bo.tabstop
                end
                return type .. ':' .. size
            end
        },
        'progress' 
      },
      lualine_z = {
        { 'location', separator = { right = '' }, left_padding = 2 },
      },
    },
    extensions = { 'lazy', 'fzf', 'trouble', 'mason' },
  },
}