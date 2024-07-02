return {
  'nvim-cmp',
  dependencies = {
    {
      'garymjr/nvim-snippets',
      opts = {
        friendly_snippets = true,
        create_cmp_source = true,
      },
      dependencies = { 'rafamadriz/friendly-snippets' },
    },
  },
  keys = {
    {
      '<C-l>',
      function()
        return vim.snippet.active { direction = 1 } and '<cmd>lua vim.snippet.jump(1)<cr>' or '<C-l>'
      end,
      expr = true,
      silent = true,
      mode = { 'i', 's' },
    },
    {
      '<C-h>',
      function()
        return vim.snippet.active { direction = -1 } and '<cmd>lua vim.snippet.jump(-1)<cr>' or '<C-h>'
      end,
      expr = true,
      silent = true,
      mode = { 'i', 's' },
    },
  },
}
