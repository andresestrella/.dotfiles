local builtin = require('telescope.builtin')
local telescope_setup, telescope = pcall(require, 'telescope')
if not telescope_setup then
	return
end

--keybind that maps <leader>pt to execute ':Telescope' command
vim.keymap.set('n', '<leader>pt', ":Telescope<CR>")

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

