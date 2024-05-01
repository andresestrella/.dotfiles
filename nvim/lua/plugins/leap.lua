return {
	"ggandor/leap.nvim",
	dependencies = {
		"tpope/vim-repeat",
	},
	event = "BufRead",
	-- keys = {
	-- 	{ "<leader>h", "<Plug>(leap-forward-to)", mode = { "n", "x", "o" }, desc = "Leap forward to" },
	-- 	{ "<leader>H", "<Plug>(leap-backward-to)", mode = { "n", "x", "o" }, desc = "Leap backward to" },
	-- 	{ "<leader>HH", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "Leap from windows" },
	-- },
	config = function()
		vim.keymap.set({'n', 'x', 'o'}, '<leader>h',  '<Plug>(leap-forward)')
		vim.keymap.set({'n', 'x', 'o'}, '<leader>H',  '<Plug>(leap-backward)')
		vim.keymap.set({'n', 'x', 'o'}, '<leader>HH', '<Plug>(leap-from-window)')
	end,
	-- config = true,
}
