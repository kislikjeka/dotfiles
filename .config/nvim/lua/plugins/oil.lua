return {
  'stevearc/oil.nvim',
  lazy = false,
  keys = {
    {
      '<C-v>',
      function()
        require('oil').select { vertical = true, close = true }
      end,
      desc = 'select_vsplit',
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      view_options = {
        show_hidden = true,
      },
    }
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
