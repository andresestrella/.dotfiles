-- local refactorOpts = {
-- 	prompt_func_return_type = {
-- 		go = false,
-- 		java = false,
-- 		cpp = false,
-- 		c = false,
-- 		h = false,
-- 		hpp = false,
-- 		cxx = false,
-- 	},
-- 	prompt_func_param_type = {
-- 		go = false,
-- 		java = false,
-- 		cpp = false,
-- 		c = false,
-- 		h = false,
-- 		hpp = false,
-- 		cxx = false,
-- 	},
-- 	printf_statements = {},
-- 	print_var_statements = {},
-- }

return {
	{ --auto detect indent
		"tpope/vim-sleuth",
		event = "BufReadPre",
	},
	{ --auto close html tags
		"windwp/nvim-ts-autotag",
		event = { "InsertEnter", "BufRead" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{ -- small plugin that enhances nvim built-in comments. need this mainly for jsx comments
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	}
}
