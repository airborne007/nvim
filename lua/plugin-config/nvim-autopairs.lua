return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    check_ts = true,
    ts_config = {
      lua = { 'string' }, -- don't add pair inside string nodes
      javascript = { 'template_string' },
      java = false,       -- don't check treesitter on java
    },
  },
}
