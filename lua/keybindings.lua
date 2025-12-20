--[[
Keybindings configuration file
Keybindings are grouped by function to improve readability and maintainability
--]]

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Local variable definitions
local map = vim.keymap.set  -- Alias for keymap function

-- Default keybinding options
local default_opts = {
  noremap = true,  -- Non-recursive mapping
  silent = true    -- Do not show command in command-line
}

-- Mode descriptions
-- n: normal_mode
-- i: insert_mode
-- v: visual_mode
-- x: visual_block_mode
-- t: term_mode
-- c: command_mode


-- ============================================
-- Basic Editing Keybindings
-- ============================================

-- Clear search highlight
map("n", "<leader><space>", ":noh<CR>", {
  noremap = true,
  silent = true,
  desc = "Clear search highlight"
})

-- Indent code in visual mode (maintaining selection)
map("v", "<", "<gv", {
  noremap = true,
  silent = true,
  desc = "Indent left"
})
map("v", ">", ">gv", {
  noremap = true,
  silent = true,
  desc = "Indent right"
})

-- Move selected text up/down in visual mode
map("v", "J", ":move '>+1<CR>gv-gv", {
  noremap = true,
  silent = true,
  desc = "Move selected text down"
})
map("v", "K", ":move '<-2<CR>gv-gv", {
  noremap = true,
  silent = true,
  desc = "Move selected text up"
})

-- Paste without yanking the replaced text in visual mode
map("v", "p", '"_dP', {
  noremap = true,
  silent = true,
  desc = "Paste without yanking replaced text"
})


-- ============================================ 
-- Window Management Keybindings
-- ============================================ 

-- Create new window
map("n", "<leader>h", ":split<CR>", {
  noremap = true,
  silent = true,
  desc = "Split window horizontally"
})
map("n", "<leader>v", ":vsplit<CR>", {
  noremap = true,
  silent = true,
  desc = "Split window vertically"
})

-- Close window
map("n", "sc", "<C-w>c", {
  noremap = true,
  silent = true,
  desc = "Close current window"
})
map("n", "so", "<C-w>o", {
  noremap = true,
  silent = true,
  desc = "Close other windows"
})

-- Switch between windows
map("n", "<C-h>", "<C-w>h", {
  noremap = true,
  silent = true,
  desc = "Switch to left window"
})
map("n", "<C-j>", "<C-w>j", {
  noremap = true,
  silent = true,
  desc = "Switch to bottom window"
})
map("n", "<C-k>", "<C-w>k", {
  noremap = true,
  silent = true,
  desc = "Switch to top window"
})
map("n", "<C-l>", "<C-w>l", {
  noremap = true,
  silent = true,
  desc = "Switch to right window"
})

-- Resize windows
map("n", "<C-Left>", ":vertical resize -2<CR>", {
  noremap = true,
  silent = true,
  desc = "Decrease window width"
})
map("n", "<C-Right>", ":vertical resize +2<CR>", {
  noremap = true,
  silent = true,
  desc = "Increase window width"
})
map("n", "<C-Down>", ":resize +2<CR>", {
  noremap = true,
  silent = true,
  desc = "Increase window height"
})
map("n", "<C-Up>", ":resize -2<CR>", {
  noremap = true,
  silent = true,
  desc = "Decrease window height"
})
map("n", "s=", "<C-w>=", {
  noremap = true,
  silent = true,
  desc = "Equalize window sizes"
})


-- ============================================ 
-- Plugin Keybinding Table
-- ============================================ 
local pluginKeys = {}

-- ============================================ 
-- File Explorer (nvim-tree)
-- ============================================ 
map('n', '<A-m>', ':NvimTreeToggle<CR>', {
  noremap = true,
  silent = true,
  desc = "Toggle file explorer"
})


-- ============================================ 
-- Buffer Management (bufferline)
-- ============================================ 
map("n", "<leader>q", ":BufferLineCyclePrev<CR>", {
  noremap = true,
  silent = true,
  desc = "Switch to previous buffer"
})
map("n", "<leader>w", ":BufferLineCycleNext<CR>", {
  noremap = true,
  silent = true,
  desc = "Switch to next buffer"
})
map("n", "<leader>c", ":bd<CR>", {
  noremap = true,
  silent = true,
  desc = "Close current buffer"
})


-- ============================================ 
-- Floating Terminal (Snacks.nvim)
-- ============================================ 
map('n', '<A-d>', function() Snacks.terminal.toggle() end, {
  noremap = true,
  silent = true,
  desc = "Toggle floating terminal"
})
map('t', '<A-d>', function() Snacks.terminal.toggle() end, {
  noremap = true,
  silent = true,
  desc = "Toggle floating terminal in terminal"
})


-- ============================================ 
-- AI Assistant (Gemini CLI)
-- ============================================ 
map("n", "<leader>g", "<cmd>Gemini toggle<cr>", {
  noremap = true,
  silent = true,
  desc = "Toggle Gemini CLI"
})
map({"n", "v"}, "<leader>ga", "<cmd>Gemini ask<cr>", {
  noremap = true,
  silent = true,
  desc = "Ask Gemini"
})
map("n", "<leader>gf", "<cmd>Gemini add_file<cr>", {
  noremap = true,
  silent = true,
  desc = "Add file to Gemini"
})


-- ============================================ 
-- Git Status Management (gitsigns)
-- ============================================ 
pluginKeys.mapgit = function(mapbuf)
  local gitsigns = require('gitsigns')

  -- Navigate to next/previous Git hunk
  mapbuf('n', ']c', function()
    if vim.wo.diff then
      vim.cmd.normal({ ']c', bang = true })
    else
      gitsigns.nav_hunk('next')
    end
  end, {
    noremap = true,
    silent = true,
    desc = "Next Git hunk"
  })

  mapbuf('n', '[c', function()
    if vim.wo.diff then
      vim.cmd.normal({ '[c', bang = true })
    else
      gitsigns.nav_hunk('prev')
    end
  end, {
    noremap = true,
    silent = true,
    desc = "Previous Git hunk"
  })
end


-- ============================================ 
-- Git History displays
-- ============================================
local git_history = require('extensions.git_history')
map("n", "<leader>gs", git_history.show_git_history, {
  noremap = true,
  silent = true,
  desc = "Git file commit history"
})
map("v", "<leader>gs", git_history.show_selected_files_history, {
  noremap = true,
  silent = true,
  desc = "Git line commit history"
})


-- ============================================ 
-- Fuzzy Search (telescope)
-- ============================================ 
map("n", "<leader>e", ":Telescope find_files<CR>", {
  noremap = true,
  silent = true,
  desc = "Find files"
})
map("n", "<leader>f", ":Telescope live_grep<CR>", {
  noremap = true,
  silent = true,
  desc = "Grep text"
})
map("n", "<leader>b", ":Telescope buffers<CR>", {
  noremap = true,
  silent = true,
  desc = "Find buffers"
})
map("n", "<leader>s", ":Telescope lsp_document_symbols<CR>", {
  noremap = true,
  silent = true,
  desc = "Find document symbols"
})


-- ============================================ 
-- Diagnostics Management (trouble)
-- ============================================ 
map("n", "<leader>xx", function() require("trouble").toggle() end, {
  noremap = true,
  silent = true,
  desc = "Toggle diagnostics panel"
})
map("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, {
  noremap = true,
  silent = true,
  desc = "Workspace diagnostics"
})
map("n", "<leader>xd", function() require("trouble").toggle("document_ diagnostics") end, {
  noremap = true,
  silent = true,
  desc = "Document diagnostics"
})
map("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, {
  noremap = true,
  silent = true,
  desc = "Quickfix list"
})
map("n", "<leader>xl", function() require("trouble").toggle("loclist") end, {
  noremap = true,
  silent = true,
  desc = "Location list"
})
map("n", "<leader>xr", function() require("trouble").toggle("lsp_references") end, {
  noremap = true,
  silent = true,
  desc = "LSP references list"
})


-- ============================================ 
-- LSP Related Keybindings
-- ============================================ 
pluginKeys.maplsp = function(mapbuf)
  -- Rename symbol
  mapbuf('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {
    noremap = true,
    silent = true,
    desc = "Rename symbol"
  })
  
  -- Code action
  mapbuf('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', {
    noremap = true,
    silent = true,
    desc = "Code action"
  })
  
  -- Go to definition
  mapbuf('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {
    noremap = true,
    silent = true,
    desc = "Go to definition"
  })
  
  -- Show hover documentation
  mapbuf('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', {
    noremap = true,
    silent = true,
    desc = "Show documentation"
  })
  
  -- Go to declaration
  mapbuf('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {
    noremap = true,
    silent = true,
    desc = "Go to declaration"
  })
  
  -- Go to implementation
  mapbuf('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {
    noremap = true,
    silent = true,
    desc = "Go to implementation"
  })
  
  -- Go to references
  mapbuf('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {
    noremap = true,
    silent = true,
    desc = "Go to references"
  })
  
  -- Show diagnostics
  mapbuf('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', {
    noremap = true,
    silent = true,
    desc = "Show diagnostics"
  })
  
  -- Go to previous diagnostic
  mapbuf('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {
    noremap = true,
    silent = true,
    desc = "Previous diagnostic"
  })
  
  -- Go to next diagnostic
  mapbuf('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', {
    noremap = true,
    silent = true,
    desc = "Next diagnostic"
  })
  
  -- Format code
  mapbuf('n', '<leader>=', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', {
    noremap = true,
    silent = true,
    desc = "Format code"
  })
end


-- ============================================ 
-- NvimTree (File Explorer)
-- ============================================ 
pluginKeys.nvimTreeOnAttach = function(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Default mappings. Feel free to modify or remove as you wish.
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
  vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
  vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
  vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
  vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
  vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
  vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
  vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
  vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
  vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
  vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))

  -- Custom mappings
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', 'h', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 'i', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
end

-- ============================================ 
-- Telescope (Fuzzy Finder)
-- ============================================ 
pluginKeys.telescopeMappings = function(actions, trouble)
  return {
    i = {
      -- Move up/down
      ["<C-j>"] = "move_selection_next",
      ["<C-k>"] = "move_selection_previous",
      ["<C-n>"] = "move_selection_next",
      ["<C-p>"] = "move_selection_previous",
      -- History
      ["<Down>"] = "cycle_history_next",
      ["<Up>"] = "cycle_history_prev",
      -- Close window
      ["<esc>"] = actions.close,
      -- Scroll preview window up/down
      ["<C-u>"] = "preview_scrolling_up",
      ["<C-d>"] = "preview_scrolling_down",
      -- Trouble
      ["<c-t>"] = trouble.open,
    },
    n = {
      -- Trouble
      ["<c-t>"] = trouble.open,
    }
  }
end

-- ============================================ 
-- Blink CMP (Completion)
-- ============================================ 
pluginKeys.blinkCmpKeys = {
  -- set to 'none' to disable the 'default' preset
  preset = 'enter',

  ['<Tab>'] = { 'snippet_forward', 'fallback' },
  ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

  -- Previous
  ['<C-k>'] = { 'select_prev', 'fallback' },
  -- Next
  ['<C-j>'] = { 'select_next', 'fallback' },
}

-- ============================================ 
-- Flash
-- ============================================ 
map({ "n", "x", "o" }, "<leader>d", function() require("flash").jump() end, {
  noremap = true,
  silent = true,
  desc = "Flash Jump"
})

-- Return plugin keybinding table
return pluginKeys
