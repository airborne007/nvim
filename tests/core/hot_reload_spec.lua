local hot_reload = require("core.hot_reload")

describe("Hot Reload", function()
  it("can be required", function()
    assert.is_not_nil(hot_reload)
  end)

  it("can reload all modules without error", function()
    -- Mock vim.notify to avoid output noise and check for errors
    local original_notify = vim.notify
    local notifications = {}
    vim.notify = function(msg, level)
      table.insert(notifications, { msg = msg, level = level })
    end

    -- Call reload_all (which calls reload_all_modules)
    hot_reload.reload_all()

    -- Check notifications
    local has_error = false
    for _, n in ipairs(notifications) do
      if n.level == vim.log.levels.ERROR then
        has_error = true
        print("Error notification: " .. n.msg)
      end
    end
    
    assert.is_false(has_error, "reload_all should not report errors")

    -- Restore notify
    vim.notify = original_notify
  end)
end)
