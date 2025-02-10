local commentOpts = {
	padding = true,
	sticky = true,
	ignore = "^$",
	toggler = {
		line = "gcc",
		block = "gbc",
	},
	opleader = {
		line = "gc",
		block = "gb",
	},
	extra = {
		above = "gcO",
		below = "gco",
		eol = "gcA",
	},
	mappings = {
		basic = true,
		extra = true,
		extended = false,
	},
	-- prehook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	prehook = nil,
	post_hook = nil,
}

local refactorOpts = {
	prompt_func_return_type = {
		go = false,
		java = false,
		cpp = false,
		c = false,
		h = false,
		hpp = false,
		cxx = false,
	},
	prompt_func_param_type = {
		go = false,
		java = false,
		cpp = false,
		c = false,
		h = false,
		hpp = false,
		cxx = false,
	},
	printf_statements = {},
	print_var_statements = {},
}

return {
	{ --auto detect indent
		"tpope/vim-sleuth",
		event = "BufReadPre",
	},
	{ --surrounding text
		"tpope/vim-surround",
		event = "BufReadPost",
	},
	{ --auto close html tags
		"windwp/nvim-ts-autotag",
		event = { "InsertEnter", "BufRead" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"jiangmiao/auto-pairs", --auto pairs
		-- "windwp/nvim-autopairs",
		-- opts = opts,
		event = "InsertEnter",
		config = function()
			vim.cmd([[ let g:AutoPairsShortcutToggle = '' ]])
		end,
		-- config = function()
		-- 	require("nvim-autopairs").setup({
		-- 		vim.cmd([[ let g:AutoPairsShortcutToggle = '' ]]),
		-- 	})
		-- end,
	},
	{
		"theprimeagen/refactoring.nvim",
		event = "BufReadPost",
		opts = refactorOpts,
		config = function()
			require("refactoring").setup()
			local map = vim.api.nvim_set_keymap
			vim.keymap.set("x", "<leader>re", ":Refactor extract ")
			vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

			vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")

			vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

			vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")

			vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
			vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
		end,
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({--[[ your config ]]
			})
			vim.keymap.set("n", "<leader>m", ":lua require('treesj').toggle()<cr>")
		end,
	},
	{ --commenting
		"numToStr/Comment.nvim",
		keys = { { "gcc" }, { "gbc" }, { "gc", mode = "v" }, { "gb", mode = "v" } },
		opts = commentOpts,
	},
}
