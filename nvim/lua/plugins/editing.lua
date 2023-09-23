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
    {--auto detect indent
        "tpope/vim-sleuth",
        event = "BufReadPre",
    },
    {--surrounding text
        "tpope/vim-surround",
        event = "BufReadPre",
    },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ --auto close html tags
		"windwp/nvim-ts-autotag",
		event = { "InsertEnter", "BufRead"},
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"theprimeagen/refactoring.nvim",
		event = "BufReadPre",
		opts = refactorOpts,
		config = function()
			require("refactoring").setup()
			local map = vim.api.nvim_set_keymap
			local map_opts = { noremap = true, silent = true, expr = false }
			map("v", "<leader>rr", ":lua require('refactoring').select_refactor()<CR>", map_opts)
			map("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], map_opts)
			map("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], map_opts)
		end,
	},
	{
		"Wansmer/treesj",
		keys = {
			"<leader>m",
			"<CMD>TSJToggle<CR>",
			desc = "Toggle Treesitter Join",
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({ --[[ your config ]]
			})
		end,
	},
	{ --commenting
		"numToStr/Comment.nvim",
		keys = { { "gcc" }, { "gbc" }, { "gc", mode = "v" }, { "gb", mode = "v" } },
		opts = commentOpts,
	},
}
