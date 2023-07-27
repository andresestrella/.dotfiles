local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ss", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>sa", mark.add_file)

vim.keymap.set("n", "<leader>su", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>si", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>so", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>sp", function() ui.nav_file(4) end)
