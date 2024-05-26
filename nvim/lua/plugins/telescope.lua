--file finding
local config = function()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	require("telescope").load_extension("neoclip")
	require("telescope").load_extension("macroscope")
	require("telescope").setup({
		defaults = {
			prompt_prefix = "> ",
			selection_caret = " ",
			-- path_display = { truncate = 2 },
			path_display = { "smart" },
			dynamic_preview_title = true,
			selection_strategy = "closest",
			sorting_strategy = "descending",
			file_ignore_patterns = {
				".git/",
				"target/",
				"docs/",
				"vendor/*",
				"%.lock",
				"__pycache__/*",
				"%.sqlite3",
				"%.ipynb",
				"node_modules/*",
				-- "%.jpg",
				-- "%.jpeg",
				-- "%.png",
				"%.svg",
				"%.otf",
				"%.ttf",
				"%.webp",
				".dart_tool/",
				".github/",
				".gradle/",
				".idea/",
				".settings/",
				".vscode/",
				"__pycache__/",
				"build/",
				-- "env/",
				"gradle/",
				"node_modules/",
				"%.pdb",
				"%.dll",
				"%.class",
				"%.exe",
				"%.cache",
				"%.ico",
				"%.pdf",
				"%.dylib",
				"%.jar",
				"%.docx",
				"%.met",
				"smalljre_*/*",
				".vale/",
				"%.burp",
				"%.mp4",
				"%.mkv",
				"%.rar",
				"%.zip",
				"%.7z",
				"%.tar",
				"%.bz2",
				"%.epub",
				"%.flac",
				"%.tar.gz",
			},
			winblend = 2,
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			use_less = true,
			set_env = { ["COLORTERM"] = "truecolor" },
			-- file_ignore_patterns = { "node_modules" },
			mappings = {
				i = {
					["<c-s>"] = actions.select_vertical,
					["<a-s>"] = actions.select_horizontal,

					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,

					["<c-j>"] = actions.move_selection_next,
					["<c-k>"] = actions.move_selection_previous,

					["<c-b>"] = actions.preview_scrolling_up,
					["<c-f>"] = actions.preview_scrolling_down,

					["<c-d>"] = require("telescope.actions").delete_buffer,
					["<c-a>"] = actions.select_all,
				},
				n = {
					["<esc>"] = actions.close,

					["S"] = actions.select_horizontal,
					["s"] = actions.select_vertical,
					["<c-s>"] = actions.select_vertical,
					["<a-s>"] = actions.select_horizontal,

					["<C-b>"] = actions.results_scrolling_up,
					["<C-f>"] = actions.results_scrolling_down,

					["dd"] = require("telescope.actions").delete_buffer,
					["<c-d>"] = require("telescope.actions").delete_buffer,

					["<c-b>"] = actions.preview_scrolling_up,
					["<c-f>"] = actions.preview_scrolling_down,

					["gg"] = actions.move_to_top,
					["G"] = actions.move_to_bottom,

				},
			},
		},
		pickers = {
			-- marks = {
			-- 	ignore_current_buffer = true,
			-- 	sort_mru = true,
			-- 	sort_lastused = true,
			-- 	mappings = {
			-- 		i = {
			-- 			["<c-x>"] = actions.delete_mark + actions.move_to_top,
			-- 		},
			-- 		n = {
			-- 			["x"] = actions.delete_mark + actions.move_to_top,
			-- 		},
			-- 	},
			-- },
			buffers = {
				ignore_current_buffer = true,
				sort_mru = true,
				sort_lastused = true,
				-- previewer = false,
				mappings = {
					i = {
						["<c-x>"] = actions.delete_buffer + actions.move_to_top,
					},
					n = {
						["x"] = actions.delete_buffer + actions.move_to_top,
					},
				},
			},
		},
		extensions = {
			-- ["ui-select"] = {
			-- 	require("telescope.themes").get_dropdown({
			-- 		winblend = 10,
			-- 	}),
			-- },
			workspaces = {
				keep_insert = false,
			},
			-- lazy = {
			-- 	theme = "ivy",
			-- 	show_icon = true,
			-- 	mappings = {
			-- 		open_in_browser = "<C-o>",
			-- 		open_in_file_browser = "<M-b>",
			-- 		open_in_find_files = "<C-f>",
			-- 		open_in_live_grep = "<C-g>",
			-- 		open_plugins_picker = "<C-b>",
			-- 		open_lazy_root_find_files = "<C-r>f",
			-- 		open_lazy_root_live_grep = "<C-r>g",
			-- 	},
			-- },
		},
	})
	local extensions = {
		"neoclip",
		"macroscope",
		"harpoon",
		-- "ui-select",
		-- "lazy",
	}
	for e in ipairs(extensions) do
		telescope.load_extension(extensions[e])
	end
end

return {
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.2",
		-- or, branch = '0.1.1',
		config = config,
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		keys = {
			{ "?",          ":Telescope current_buffer_fuzzy_find<CR>" },
			{ "<leader>ft", ":Telescope <CR>" },
			{ "<leader>ff", ":Telescope find_files<CR>" },
			{ "<leader>fg", ":Telescope git_files<CR>" },
			{
				"<leader>fs",
				function()
					local builtin = require("telescope.builtin")
					builtin.grep_string({ search = vim.fn.input("Grep > ") })
				end,
			},
			{ "<leader>fd", ":Telescope live_grep <CR>" },
			{ "<leader>fh", ":Telescope help_tags <CR>" },
			{ "<leader>fp", ":Telescope neoclip <CR>" },
			{ "<leader>fq", ":Telescope macroscope <CR>" },
			{ "<leader>fb", ":Telescope buffers <CR>" },
		},
	},
	{ --neoclip
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup({
				-- uncomment if I want to use persistent history
				-- enable_persistant_history = true,
			})
		end,
	},
	{ -- auto close buffers https://github.com/axkirillov/hbac.nvim
	  'axkirillov/hbac.nvim',
	  config = true,
	  event = 'VeryLazy',
	}
}
