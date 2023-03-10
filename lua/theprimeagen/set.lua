vim.opt.nu = true
vim.opt.relativenumber = true

-- set timeoutlen to 200 ms
vim.opt.timeoutlen = 200

--tabs
vim.opt.showtabline = 4 -- always show tabs
vim.opt.tabstop = 4 -- insert 4 spaces for a tab
vim.opt.softtabstop = 4 -- change number of space characters inserted for indentation
vim.opt.shiftwidth = 4 -- change the number of space characters inserted for indentation
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.smarttab = true -- makes tabbing smarter will realize you have 4 vs 4
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.backup = false -- creates a backup file
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.title = true -- set the title of window to the value of the titlestring
