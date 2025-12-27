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
  
