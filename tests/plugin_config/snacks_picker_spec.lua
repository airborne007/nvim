-- Test Snacks Picker keybindings in the plugin specification
local snacks_spec = require("plugin-config.snacks")[1]

describe("Snacks Picker Keybindings Spec", function()
  it("should define necessary keys in the specification", function()
    assert.is_table(snacks_spec.keys)
    
    local found_keys = {}
    for _, key_def in ipairs(snacks_spec.keys) do
      found_keys[key_def[1]] = true
    end
    
    assert.is_true(found_keys["<leader>e"], "leader-e mapping missing in spec")
    assert.is_true(found_keys["<leader>f"], "leader-f mapping missing in spec")
    assert.is_true(found_keys["<leader>gs"], "leader-gs mapping missing in spec")
  end)
end)
