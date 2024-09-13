-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keyamaps.del("n", "<A-j>")
vim.keyamaps.del("n", "<A-k>")
vim.keyamaps.del("i", "<A-j>")
vim.keyamaps.del("i", "<A-k>")
vim.keyamaps.del("v", "<A-j>")
vim.keyamaps.del("v", "<A-k>")

vim.keyamaps.del("n", "<leader>l")
vim.keyamaps.del("n", "<leader>L")

vim.keyamaps.del("n", "<leader>w")
vim.keyamaps.del("n", "<leader>-")
vim.keyamaps.del("n", "<leader>|")
vim.keyamaps.del("n", "<leader>wd")
-- LazyVim.toggle.map("<leader>wm", LazyVim.toggle.maximize)

vim.keyamaps.del("n", "<leader><tab>l")
vim.keyamaps.del("n", "<leader><tab>o")
vim.keyamaps.del("n", "<leader><tab>f")
vim.keyamaps.del("n", "<leader><tab><tab>")
vim.keyamaps.del("n", "<leader><tab>]")
vim.keyamaps.del("n", "<leader><tab>d")
vim.keyamaps.del("n", "<leader><tab>[")
