return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer', -- source for text in buffer
      'hrsh7th/cmp-path', -- source for file system paths in commands
      'L3MON4D3/LuaSnip', -- snippet engine
      'saadparwaiz1/cmp_luasnip', -- for lua autocompletion
      'rafamadriz/friendly-snippets', -- useful snippets library
    },
    config = function()
      local cmp = require 'cmp'

      local luasnip = require 'luasnip'

      -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup {
        preselect = cmp.PreselectMode.None,
        completion = {
          completeopt = 'menu,menuone,preview',
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(), -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.mapping.select_next_item()
            else
              fallback()
            end
          end,
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<C-e>'] = function(fallback)
            cmp.abort()
            fallback()
          end,
        },
        -- sources for autocompletion
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- snippets
        },
        {
          { name = 'buffer' }, -- text within current buffer
          { name = 'path' }, -- file system paths
        },
      }
    end,
  },
}
