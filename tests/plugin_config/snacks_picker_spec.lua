local keybindings = require("keybindings")

describe("Snacks Picker Migration", function()
  it("should have leader-e mapped to a function", function()
    local map = vim.fn.maparg("<leader>e", "n", false, true)
    assert.is_not_nil(map.callback or map.rhs, "Mapping for <leader>e should exist")
  end)

  it("should have leader-f mapped to a function", function()
    local map = vim.fn.maparg("<leader>f", "n", false, true)
    assert.is_not_nil(map.callback or map.rhs, "Mapping for <leader>f should exist")
  end)

  it("should have leader-gs mapped to git status", function()
    local map = vim.fn.maparg("<leader>gs", "n", false, true)
    assert.is_not_nil(map.callback or map.rhs, "Mapping for <leader>gs should exist")
  end)
end)
