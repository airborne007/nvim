-- Test global keybindings in keybindings.lua
require("keybindings")

describe("keybindings", function()
  it("should have global editing keybindings", function()
    local map = vim.fn.maparg("<leader><space>", "n", false, true)
    assert.is_not_nil(map)
    assert.are.same(":noh<CR>", map.rhs)
  end)

  it("should have window management keybindings", function()
    -- Check window switching
    local map_h = vim.fn.maparg("<C-h>", "n", false, true)
    assert.is_not_nil(map_h)
    assert.are.same("<C-w>h", map_h.rhs)

    -- Check window splitting
    local map_v = vim.fn.maparg("<leader>v", "n", false, true)
    assert.is_not_nil(map_v)
    assert.are.same(":vsplit<CR>", map_v.rhs)
  end)

  it("should have visual mode indentation keybindings", function()
    local map_indent = vim.fn.maparg(">", "v", false, true)
    assert.is_not_nil(map_indent)
    assert.are.same(">gv", map_indent.rhs)
  end)
end)