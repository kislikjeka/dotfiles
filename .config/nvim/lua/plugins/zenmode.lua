return {
  'folke/zen-mode.nvim',
  dependencies = { 'folke/twilight.nvim' },
  config = function()
    require('zen-mode').setup {
      window = {
        backdrop = 0.95,
        width = 160, -- width of the Zen window
        height = 1, -- height of the Zen window
        options = {
          signcolumn = 'no', -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        options = {
          enabled = true,
          ruler = true, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0, -- turn off the statusline in zen mode
        },

        twilight = { enabled = false },
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = false }, -- disables the tmux statusline
      },
    }

    vim.keymap.set('n', '<leader>zz', require('zen-mode').toggle, { desc = 'Toggle zenmode' })
  end,
}
