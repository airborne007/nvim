--[[
Git History extension
Provides file and selected line history viewing functionality
Uses Telescope for interactive commit browsing with diff preview
--]]

local M = {}

-- ============================================
-- Git Command Utilities
-- ============================================
-- Git command execution function
local function git_cmd(cmd, cwd)
    cwd = cwd or vim.fn.expand('%:p:h')
    local result = vim.fn.systemlist(string.format('git -C %s %s', vim.fn.shellescape(cwd), cmd))
    if vim.v.shell_error ~= 0 then
        return nil
    end
    return result
end

-- ============================================
-- Commit Preview Functions
-- ============================================
-- Get commit diff for preview
local function get_commit_diff(hash, filepath)
    local cmd = string.format('diff %s^! --no-color -- %s', hash, vim.fn.shellescape(filepath))
    local diff = git_cmd(cmd)
    if diff then
        return table.concat(diff, '\n')
    end
    return 'No diff available'
end

-- Get commit details for preview
local function get_commit_details(hash, filepath)
    local cmd = string.format('log -1 --pretty=format:"Author: %%an\nDate: %%ad\nCommit: %%h\n\n%%s\n\n%%b" --date=short %s', hash)
    local details = git_cmd(cmd)
    if details then
        local details_str = table.concat(details, '\n')
        local diff_str = get_commit_diff(hash, filepath)
        return details_str .. '\n\n--- DIFF ---\n' .. diff_str
    end
    return 'No commit details available'
end

-- ============================================
-- File Status Functions
-- ============================================
-- Get file status
local function get_file_status()
    local filepath = vim.fn.expand('%:p')

    -- Skip if file doesn't exist
    if not vim.fn.filereadable(filepath) then
        return 'non-existent'
    end

    -- Get git status for the file
    local status_output = git_cmd('status --porcelain')
    if not status_output then
        return 'not-in-repo'
    end

    -- Parse status output
    for _, line in ipairs(status_output) do
        local status, file_part = line:match('^(%S%S)%s+(.+)')
        if status and file_part then
            -- Normalize file paths for comparison
            local status_file = vim.fn.fnamemodify(file_part, ':p')
            if status_file == filepath then
                if status:match('^M') then
                    return 'modified'
                elseif status:match('^A') then
                    return 'added'
                elseif status:match('^D') then
                    return 'deleted'
                elseif status:match('^R') then
                    return 'renamed'
                elseif status:match('^C') then
                    return 'copied'
                else
                    return 'unknown'
                end
            end
        end
    end

    -- Check if file is tracked
    local tracked = git_cmd(string.format('ls-files --error-unmatch %s 2>/dev/null', vim.fn.shellescape(filepath)))
    if tracked then
        return 'unmodified'
    else
        return 'untracked'
    end
end

-- ============================================
-- Git History Functions
-- ============================================
-- Show git history for current file or selection
local function show_git_history()
    local filepath = vim.fn.expand('%:p')
    local file_status = get_file_status()
    
    -- Only proceed if file is tracked
    if file_status == 'untracked' then
        vim.notify('File is not tracked by git', vim.log.levels.WARN)
        return
    end
    
    -- Get git log for current file
    local lines = git_cmd(string.format('log --pretty=format:"%%h %%an %%ad %%s" --date=short --follow -- %s', vim.fn.shellescape(filepath)))
    
    if not lines then
        vim.notify('No git history found for this file', vim.log.levels.INFO)
        return
    end
    
    -- Check if telescope is available
    if pcall(require, 'telescope') then
        local pickers = require('telescope.pickers')
        local finders = require('telescope.finders')
        local conf = require('telescope.config').values
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')
        local previewers = require('telescope.previewers')
        
        local commits = {}
        for _, line in ipairs(lines) do
            local hash, author, date, message = line:match('(%x+) (.+) (%d%d%d%d%-%d%d%-%d%d) (.+)')
            if hash and author and date and message then
                table.insert(commits, { 
                    hash = hash, 
                    author = author, 
                    date = date, 
                    message = message,
                    filepath = filepath
                })
            end
        end
        
        pickers.new({}, {
            prompt_title = 'Git History',
            finder = finders.new_table({
                results = commits,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = string.format('%s %s %s %s', entry.hash, entry.date, entry.author, entry.message),
                        ordinal = string.format('%s %s %s %s', entry.date, entry.hash, entry.author, entry.message),
                        commit_hash = entry.hash,
                        filepath = entry.filepath
                    }
                end
            }),
            sorter = conf.generic_sorter({}),
            previewer = previewers.new_buffer_previewer({
                title = 'Commit Details',
                get_buffer_by_name = function(_, entry)
                    return entry.commit_hash
                end,
                define_preview = function(self, entry, status)
                    local details = get_commit_details(entry.commit_hash, entry.filepath)
                    vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(details, '\n'))
                    vim.api.nvim_buf_set_option(self.state.bufnr, 'filetype', 'diff')
                end
            }),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    if selection then
                        vim.cmd(string.format('Gedit %s:%s', selection.value.hash, selection.value.filepath))
                    end
                end)
                return true
            end
        }):find()
    else
        -- Fallback to quickfix if telescope is not available
        local qf_list = {}
        for i, line in ipairs(lines) do
            table.insert(qf_list, { filename = filepath, lnum = 1, col = 1, text = line })
        end
        vim.fn.setqflist(qf_list)
        vim.cmd('copen')
    end
end

-- ============================================
-- Selection Utilities
-- ============================================
-- Get selected line range
local function get_selected_lines()
    local start_line = vim.fn.line('v')
    local end_line = vim.fn.line('.')
    
    if start_line > end_line then
        start_line, end_line = end_line, start_line
    end
    
    return start_line, end_line
end

-- ============================================
-- Selected Lines History
-- ============================================
-- Show git history for selected lines
local function show_selected_lines_history()
    local filepath = vim.fn.expand('%:p')
    local file_status = get_file_status()
    
    -- Only proceed if file is tracked
    if file_status == 'untracked' then
        vim.notify('File is not tracked by git', vim.log.levels.WARN)
        return
    end
    
    local start_line, end_line = get_selected_lines()
    
    -- Get git log for selected lines
    local lines = git_cmd(string.format('log --pretty=format:"%%h %%an %%ad %%s" --date=short -L %d,%d:%s', start_line, end_line, vim.fn.shellescape(filepath)))
    
    if not lines then
        vim.notify('No git history found for selected lines', vim.log.levels.INFO)
        return
    end
    
    -- Check if telescope is available
    if pcall(require, 'telescope') then
        local pickers = require('telescope.pickers')
        local finders = require('telescope.finders')
        local conf = require('telescope.config').values
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')
        local previewers = require('telescope.previewers')
        
        local commits = {}
        for _, line in ipairs(lines) do
            local hash, author, date, message = line:match('(%x+) (.+) (%d%d%d%d%-%d%d%-%d%d) (.+)')
            if hash and author and date and message then
                table.insert(commits, { 
                    hash = hash, 
                    author = author, 
                    date = date, 
                    message = message,
                    filepath = filepath
                })
            end
        end
        
        pickers.new({}, {
            prompt_title = 'Git History (Selected Lines)',
            finder = finders.new_table({
                results = commits,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = string.format('%s %s %s %s', entry.hash, entry.date, entry.author, entry.message),
                        ordinal = string.format('%s %s %s %s', entry.date, entry.hash, entry.author, entry.message),
                        commit_hash = entry.hash,
                        filepath = entry.filepath
                    }
                end
            }),
            sorter = conf.generic_sorter({}),
            previewer = previewers.new_buffer_previewer({
                title = 'Commit Details',
                get_buffer_by_name = function(_, entry)
                    return entry.commit_hash
                end,
                define_preview = function(self, entry, status)
                    local details = get_commit_details(entry.commit_hash, entry.filepath)
                    vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(details, '\n'))
                    vim.api.nvim_buf_set_option(self.state.bufnr, 'filetype', 'diff')
                end
            }),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    if selection then
                        vim.cmd(string.format('Gedit %s:%s', selection.value.hash, selection.value.filepath))
                    end
                end)
                return true
            end
        }):find()
    else
        -- Fallback to quickfix if telescope is not available
        local qf_list = {}
        for i, line in ipairs(lines) do
            table.insert(qf_list, { filename = filepath, lnum = start_line, col = 1, text = line })
        end
        vim.fn.setqflist(qf_list)
        vim.cmd('copen')
    end
end

-- ============================================
-- Main History Handler
-- ============================================
-- Show git history for selected file(s)
local function show_selected_files_history()
    -- Check if we're in visual mode with selected lines
    if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' then
        -- Show history for selected lines
        show_selected_lines_history()
    else
        -- Show history for current file
        show_git_history()
    end
end

-- ============================================
-- Setup and Public API
-- ============================================
-- Setup function (no-op for now)
function M.setup()
    -- No setup needed for this simplified version
end

-- Public functions for keybindings
M.show_git_history = show_git_history
M.show_selected_files_history = show_selected_files_history

-- Export functions for external use
_G.git_history = M

return M

