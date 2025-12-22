local extension = require("core.extension")

describe("core.extension", function()
  before_each(function()
    -- Reset state if possible, but since variables are local to the module,
    -- and require caches it, we might need to manually reset the state 
    -- by interacting with the public API or clearing package.loaded.
    package.loaded["core.extension"] = nil
    extension = require("core.extension")
  end)

  describe("Plugin Enable/Disable", function()
    it("should disable a plugin", function()
      extension.disable_plugin("test-plugin")
      assert.is_true(extension.is_plugin_disabled("test-plugin"))
    end)

    it("should enable a disabled plugin", function()
      extension.disable_plugin("test-plugin")
      extension.enable_plugin("test-plugin")
      assert.is_false(extension.is_plugin_disabled("test-plugin"))
    end)

    it("should get the list of disabled plugins", function()
      extension.disable_plugin("plugin1")
      extension.disable_plugin("plugin2")
      local disabled = extension.get_disabled_plugins()
      table.sort(disabled)
      assert.are.same({ "plugin1", "plugin2" }, disabled)
    end)
  end)

  describe("Extension Management", function()
    it("should add a new extension", function()
      local ext = { name = "my-ext", enabled = true }
      local success = extension.add_extension(ext)
      assert.is_true(success)
      assert.are.same(ext.name, extension.get_extension("my-ext").name)
    end)

    it("should not add an extension without a name", function()
      local success = extension.add_extension({ enabled = true })
      assert.is_false(success)
    end)

    it("should not add a duplicate extension", function()
      extension.add_extension({ name = "duplicate" })
      local success = extension.add_extension({ name = "duplicate" })
      assert.is_false(success)
    end)

    it("should enable/disable an extension", function()
      extension.add_extension({ name = "toggle-ext", enabled = true })
      extension.disable_extension("toggle-ext")
      assert.is_false(extension.get_extension("toggle-ext").enabled)
      extension.enable_extension("toggle-ext")
      assert.is_true(extension.get_extension("toggle-ext").enabled)
    end)
  end)

  describe("Plugin Overrides", function()
    it("should set and get plugin overrides", function()
      local override = { some_config = true }
      extension.override_plugin_config("my-plugin", override)
      assert.are.same(override, extension.get_plugin_overrides()["my-plugin"])
    end)

    it("should apply table overrides to a plugin", function()
      extension.override_plugin_config("test-plugin", { new_val = 123 })
      local plugin = { "test-plugin", old_val = 456 }
      local result = extension.apply_plugin_overrides(plugin)
      assert.are.same(123, result.new_val)
      assert.are.same(456, result.old_val)
    end)

    it("should apply function overrides to a plugin", function()
      extension.override_plugin_config("test-plugin", function(p)
        p.modified = true
        return p
      end)
      local plugin = { "test-plugin" }
      local result = extension.apply_plugin_overrides(plugin)
      assert.is_true(result.modified)
    end)
  end)
end)
