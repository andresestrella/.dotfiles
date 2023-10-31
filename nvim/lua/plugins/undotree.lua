vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

return {
	"mbbill/undotree", --undo history tree
	event = "BufReadPre",
	keys = { { "<leader>u", ":UndotreeToggle<CR>" } },
	dependencies = "nvim-lua/plenary.nvim",
}
