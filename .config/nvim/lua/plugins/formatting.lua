return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = {
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
    formatters = {
      sqlfluff = {
        args = { 'format', '--dialect=ansi', '-' },
      },
      goimports = {
        inherit = true,
        prepend_args = { '-local', 'github.com/inDriver' },
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'goimports', 'gofumpt' },
      sql = { 'sqlfluff' },
    },
  },
}
