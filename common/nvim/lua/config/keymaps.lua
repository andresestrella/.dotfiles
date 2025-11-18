-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--exit insert mode with jk or Ctrl c
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "<C-c>", "<Esc>")

-- go to end of line with =
vim.keymap.set("v", "=", "$")

--clear search highlighting with <leader>nh
vim.keymap.set("n", "<leader>nh", ":nohl<CR>")
--delete current letter without yankin
vim.keymap.set("n", "x", '"_x')

-- maps shift tab to insert backwards tab
vim.keymap.set("i", "<S-Tab>", "<C-d>")

--add new below current line in normal mode and maintain cursor postion
vim.keymap.set("n", "oo", "m`o<Esc>``")
vim.keymap.set("n", "OO", "m`O<Esc>``")
--add new line above and below current line in normal mode and maintain cursor postion
vim.keymap.set("n", "<leader>o", "m`o<Esc>kO<Esc>``i")

--move lines up and down when highlighted
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--scroll up and down half a page and center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

--maps pressing n and N to center the screen on the next match
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever -- paste over selected text without yanking it
vim.keymap.set("x", "<leader>p", [["_dP]])

-- yank current file path from project root
vim.keymap.set("n", "<leader>yp", [[:let @+ = fnamemodify(expand("%"), ":~:.")<CR>]])
-- yank current absolute file
vim.keymap.set("n", "<leader>yP", [[:let @+ = expand("%:p")<CR>]])

--maps leader d to delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

--makes Q do nothing
vim.keymap.set("n", "Q", "<nop>")

--find all occurences of word under cursor and replace all of them with the same word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--find all occurrences of selected text and replace all of them with the same text
vim.keymap.set("v", "<leader>s", [["hy:%s/<C-r>h//gc<left><left><left>]])

-- find and replace in visual mode for current selection
vim.api.nvim_set_keymap(
  "x",
  "<C-s>",
  [[<Cmd>let @h = @"<CR>:%s/\%V\%V<C-R>=escape(@h, '/\')<CR>//gc<left><left><left>]],
  { noremap = true, silent = true }
)

--window splitting
-- vim.keymap.set("n", "<A-s>", ":split<CR>") -- Alt+s for horizontal split
-- vim.keymap.set("n", "<C-S-s>", ":split<CR>") -- Ctrl+Shift+s for horizontal split
vim.keymap.set("n", "<C-_>", ":split<CR>") -- Ctrl+- for horizontal split
vim.keymap.set("n", "<leader>_", ":split<CR>") -- Ctrl+- for horizontal split

-- vim.keymap.set("n", "<C-s>", ":vsplit<CR>") -- Ctrl+s for vertical split
vim.keymap.set("n", "<C-\\>", ":vsplit<CR>") -- Ctrl+w s for vertical split
vim.keymap.set("n", "<leader>\\", ":vsplit<CR>") -- Ctrl+w s for vertical split

-- Resize windows with cmd + shift + hjkl
vim.keymap.set("n", "<C-S-h>", ":vertical resize -6<CR>", { desc = "Decrease window width (left)" })
vim.keymap.set("n", "<C-S-l>", ":vertical resize +6<CR>", { desc = "Increase window width (right)" })
vim.keymap.set("n", "<C-S-k>", ":resize +6<CR>", { desc = "Increase window height (up)" })
vim.keymap.set("n", "<C-S-j>", ":resize -6<CR>", { desc = "Decrease window height (down)" })

--close window
vim.keymap.set("n", "<C-c>", ":close<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-q>", ":bd<CR>", { silent = true, noremap = true })

--tabs
vim.keymap.set("n", "<C-t>", ":tabnew<CR>")
vim.keymap.set("n", "<C-w>t", ":bufdo tab split<CR>")

--bracket remaps
vim.keymap.set("n", "[t", ":tabprevious<CR>")
vim.keymap.set("n", "]t", ":tabnext<CR>")
vim.keymap.set("n", "[T", ":tabfirst<CR>")
vim.keymap.set("n", "]T", ":tablast<CR>")
