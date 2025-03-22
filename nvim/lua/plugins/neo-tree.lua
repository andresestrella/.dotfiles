local opts = {
	popup_border_style = "rounded",
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_by_name = {
				"node_modules",
			},
		},
		follow_current_file = {
			enabled = true, -- This will find and focus the file in the active buffer every time
			leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
		},
	},
	window = {
		mappings = {
			["<c-s>"] = "open_vsplit",
			["<a-s>"] = "open_split",
			["<c-x>"] = "close_window",
			["<c-c>"] = "close_window",
			["Y"] = function(state)
				-- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
				-- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
				local node = state.tree:get_node()
				local filepath = node:get_id()
				local filename = node.name
				local modify = vim.fn.fnamemodify

				local results = {
					filepath,
					modify(filepath, ":."),
					modify(filepath, ":~"),
					filename,
					modify(filename, ":r"),
					modify(filename, ":e"),
				}

				-- absolute path to clipboard
				local i = vim.fn.inputlist({
					"Choose to copy to clipboard:",
					"1. Absolute path: " .. results[1],
					"2. Path relative to CWD: " .. results[2],
					"3. Path relative to HOME: " .. results[3],
					"4. Filename: " .. results[4],
					"5. Filename without extension: " .. results[5],
					"6. Extension of the filename: " .. results[6],
				})

				if i > 0 then
					local result = results[i]
					if not result then
						return print("Invalid choice: " .. i)
					end
					vim.fn.setreg('"', result)
				end
			end,
		},
		fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
			["<down>"] = "move_cursor_down",
			["<C-n>"] = "move_cursor_down",
			["<up>"] = "move_cursor_up",
			["<C-p>"] = "move_cursor_up",
		},
	},
}

return {
	{ -- file tree UI
		"nvim-neo-tree/neo-tree.nvim",
		opts = opts,
		cmd = "Neotree",
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
			'MunifTanjim/nui.nvim',
		},
		keys = {
			{ "<leader>e",  ":Neotree filesystem toggle right<cr>" },
			{ "<leader>eb", ":Neotree buffers toggle right<cr>" },
			{ "<leader>eg", ":Neotree git_status toggle right<cr>" },
		},
		lazy = false,
	},
	{
		"s1n7ax/nvim-window-picker",
		config = false, --true
		-- config = function()
		-- 	require("window-picker").setup()
		-- end,
	},
	{ -- auto close buffers https://github.com/axkirillov/hbac.nvim
		'axkirillov/hbac.nvim',
		config = true,
		event = 'VeryLazy',
	}
}
