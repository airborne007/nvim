describe("snacks.notifier", function()
  it("should hijack vim.notify", function()
    -- Snacks.notifier is initialized during setup
    -- We want to ensure that vim.notify is replaced by Snacks
    
    -- First, ensure Snacks is loaded
    local status_ok, Snacks = pcall(require, "snacks")
    assert.is_true(status_ok, "Snacks should be loadable")
    
    -- Load project config for snacks
    local snacks_config = require("plugin-config.snacks")[1].opts
    Snacks.setup(snacks_config)
    
    -- Verify vim.notify is indeed the snacks one
    assert.is_not_nil(Snacks.notifier)
    local info = debug.getinfo(vim.notify)
    assert.is_not_nil(info.source:match("snacks"), "vim.notify should be hijacked by snacks")
  end)

  it("should hijack vim.ui.input and vim.ui.select", function()
    local Snacks = require("snacks")
    local snacks_config = require("plugin-config.snacks")[1].opts
    Snacks.setup(snacks_config)
    
    if Snacks.input and Snacks.input.enable then
      Snacks.input.enable()
    end
    if Snacks.picker and Snacks.picker.setup then
      Snacks.picker.setup()
    end
    
    local input_info = debug.getinfo(vim.ui.input)
    print("vim.ui.input source: " .. (input_info.source or "nil"))
    assert.is_not_nil(input_info.source:match("snacks"), "vim.ui.input should be hijacked by snacks")

    -- For select, it might be in picker
    local select_info = debug.getinfo(vim.ui.select)
    print("vim.ui.select source: " .. (select_info.source or "nil"))
    assert.is_not_nil(select_info.source:match("snacks"), "vim.ui.select should be hijacked by snacks")
  end)

  it("should not enable decorative modules (scroll, indent, scope, animate, words) for lightweight startup", function()
    local snacks_config = require("plugin-config.snacks")[1].opts

    assert.is_nil(snacks_config.scroll, "scroll should not be configured (disabled for lightweight startup)")
    assert.is_nil(snacks_config.indent, "indent should not be configured (disabled for lightweight startup)")
    assert.is_nil(snacks_config.scope, "scope should not be configured (disabled for lightweight startup)")
    assert.is_nil(snacks_config.animate, "animate should not be configured (disabled for lightweight startup)")
    assert.is_nil(snacks_config.words, "words should not be configured (disabled for lightweight startup)")
  end)

  it("should have dashboard enabled in config", function()
    local snacks_config = require("plugin-config.snacks")[1].opts
    assert.is_true(snacks_config.dashboard and snacks_config.dashboard.enabled, "dashboard should be enabled in config")
  end)
end)
