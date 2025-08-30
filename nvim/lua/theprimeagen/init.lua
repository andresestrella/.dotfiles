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

-- set colorscheme
--
-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])
--
vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("catppuccin-frappe")
-- vim.cmd.colorscheme("catppuccin-macchiato")
-- vim.cmd.colorscheme("catppuccin-latte")
