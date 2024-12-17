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
		cmd = 'Trouble',
		keys = {
			{ "gr", ":Trouble lsp_references toggle focus<cr>", desc = "LSP references (Trouble)" },
			-- { "gr", ":Trouble lsp toggle<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
			{ "<leader>x", ":Trouble diagnostics toggle filter.buf=0<CR>", desc = "Togle trouble document diagnostics" },
			{ "<leader>xx", ":Trouble diagnostics toggle<CR>", desc = "Toggle trouble diagnostics" },
			{ "<leader>xa", ":Trouble diagnostics toggle<CR>", desc = "Toggle trouble diagnostics" },
			{ "<leader>xt", ":Trouble todo toggle<CR>", desc = "Toggle trouble todos list" },
			{ "<leader>xq", ":Trouble quickfix toggle<CR>", desc = "Toggle trouble quickfix list" },
			{ "<leader>xl", ":Trouble loclist toggle<CR>", desc = "Toggle trouble location list" },
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
