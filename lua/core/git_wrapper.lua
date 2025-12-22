local M = {}

-- Smart Git History function
-- Switches between file history and line history based on current mode
function M.smart_git_history()
  local mode = vim.fn.mode()
  
  -- Check for visual modes: v (char), V (line), or CTRL-V (block)
  -- Note: We check if the mode starts with v/V or is the control character
  if mode == 'v' or mode == 'V' or mode == '\22' then
    if _G.Snacks and _G.Snacks.picker then
      _G.Snacks.picker.git_log_line()
    else
      vim.notify("Snacks.picker.git_log_line is not available", vim.log.levels.ERROR)
    end
  else
    if _G.Snacks and _G.Snacks.picker then
      _G.Snacks.picker.git_log()
    else
      vim.notify("Snacks.picker.git_log is not available", vim.log.levels.ERROR)
    end
  end
end

return M