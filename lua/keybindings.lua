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
-- File Explorer (Snacks.nvim)
-- ============================================ 
map('n', '<leader>t', function() Snacks.picker.explorer() end, {
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
local git_wrapper = require('core.git_wrapper')
map({"n", "v"}, "<leader>gh", git_wrapper.smart_git_history, {
  noremap = true,
  silent = true,
  desc = "Git history (Smart)"
})


-- ============================================ 
-- Fuzzy Search (snacks.picker)
-- ============================================ 
map("n", "<leader>e", function() Snacks.picker.files() end, {
  noremap = true,
  silent = true,
  desc = "Find files"
})
map("n", "<leader>f", function() Snacks.picker.grep() end, {
  noremap = true,
  silent = true,
  desc = "Grep text"
})
map("n", "<leader>b", function() Snacks.picker.buffers() end, {
  noremap = true,
  silent = true,
  desc = "Find buffers"
})
map("n", "<leader>s", function() Snacks.picker.lsp_symbols() end, {
  noremap = true,
  silent = true,
  desc = "Find document symbols"
})
map("n", "<leader>gs", function() Snacks.picker.git_status() end, {
  noremap = true,
  silent = true,
  desc = "Git status"
})
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, {
  noremap = true,
  silent = true,
  desc = "Search diagnostics"
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
map("n", "<leader>qf", function() Snacks.picker.qflist() end, {
  noremap = true,
  silent = true,
  desc = "Quickfix list (Snacks)"
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
  mapbuf('n', 'gd', function() Snacks.picker.lsp_definitions() end, {
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
  mapbuf('n', 'gi', function() Snacks.picker.lsp_implementations() end, {
    noremap = true,
    silent = true,
    desc = "Go to implementation"
  })
  
  -- Go to references
  mapbuf('n', 'gr', function() Snacks.picker.lsp_references() end, {
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

-- Return plugin keybinding table
return pluginKeys
