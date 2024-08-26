local lsp = require 'functions.lsp'

local described = lsp.described

local opts = { noremap = true, silent = true }

local function setup_generic()
  local lspconfig = require 'lspconfig'

  local generic_servers = {
    'clojure_lsp',
    'rust_analyzer',
    'bashls',
  }
  for _, client in ipairs(generic_servers) do
    lspconfig[client].setup {
      on_attach = lsp.on_attach,
      capabilities = lsp.get_capabilities(),
    }
  end
end

local function setup_lua()
  local lspconfig = require 'lspconfig'

  lspconfig.lua_ls.setup {
    on_attach = lsp.on_attach,
    capabilities = lsp.get_capabilities(),
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            'vim',
            'assert',
            'describe',
            'it',
            'before_each',
            'after_each',
            'pending',
            'clear',

            'G_P',
            'G_R',
          },
        },
        format = {
          enable = false,
        },
      },
    },
  }
end

local function setup_go()
  local lspconfig = require 'lspconfig'
  lspconfig.gopls.setup {
    on_attach = lsp.on_attach,
    capabilities = lsp.get_capabilities(),
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
  }
end

return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      setup_generic()
      setup_lua()
      setup_go()

      local bufopts = { noremap = true, silent = true }

      vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, described(opts, 'diagnostics'))

      vim.keymap.set('n', '<leader>lr', '<cmd>LspRestart<cr>')

      vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, described(bufopts, 'Perform code action'))
    end,
  },
}
