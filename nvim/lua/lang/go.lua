return {
  {
    'stevearc/conform.nvim',
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { 'gofumpt', 'gci', 'golines' })
        end,
      },
    },
    ft = { 'go', 'gomod', 'gowork', 'gotmpl' },
    opts = {
      formatters_by_ft = {
        go = { 'gofumpt', 'gci' },
      },
      formatters = {
        gofumpt = {
          prepend_args = { '-extra' },
        },
        gci = {
          args = {
            'write',
            '-s standard',
            '-s default',
            "-s 'prefix(github.com/inDriver)'",
            '-s localmodule',
            '--skip-generated',
            '--custom-order',
            '$FILENAME',
          },
        },
      },
    },
  },
  {
    'nvim-neotest/neotest',
    ft = { 'go' },
    dependencies = {
      {
        'fredrikaverpil/neotest-golang',
      },
    },

    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      opts.adapters['neotest-golang'] = {
        go_test_args = {
          '-v',
          -- "-count=1",
          '-race',
          -- "-p=1",
          -- '-parallel=1',
          '-coverprofile='
            .. vim.fn.getcwd()
            .. '/coverage.out',
        },

        -- experimental
        dev_notifications = true,
        runner = 'gotestsum',
        gotestsum_args = { '--format=standard-verbose' },
        testify_enabled = true,
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
          {
            'williamboman/mason.nvim',
          },
        },
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, {
            'gopls',
          })
        end,
      },
    },
    ft = { 'go', 'gomod', 'gowork', 'gotmpl' },
    opts = function(_, opts)
      opts.servers = {
        gopls = {
          -- main readme: https://github.com/golang/tools/blob/master/gopls/doc/features/README.md
          --
          -- for all options, see:
          -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md
          -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
          -- for more details, also see:
          -- https://github.com/golang/tools/blob/master/gopls/internal/settings/settings.go
          -- https://github.com/golang/tools/blob/master/gopls/README.md

          settings = {

            gopls = {
              gofumpt = true,
              ['local'] = 'github.com/inDriver',
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                nilness = true,
                unusedparams = false,
                unusedwrite = true,
                fillstruct = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
              semanticTokens = true,
            },
          },
        },
      }
    end,
  },
  {
    'mfussenegger/nvim-dap',
    ft = { 'go' },
    dependencies = {
      {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = {
          'williamboman/mason.nvim',
        },
        opts = {
          ensure_installed = { 'delve' },
        },
      },
      {
        'leoluz/nvim-dap-go',
        opts = {},
      },
    },
    opts = {
      configurations = {
        go = {
          -- See require("dap-go") source for full dlv setup.
          {
            type = 'go',
            name = 'Debug test (manually enter test name)',
            request = 'launch',
            mode = 'test',
            program = './${relativeFileDirname}',
            args = function()
              local testname = vim.fn.input 'Test name (^regexp$ ok): '
              return { '-test.run', testname }
            end,
          },
        },
      },
    },
  },
}
