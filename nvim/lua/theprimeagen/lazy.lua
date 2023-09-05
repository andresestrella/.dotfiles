local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	--file finding
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.2",
		-- or                              , branch = '0.1.1',
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
	},

	--neoclip
	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup({
				-- uncomment if I want to use persistent history
				-- enable_persistant_history = true,
			})
		end,
	},

	{
		"stevearc/dressing.nvim", -- replaces default vim UI elements with telescope
		event = "VeryLazy",
		opts = {},
	},

	{ --theme
		"catppuccin/nvim",
		name = "catppuccin",
	},

	{ -- theme
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "medium" -- hard, medium, soft, none
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},

	-- LSP troubleshooting
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				-- icons = false,
				action_keys = {
					close = { "q", "<c-x>", "<c-c>" },
					open_vsplit = "<c-s>",
					open_split = "<a-s>",
				},
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},

	--parse tree, syntax highlighting, folds, and more
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = false,
	},

	--lsp all in one
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{
				"neovim/nvim-lspconfig",
				after = "LuaSnip",
			},
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp",                 event = "InsertEnter", after = "nvim-lspconfig" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip",         after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp",             after = "nvim-cmp" },
			{ "hrsh7th/cmp-buffer",               after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{
				"L3MON4D3/LuaSnip",
				event = "CursorMoved",
			},
			{ "rafamadriz/friendly-snippets", after = "nvim-cmp" },
		},
	},
	"onsails/lspkind-nvim",         -- lsp icons"
	"jose-elias-alvarez/null-ls.nvim", --lsp for non lsp
	"jay-babu/mason-null-ls.nvim",  -- auto install on Mason and auto configure for null-ls
	--use("github/copilot.vim")        --AI completion
	"zbirenbaum/copilot.lua",

	--commenting
	{
		"numToStr/Comment.nvim",
		keys = { { "gcc" }, { "gbc" }, { "gc", mode = "v" }, { "gb", mode = "v" } },
		config = true,
	},

	-- file tree UI
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
	},

	--sessions
	{
		"Shatur/neovim-session-manager",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

	-- greet screen
	{
		"goolord/alpha-nvim",
		config = function()
			local is_status_ok, alpha = pcall(require, "alpha")

			if not is_status_ok then
				print("alpha plugin not found")
				return
			end

			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.buttons.val = {
				dashboard.button("SPC s l", "󰘁 Open last session", "<cmd>SessionManager load_last_session<CR>"),
				dashboard.button("SPC s s", "󱃐 Open sessions", "<cmd>SessionManager load_session<CR>"),
				dashboard.button("a", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("SPC f f", "󰈞 Find file", ":Telescope find_files hidden=true no_ignore=true<CR>"),
				dashboard.button("SPC f h", "󰷊 Recently opened files", "<cmd>Telescope oldfiles<CR>"),
				-- dashboard.button("SPC f r", "  Frecency/MRU"),
				dashboard.button("SPC f g", "  Find word", "<cmd>Telescope live_grep<cr>"),
				-- dashboard.button("SPC f m", "  Jump to bookmarks"),
				dashboard.button("q", "󰩈  Quit NVIM", ":qa<CR>"),
			}

			alpha.setup(dashboard.config)
		end,
	},

	--debugging
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			--dap setup
			"mfussenegger/nvim-dap-python",
			"jay-babu/mason-nvim-dap.nvim",
			"mxsdev/nvim-dap-vscode-js",
		},
		keys = { "<leader>b", "F9", "F5" },
		event = "VeryLazy",
		config = function()
			local ok_cmp, cmp = pcall(require, "cmp")
			if ok_cmp then
				cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
					sources = cmp.config.sources({
						{ name = "dap" },
					}, {
						{ name = "buffer" },
					}),
				})
			end
		end,
	},

	{-- vscode's js dbug adapter
		"microsoft/vscode-js-debug",
		lazy = true,
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && move dist out"
		--linux
		-- build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
	},
	--testing
	"vim-test/vim-test", --testing'
	{
		"nvim-neotest/neotest",
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-jest",
		},
		lazy = true,
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

	"lewis6991/gitsigns.nvim", --git signs
	"akinsho/toggleterm.nvim", --terminal
	"karb94/neoscroll.nvim", --smooth scrolling
	"chentoast/marks.nvim", --marks visualizer
	"tpope/vim-sleuth",     --auto detect indent
	"tpope/vim-surround",   --surrounding text
	"jiangmiao/auto-pairs", --auto pairs
	{                       --auto close html tags
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	"theprimeagen/harpoon",                             --quick file access
	"theprimeagen/refactoring.nvim",
	"mbbill/undotree",                                  --undo history tree
	"tpope/vim-fugitive",                               --git
	"theprimeagen/git-worktree.nvim",
	"nvim-lualine/lualine.nvim",                        --status line
	"nanozuki/tabby.nvim",                              --prettier tabs
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "nvim-tree/nvim-web-devicons",        lazy = true }, -- devicons, not strictly required, but recommended
}

require("lazy").setup(plugins, opts)
