return { -- LSP troubleshooting

	{
		"folke/trouble.nvim",
		event = "BufRead",
		opts = {},
		cmd = 'Trouble',
		keys = {
			{ "<leader>x",  ":Trouble diagnostics toggle filter.buf=0<CR>", desc = "Togle trouble document diagnostics" },
			{ "<leader>xx", ":Trouble diagnostics toggle<CR>",              desc = "Toggle trouble diagnostics" },
			{ "<leader>xa", ":Trouble diagnostics toggle<CR>",              desc = "Toggle trouble diagnostics" },
			{ "<leader>xt", ":Trouble todo toggle<CR>",                     desc = "Toggle trouble todos list" },
			{ "<leader>xq", ":Trouble quickfix toggle<CR>",                 desc = "Toggle trouble quickfix list" },
			{ "<leader>xf", ":Trouble loclist toggle<CR>",                  desc = "Toggle trouble location list" },
			{
				"<leader>xl",
				function() vim.diagnostic.open_float(0, { scope = "line", focusable = false }) end,
				desc = "Open diagnostic float"
			},
		},
		config = function()
			require("trouble").setup({
				-- icons = false,
				action_keys = {
					close = { "q", "<c-x>", "<c-c>" },
					open_vsplit = "<c-s>",
					open_split = "<a-s>",
				},
			})
		end,
	},
}
