vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- if machine is windows
if vim.fn.has("win32") == 1 then
	vim.g.undotree_DiffCommand = "FC"
end

return {
	"mbbill/undotree", --undo history tree
	event = "BufReadPost",
	keys = { { "<leader>u", ":UndotreeToggle<CR>" } },
	dependencies = "nvim-lua/plenary.nvim",
}
