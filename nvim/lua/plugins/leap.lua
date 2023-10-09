return {
	"ggandor/leap.nvim",
	enabled = true,
	dependencies = {
		"tpope/vim-repeat",
	},
	-- config = true,
	config = function()
		require('leap').add_default_mappings()
	end,
	keys = {
		{
			"<leader>H",
			"<Plug>(leap-backward-till)",
			desc = "Leap backward",
		},
		{
			"<leader>lw",
			"<Plug>(leap-cross-window)",
			desc = "Leap cross window",
		},
		{

			"<leader>h",
			"<Plug>(leap-forward-till)",
			desc = "Leap forward",
		},
	},
}
