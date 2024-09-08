return {
  -- {
  --   'catppuccin/nvim',
  --   priority = 1000,
  --   init = function()
  --     vim.cmd.colorscheme 'catppuccin'
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },
  -- {
  --   'sainnhe/gruvbox-material',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     vim.g.gruvbox_material_enable_italic = false
  --     vim.cmd.colorscheme 'gruvbox-material'
  --   end,
  -- },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nordic').load()
    end,
  },
}
