local builtin = require("telescope.builtin")
-- local telescope_setup, telescope = pcall(require, 'telescope')
-- if not telescope_setup then
-- 	return
-- end
local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		-- file_ignore_patterns = { "node_modules" },
		mappings = {
			i = {
				["<c-s>"] = "select_vertical",
				["<a-s>"] = "select_horizontal",
			},
			n = {
				["S"] = "select_horizontal",
				["s"] = "select_vertical",
				["<c-s>"] = "select_vertical",
				["<a-s>"] = "select_horizontal",
			},
		},
	},
	pickers = {
		buffers = {
			mappings = {
				i = {
					["<c-d>"] = actions.delete_buffer + actions.move_to_top,
				},
				n = {
					["d"] = actions.delete_buffer + actions.move_to_top,
				},
			},
		},
	},
})

-- enable neoclip extension
require("telescope").load_extension("neoclip")

--enable macroscope
require("telescope").load_extension("macroscope")

--keybinds
vim.keymap.set("n", "<leader>ft", ":Telescope<CR>")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
vim.keymap.set("n", "?", builtin.current_buffer_fuzzy_find, {})
vim.keymap.set("n", "<leader>fs", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>fd", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fh", builtin.buffers, {})
vim.keymap.set("n", "<leader>fp", ":Telescope neoclip <CR>", {})
vim.keymap.set("n", "<leader>fq", ":Telescope macroscope <CR>", {})
vim.keymap.set("n", "<leader>fb", ":Telescope buffers <CR>", {})