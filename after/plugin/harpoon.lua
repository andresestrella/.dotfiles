local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>h", mark.add_file)
vim.keymap.set("n", "<C-h>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-b>", function() ui.nav_file(4) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-m>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-,>", function() ui.nav_file(1) end)


