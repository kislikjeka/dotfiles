return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = 'n',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = {
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      yaml = { 'yamllint' },
      md = { 'markdownlint' },
    },
  },
}
