return {
  {
    'stevearc/conform.nvim',
    ft = { 'sql' },
    opts = {
      formatters_by_ft = {
        sql = { 'sqlfluff' },
      },
      formatters = {
        sqlfluff = {
          inherit = false,
          args = { 'fix', '-', '--dialect=mysql' },
          command = 'sqlfluff',
          require_cwd = false,
        },
      },
    },
  },
}
