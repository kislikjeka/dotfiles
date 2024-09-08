M = {}

function M.setup_diagnostics()
  local diagnostics = {
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = 'if_many',
      prefix = '●',
      -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
      -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
      -- prefix = "icons",
    },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = require('utils.defaults').icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = require('utils.defaults').icons.diagnostics.Warn,
        [vim.diagnostic.severity.HINT] = require('utils.defaults').icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = require('utils.defaults').icons.diagnostics.Info,
      },
    },
  }

  -- set diagnostic icons
  for name, icon in pairs(require('utils.defaults').icons.diagnostics) do
    name = 'DiagnosticSign' .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
  end

  vim.diagnostic.config(vim.deepcopy(diagnostics))
end

return M
