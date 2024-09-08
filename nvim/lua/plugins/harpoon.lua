return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    keys = {
      '<leader>ha',
      '<leader>hA',
      '<leader>hr',
      '<leader>hh',
      '[h',
      '[H',
      ']h',
      ']H',
    },
    config = function()
      local harpoon = require 'harpoon'

      harpoon:setup()

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<leader>hr', function()
        harpoon:list():remove()
      end)
      vim.keymap.set('n', '<leader>hh', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set('n', '<M-1>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<M-2>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<M-3>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<M-4>', function()
        harpoon:list():select(4)
      end)
      vim.keymap.set('n', '<leader><M-1>', function()
        harpoon:list():replace_at(1)
      end)
      vim.keymap.set('n', '<leader><M-2>', function()
        harpoon:list():replace_at(2)
      end)
      vim.keymap.set('n', '<leader><M-3>', function()
        harpoon:list():replace_at(3)
      end)
      vim.keymap.set('n', '<leader><M-4>', function()
        harpoon:list():replace_at(4)
      end)
    end,
  },
}
