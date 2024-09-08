return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  version = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
    'Marskey/telescope-sg',
    {
      'isak102/telescope-git-file-history.nvim',
      dependencies = { 'tpope/vim-fugitive' },
    },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local telescopeConfig = require 'telescope.config'
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local utils = require 'telescope.utils'
    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, '--hidden')
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, '--glob')
    table.insert(vimgrep_arguments, '!**/.git/*')

    telescope.setup {
      extensions = {
        advanced_git_search = {},
        ast_grep = {
          command = {
            'sg',
            '--json=stream',
          },
          grep_open_files = false,
          lang = nil,
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
      defaults = {
        path_display = { 'smart' },
        file_ignore_patterns = { 'node_modules', '.git/' },
        vimgrep_arguments = vimgrep_arguments,

        -- TODO: Think of the way to make
        --  it work only for buffers dialog
        mappings = {
          n = {
            ['<c-b>'] = require('telescope.actions').delete_buffer,
          },
          i = {
            ['<c-b>'] = require('telescope.actions').delete_buffer,
          },
        },
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { 'rg', '--files', '--no-ignore', '--hidden', '--glob', '!**/.git/*' },
        },
      },
    }

    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'git_file_history'

    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch fuzzy [G]lobaly' })
    vim.keymap.set('n', '<leader>sl', function()
      builtin.live_grep { cwd = utils.buffer_dir() }
    end, { desc = '[S]earch [L]ocal dir' })

    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[ ] Find existing buffers' })
  end,
}
