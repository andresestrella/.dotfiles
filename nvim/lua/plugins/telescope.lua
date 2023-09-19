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
			path_display = { truncate = 2 },
			dynamic_preview_title = true,
			selection_strategy = "closest",
			sorting_strategy = "descending",
			file_ignore_patterns = { "node_modules", ".git" },
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
					-- ["<c-n>"] = actions.move_selection_next,
					-- ["<c-p>"] = actions.move_selection_previous,
					["<c-j>"] = actions.move_selection_next,
					["<c-k>"] = actions.move_selection_previous,
					["<c-u>"] = actions.preview_scrolling_up,
					["<c-d>"] = actions.preview_scrolling_down,
					["<c-b>"] = actions.preview_scrolling_up,
					["<c-f>"] = actions.preview_scrolling_down,
					["<c-a>"] = actions.select_all,
				},
				n = {
					["S"] = actions.select_horizontal,
					["s"] = actions.select_vertical,
					["<c-s>"] = actions.select_vertical,
					["<a-s>"] = actions.select_horizontal,
					-- ["<c-n>"] = actions.move_selection_next,
					-- ["<c-p>"] = actions.move_selection_previous,
				},
			},
		},
		pickers = {
			buffers = {
				mappings = {
					i = {
						["<c-d>"] = actions.delete_buffer + actions.move_to_top,
					},
					n = {
						["d"] = actions.delete_buffer + actions.move_to_top,
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
			{ "?", ":Telescope current_buffer_fuzzy_find<CR>" },
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
}
