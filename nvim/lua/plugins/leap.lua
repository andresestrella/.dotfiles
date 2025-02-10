return {
	"ggandor/leap.nvim",
	dependencies = {
		"tpope/vim-repeat",
	},
	event = "BufRead",
	config = function()
		vim.keymap.set({'n', 'x', 'o'}, '<leader>h',  '<Plug>(leap)')
		-- vim.keymap.set({'n', 'x', 'o'}, '<leader>h',  '<Plug>(leap-forward)')
		-- vim.keymap.set({'n', 'x', 'o'}, '<leader>H',  '<Plug>(leap-backward)')
		vim.keymap.set({'n', 'x', 'o'}, '<leader>H', '<Plug>(leap-from-window)')
	end,
	-- config = true,
}
