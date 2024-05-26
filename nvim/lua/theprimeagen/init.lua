vim.g.mapleader = " "

require "theprimeagen.set"
-- autocmds and keymaps can wait to load
vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
  pattern = "VeryLazy",
  callback = function()
    require "theprimeagen.autocmds"
    require "theprimeagen.remap"
  end,
})
require "theprimeagen.lazy"
