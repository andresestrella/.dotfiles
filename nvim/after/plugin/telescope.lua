local builtin = require('telescope.builtin')
-- local telescope_setup, telescope = pcall(require, 'telescope')
-- if not telescope_setup then
-- 	return
-- end

require('telescope').setup{
	defaults = {
		-- file_ignore_patterns = { "node_modules" },
		mappings = {
			n = {
				["S"] = "select_horizontal",
				["s"] = "select_vertical",
			}
		}
	},
	pickers = {},
}

-- enable neoclip extension
require('telescope').load_extension('neoclip')

--enable macroscope
require('telescope').load_extension('macroscope')

--keybind that maps <leader>pt to execute ':Telescope' command
vim.keymap.set('n', '<leader>ft', ":Telescope<CR>")
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '?', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>fd', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fh', builtin.buffers, {})
vim.keymap.set('n', '<leader>fp', ":Telescope neoclip <CR>", {})
vim.keymap.set('n', '<leader>fq', ":Telescope macroscope <CR>", {})
