-- vim.keymap.set("n", "<leader>xa", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>x", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
--
-- vim.keymap.set("n", "<leader>xq", function()
-- 	require("trouble").open("quickfix")
-- end)
--
-- vim.keymap.set("n", "<leader>xl", function()
-- 	require("trouble").open("loclist")
-- end)

return { -- LSP troubleshooting

	{
		"folke/trouble.nvim",
		event = "BufRead",
		opts = {},
		keys = {
			{ "<leaderxa", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true } },
			{ "<leader>x", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true } },
			{ "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true } },
			{ "gr", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true } },
			{
				"<leader>xq",
				function()
					require("trouble").open("quickfix")
				end,
			},
			{
				"<leader>xl",
				function()
					require("trouble").open("loclist")
				end,
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
