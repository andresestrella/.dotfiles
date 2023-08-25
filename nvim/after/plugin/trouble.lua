vim.keymap.set("n", "<leader>xa", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>x", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>xq", function()
	require("trouble").open("quickfix")
end)

vim.keymap.set("n", "<leader>xl", function()
	require("trouble").open("loclist")
end)
