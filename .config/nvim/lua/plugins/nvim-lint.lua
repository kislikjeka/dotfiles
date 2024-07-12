return {
  'mfussenegger/nvim-lint',
  opts = {
    -- Event to trigger linters
    events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
    linters_by_ft = {
      go = { 'golangcilint' },
      sql = { 'sqlfluff' },
    },
    linters = {},
  },
  config = function(_, opts)
    local lint = require 'lint'

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
    vim.keymap.set('n', '<leader>l', function()
      lint.try_lint()
    end, { desc = 'Trigger linting for current file' })
  end,
}
