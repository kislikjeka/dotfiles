return {
  'folke/trouble.nvim',
  config = function()
    require('trouble').setup {
      focus = true,
      auto_jump = false,
      auto_close = true,
      warn_no_results = false,
      preview = {
        type = 'split',
        relative = 'win',
        size = 0.5,
        fixed = true,
        position = 'right',
        scratch = false,
      },
      modes = {
        symbols = {
          auto_preview = false,
          win = {
            size = 0.3,
          },
          preview = {
            position = 'left',
          },
        },
      },
    }
  end,
  cmd = 'Trouble',
  keys = {
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>ds',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
  },
}
