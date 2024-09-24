return {
  "folke/zen-mode.nvim",
  opts = {
    window = {
      width = 0.8, -- width will be 85% of the editor width
    },
    plugins = {
      twilight = {
        enabled = false,
      },
    },
  },
  keys = {
    { "<leader>zz", "<cmd>ZenMode<cr>", desc = "ZenMode" },
  },
}
