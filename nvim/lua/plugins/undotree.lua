vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

return {
	"mbbill/undotree", --undo history tree
	event = "BufReadPre",
	dependencies = "nvim-lua/plenary.nvim",
}
