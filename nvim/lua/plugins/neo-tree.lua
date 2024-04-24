--open neo tree
-- require("neo-tree").setup({
-- })
local opts = {
	sources = { "filesystem" },
	add_blank_line_at_top = false,
	close_if_last_window = true,
	enable_git_status = true,
	enable_diagnostics = true,
	hide_root_node = false,
	retain_hidden_root_indent = true,
	popup_border_style = "rounded",
	filesystem = {
		filtered_items = {
			visible = false,
			hide_dotfiles = false,
			hide_gitignored = true,
			hide_by_name = {
				"node_modules",
			},
		},
		follow_current_file = {
			enabled = false, -- This will find and focus the file in the active buffer every time
			--               -- the current file is changed while the tree is open.
			leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
		},
	},
	window = {
		mapping_options = {
			noremap = true,
			nowait = true,
		},
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
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
		end,
		cmd = "Neotree",
		branch = "v3.x",
		-- branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
			"nvim-tree/nvim-web-devicons",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
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
}
