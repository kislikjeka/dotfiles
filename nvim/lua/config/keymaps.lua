M = {}

function M.setup_lsp_autocmd_keymaps(event)
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc, nowait = true })
  end

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

  -- Find references for the word under your cursor.
  map('gr', ':lua require("telescope.builtin").lsp_references({ show_line = false })<CR>', '[G]oto [R]eferences')

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map('gt', require('telescope.builtin').lsp_type_definitions, '[G]oto [t]ype definition')

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map('<leader>cS', require('telescope.builtin').lsp_document_symbols, 'Do[c]ument [S]ymbols (telescope)')

  -- Fuzzy find all the symbols in your current workspace
  --  Similar to document symbols, except searches over your whole project.
  map('<leader>cw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols (telescope)')

  -- Rename the variable under your cursor
  --  Most Language Servers support renaming across files, etc.
  map('<leader>rn', vim.lsp.buf.rename, '[C]ode [R]ename')

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap
  map('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header
  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
end

function M.setup_whichkey()
  local wk = require 'which-key'
  wk.add {
    { '<leader>a', group = 'ai' },
    { '<leader>c', group = 'code' },
    { '<leader>d', group = 'debug' },
    { '<leader>f', group = 'file' },
    { '<leader>g', group = 'git' },
    { '<leader>gb', group = 'blame' },
    { '<leader>gd', group = 'diffview' },
    { '<leader>gh', group = 'hunks' },
    { '<leader>gt', group = 'telescope' },
    { '<leader>n', group = 'notes' },
    { '<leader>r', group = 'run' },
    { '<leader>s', group = 'search' },
    { '<leader>t', group = 'test' },
    { '<leader>u', group = 'ui' },
    { '<leader>x', group = 'diagnostics/quickfix' },
  }
end

function M.setup_whichkey_contextual()
  return {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  }
end

function M.setup_dap_ui_keymaps()
  -- keymaps: https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt#L508
  return {
    {
      '<leader>du',
      function()
        require('dapui').toggle {}
      end,
      desc = 'DAP UI',
    },

    {
      '<leader>de',
      function()
        require('dapui').eval()
      end,
      desc = 'DAP Eval',
    },
  }
end

function M.setup_dap_keymaps()
  return {
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'toggle [d]ebug [b]reakpoint',
    },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = '[d]ebug [B]reakpoint',
    },
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = '[d]ebug [c]ontinue (start here)',
    },
    {
      '<leader>dC',
      function()
        require('dap').run_to_cursor()
      end,
      desc = '[d]ebug [C]ursor',
    },
    {
      '<leader>dg',
      function()
        require('dap').goto_()
      end,
      desc = '[d]ebug [g]o to line',
    },
    {
      '<leader>do',
      function()
        require('dap').step_over()
      end,
      desc = '[d]ebug step [o]ver',
    },
    {
      '<leader>dO',
      function()
        require('dap').step_out()
      end,
      desc = '[d]ebug step [O]ut',
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = '[d]ebug [i]nto',
    },
    {
      '<leader>dj',
      function()
        require('dap').down()
      end,
      desc = '[d]ebug [j]ump down',
    },
    {
      '<leader>dk',
      function()
        require('dap').up()
      end,
      desc = '[d]ebug [k]ump up',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = '[d]ebug [l]ast',
    },
    {
      '<leader>dp',
      function()
        require('dap').pause()
      end,
      desc = '[d]ebug [p]ause',
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.toggle()
      end,
      desc = '[d]ebug [r]epl',
    },
    {
      '<leader>dR',
      function()
        require('dap').clear_breakpoints()
      end,
      desc = '[d]ebug [R]emove breakpoints',
    },
    {
      '<leader>ds',
      function()
        require('dap').session()
      end,
      desc = '[d]ebug [s]ession',
    },
    {
      '<leader>dt',
      function()
        require('dap').terminate()
      end,
      desc = '[d]ebug [t]erminate',
    },
    {
      '<leader>dw',
      function()
        require('dap.ui.widgets').hover()
      end,
      desc = '[d]ebug [w]idgets',
    },
  }
end

function M.setup_neotest_keymaps()
  return {
    {
      '<leader>ta',
      function()
        require('neotest').run.attach()
      end,
      desc = 'Attach',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Run File',
    },
    {
      '<leader>tA',
      function()
        require('neotest').run.run(vim.uv.cwd())
      end,
      desc = 'Run All Test Files',
    },
    {
      '<leader>tT',
      function()
        require('neotest').run.run { suite = true }
      end,
      desc = 'Run Test Suite',
    },
    {
      '<leader>tn',
      function()
        require('neotest').run.run()
      end,
      desc = 'Run Nearest',
    },
    {
      '<leader>tl',
      function()
        require('neotest').run.run_last()
      end,
      desc = 'Run Last',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle Summary',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open { enter = true, auto_close = true }
      end,
      desc = 'Show Output',
    },
    {
      '<leader>tO',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = 'Toggle Output Panel',
    },
    {
      '<leader>tt',
      function()
        require('neotest').run.stop()
      end,
      desc = 'Terminate',
    },
    {
      '<leader>td',
      function()
        require('neotest').summary.close()
        require('neotest').output_panel.close()
        require('neotest').run.run { suite = false, strategy = 'dap' }
      end,
      desc = 'Debug nearest test',
    },
  }
end

function M.setup_cmp_keymaps(cmp)
  local luasnip = require 'luasnip'
  return {
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
    ['<C-n>'] = cmp.mapping.select_next_item(), -- Select the [p]revious item
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.mapping.select_next_item()
      else
        fallback()
      end
    end,
    ['<C-e>'] = function(fallback)
      cmp.abort()
      fallback()
    end,

    -- If nothing is selected (including preselections) add a newline as usual.
    -- If something has explicitly been selected by the user, select it.
    ['<Enter>'] = function(fallback)
      -- Don't block <CR> if signature help is active
      -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/issues/13
      if not cmp.visible() or not cmp.get_selected_entry() or cmp.get_selected_entry().source.name == 'nvim_lsp_signature_help' then
        fallback()
      else
        cmp.confirm {
          -- Replace word if completing in the middle of a word
          -- https://github.com/hrsh7th/nvim-cmp/issues/664
          behavior = cmp.ConfirmBehavior.Replace,
          -- Don't select first item on CR if nothing was selected
          select = false,
        }
      end
    end,
  }
end

function M.setup_snippets_keymaps()
  local luasnip = require 'luasnip'
  local cmp = require 'cmp'

  return {
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
  }
end

return M
