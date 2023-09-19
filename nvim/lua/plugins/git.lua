vim.keymap.set("n", "<leader>g", vim.cmd.Git)
vim.keymap.set("n", "gj", "<cmd>diffget //2<cr>")
vim.keymap.set("n", "gf", "<cmd>diffget //3<cr>")

local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
	group = ThePrimeagen_Fugitive,
	pattern = "*",
	callback = function()
		if vim.bo.ft ~= "fugitive" then
			return
		end

		local bufnr = vim.api.nvim_get_current_buf()
		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "<leader>p", function()
			vim.cmd.Git("push")
		end, opts)

		-- rebase always
		vim.keymap.set("n", "<leader>P", function()
			vim.cmd.Git({ "pull", "--rebase" })
		end, opts)

		-- NOTE: It allows me to easily set the branch i am pushing and any tracking
		-- needed if i did not set the branch up correctly
		vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
	end,
})

return {
	{
		"theprimeagen/git-worktree.nvim",
		keys = {
			{
				"<leader>gt",
				function()
					require("telescope").extensions.git_worktree.git_worktrees()
				end,
			},
			{
				"<leader>gn",
				function()
					require("telescope").extensions.git_worktree.create_git_worktree()
				end,
			},
		},
		config = function()
			require("git-worktree").setup({})
			require("telescope").load_extension("git_worktree")
		end,
	},
	{ --git
		"tpope/vim-fugitive",
		cmd = { "G", "Git" },
	},
}
