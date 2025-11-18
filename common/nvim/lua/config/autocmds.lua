-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- local autocmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_augroup
--
-- local AndresGroup = augroup("Andres", {})
-- autocmd({ "FocusGained", "BufEnter" }, {
-- 	group = AndresGroup,
-- 	command = "checktime",
-- 	desc = "Check for file changes outside of Neovim",
-- })
--
-- Disable autoformat for certain files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lua", "python" },
  callback = function()
    vim.b.autoformat = false
  end,
})
