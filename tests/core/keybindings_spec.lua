local keybindings = require("keybindings")

describe("keybindings", function()
  it("should return a table with plugin mapping functions", function()
    assert.is_table(keybindings)
    assert.is_function(keybindings.mapgit)
    assert.is_function(keybindings.maplsp)
    assert.is_function(keybindings.nvimTreeOnAttach)
    assert.is_table(keybindings.blinkCmpKeys)
  end)

  describe("maplsp", function()
    it("should call the provided mapper function with LSP keybindings", function()
      local mappings = {}
      local fake_mapper = function(mode, key, cmd, opts)
        table.insert(mappings, { mode = mode, key = key, cmd = cmd, opts = opts })
      end

      keybindings.maplsp(fake_mapper)

      -- Check if some key LSP mappings are present
      local found_rn = false
      local found_gd = false
      for _, m in ipairs(mappings) do
        if m.key == "<leader>rn" then found_rn = true end
        if m.key == "gd" then found_gd = true end
      end

      assert.is_true(found_rn, "Rename mapping not found")
      assert.is_true(found_gd, "Go to definition mapping not found")
    end)
  end)
end)
