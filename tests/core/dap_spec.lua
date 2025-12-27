-- Test DAP keybindings in the plugin specification
local dap_spec = require("plugin-config.dap")[1]

describe("DAP Keybindings Spec", function()
  it("should define necessary keys in the specification", function()
    assert.is_table(dap_spec.keys)
    
    local found_keys = {}
    for _, key_def in ipairs(dap_spec.keys) do
      found_keys[key_def[1]] = true
    end
    
    assert.is_true(found_keys["<F5>"], "F5 mapping missing in spec")
    assert.is_true(found_keys["<F9>"], "F9 mapping missing in spec")
    assert.is_true(found_keys["<leader>du"], "leader-du mapping missing in spec")
  end)
end)
