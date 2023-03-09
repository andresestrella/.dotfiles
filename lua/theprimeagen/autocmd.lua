
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
-- Persistent Folds
local save_fold = augroup("Persistent Folds", { clear = true })
autocmd("BufWinLeave", {
  pattern = "*.*",
  callback = function()
    vim.cmd.mkview()
  end,
  group = save_fold,
})
autocmd("BufWinEnter", {
  pattern = "*.*",
  callback = function()
    vim.cmd.loadview({ mods = { emsg_silent = true } })
  end,
  group = save_fold,
})
-- Persistent Cursor
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- set up folding based on treesitter

local opt = vim.opt
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
--open all fold on startup
autocmd("BufReadPost", {
  pattern = "*.*",
  callback = function()
    vim.cmd("normal! zR")
  end,
})
