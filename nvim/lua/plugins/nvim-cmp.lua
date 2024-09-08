return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      {
        'hrsh7th/cmp-nvim-lsp',
        dependencies = {
          {
            'L3MON4D3/LuaSnip',
            dependencies = {
              'saadparwaiz1/cmp_luasnip',
              'rafamadriz/friendly-snippets',
            },
          },
        },
      },
      { 'hrsh7th/cmp-cmdline' },
    },

    config = function(_, opts)
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()

      local sources = opts.sources or {}
      vim.list_extend(sources, {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
      })

      cmp.setup {
        preselect = cmp.PreselectMode.None,
        completion = {
          completetopt = 'menu,menuone,preview',
        },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert(require('config.keymaps').setup_cmp_keymaps(cmp)),
        sources = cmp.config.sources(sources),
      }

      -- `/` cmdline setup.
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          {
            name = 'cmdline',
          },
        }),
      })
    end,
  },
}
