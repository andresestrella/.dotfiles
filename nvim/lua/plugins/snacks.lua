-- Headers = {
-- 	{ [[
-- 	  ／|_
-- 	 (o o /
-- 	  |.   ~.
-- 	  じしf_,)ノ ]], },
-- 	{ [[
-- 			  ▀████▀▄▄              ▄█
-- 		            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█
-- 		    ▄        █          ▀▀▀▀▄  ▄▀
-- 		   ▄▀ ▀▄      ▀▄              ▀▄▀
-- 		  ▄▀    █     █▀   ▄█▀▄      ▄█
-- 		  ▀▄     ▀▄  █     ▀██▀     ██▄█
-- 		   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █
-- 		    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀
-- 		   █   █  █      ▄▄           ▄▀
-- 						  ]], },
-- 	{ [[
-- 	██▒   █▓  ██████     ▄████▄   ▒█████  ▓█████▄ ▓█████
-- 	▓██░   █▒▒██    ▒   ▒██▀  ▀█  ▒██▒  ██▒▒██▀ ██▌▓█   ▀
-- 	 ▓██  █▒░░ ▓██▄▄▄   ▒▓█▄      ▒██░  ██▒░██   █▌▒███
-- 	  ▒██ █░░  ▒   ██▒   ▒▓▓▄ ▄██▒▒██   ██░░▓█▄   ▌▒▓█  ▄
-- 	   ▒▀█░  ▒██████▒▒   ▒ ▓███▀ ░░ ████▓▒░░▒████▓ ░▒████▒
-- 	   ░ ▐░  ▒ ▒▓▒ ▒ ░   ░ ░▒ ▒  ░░ ▒░▒░▒░  ▒▒▓  ▒ ░░ ▒░ ░
-- 	   ░ ░░  ░ ░▒  ░ ░     ░  ▒     ░ ▒ ▒░  ░ ▒  ▒  ░ ░  ░
-- 	     ░░  ░  ░  ░     ░        ░ ░ ░ ▒   ░ ░  ░    ░
-- 	      ░        ░     ░ ░          ░ ░     ░       ░  ░
-- 	     ░               ░                  ░            ]],
-- 	},
-- 	{ [[
-- 	    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- 	    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- 	    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- 	    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- 	    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- 	    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]], },
-- 	{ [[
-- 	                                   __
-- 	      ___     ___    ___   __  __ /\_\    ___ ___
-- 	     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\
-- 	    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \
-- 	    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
-- 	     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]], },
-- 	{ [[
-- 	██╗   ██╗███████╗    ██████╗ ██████╗ ██████╗ ███████╗
-- 	██║   ██║██╔════╝   ██╔════╝██╔═══██╗██╔══██╗██╔════╝
-- 	██║   ██║███████╗   ██║     ██║   ██║██║  ██║█████╗
-- 	╚██╗ ██╔╝╚════██║   ██║     ██║   ██║██║  ██║██╔══╝
-- 	 ╚████╔╝ ███████║   ╚██████╗╚██████╔╝██████╔╝███████╗
-- 	  ╚═══╝  ╚══════╝    ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝]], },
-- }
-- math.randomseed(os.time())

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			bigfile = { enabled = true },
			quickfile = { enabled = true },
			indent = { enabled = true },
			words = { enabled = true }, -- jump around references of a var in the same file. very useful
			input = { enabled = true },
			bufdelete = { enabled = true }, -- ask to save before closing unsaved buffer <leader>bd
			gitbrowse = { enabled = true }, -- open hub branch on browser
			image = { enabled = true },
			scope = { enabled = true },
			lazygit = { enabled = true }, -- <leader>gg aa
			terminal = {
				win = {
					position = "float",
				},
			},
			picker = {
				sources = {
					files = { hidden = true, ignored = false },
					grep = { hidden = true, ignored = false },
					explorer = { hidden = true, ignored = true },
				},
				-- hidden = true,
				-- ignored = false,
				formatters = {
					file = {
						truncate = 80, -- truncate the file path to (roughly) this length
					},
				},
			},

			explorer = {}, -- requires 'fd' to be installed

			rename = { enabled = false }, --this renames the current open file and updates imports with LSP
			-- rename didn't work as expected, I opened a bug issue on snacks.nvim repo

			dashboard = { -- restoring sessions don't work unless using lazyvim
				enabled = false,
				-- preset = {
				-- 	header = Headers[math.random(#Headers)],
				-- },
			},
			notifier = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
		},
		keys = {
			{ "<A-t>",           "<cmd>lua Snacks.terminal.toggle()<cr>",                                     desc = "Toggle terminal",                 mode = { "n", "t" } },
			-- { "<A-t>", "1<cmd>lua Snacks.terminal.toggle()<cr>", desc = "Toggle terminal 1", mode = { "n", "t" } },

			-- Snacks Picker
			{ "<leader><space>", function() require("snacks").picker.smart() end,                             desc = "Smart Find Files" },
			{ "<leader>pa",      function() require("snacks").picker() end,                                   desc = "Find all pickers" },
			{ "<leader>pf",      function() require("snacks").picker.files() end,                             desc = "Find Files (Snacks Picker)" },
			{ "<leader>pb",      function() require("snacks").picker.buffers() end,                           desc = "Find Files (Snacks Picker)" },
			{ "<leader>ps",      function() require("snacks").picker.grep() end,                              desc = "Grep word" },
			{ "<leader>pws",     function() require("snacks").picker.grep_word() end,                         desc = "Search Visual selection or Word", mode = { "n", "x" } },
			{ "<leader>pk",      function() require("snacks").picker.keymaps({ layout = "ivy" }) end,         desc = "Search Keymaps (Snacks Picker)" },
			{ "<leader>ph",      function() require("snacks").picker.help() end,                              desc = "Help Pages" },
			{ "<leader>pg",      function() require("snacks").picker.git_branches({ layout = "select" }) end, desc = "Pick and Switch Git Branches" },
			{ "<leader>pl",      function() require("snacks").picker.resume() end,                            desc = "Resume last picker" },

			-- LSP
			{ "gd",              function() require("snacks").picker.lsp_definitions() end,                   desc = "Goto Definition" },
			{ "gt",              function() vim.cmd("tab split | lua vim.lsp.buf.definition()") end,          desc = "Goto Definition in new tab" },
			-- function declaration is the function prototype
			{ "gD",              function() vim.lsp.buf.declaration() end,                                    desc = "Goto Declaration" },
			{ "gr",              function() require("snacks").picker.lsp_references() end,                    nowait = true,                            desc = "References" },
			{ "gI",              function() require("snacks").picker.lsp_implementations() end,               desc = "Goto Implementation" },
			{ "gy",              function() require("snacks").picker.lsp_type_definitions() end,              desc = "Goto T[y]pe Definition" },
			{ "<leader>ss",      function() require("snacks").picker.lsp_symbols() end,                       desc = "LSP Symbols" },
			{ "<leader>sS",      function() require("snacks").picker.lsp_workspace_symbols() end,             desc = "LSP Workspace Symbols" },
			{ "<leader>rn",      function() vim.lsp.buf.rename() end,                                         desc = "[R]e[n]ame" },
			{ "<leader>ca",      function() vim.lsp.buf.code_action() end,                                    desc = "[C]ode [A]ction",                 mode = { "n", "x" } },

			-- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
			-- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
			-- map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
			-- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
			-- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
			-- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')


			{ "<leader>gg",      function() require("snacks").lazygit() end,                                  desc = "Lazygit" },
			{ "<leader>gB",      function() require("snacks").gitbrowse() end,                                desc = "Git Browse",                      mode = { "n", "v" } },

			{ "]]",              function() require("snacks").words.jump(vim.v.count1) end,                   desc = "Next Reference",                  mode = { "n", "t" } },
			{ "[[",              function() require("snacks").words.jump(-vim.v.count1) end,                  desc = "Prev Reference",                  mode = { "n", "t" } },
			--
			-- { "<leader>rf",  function() require("snacks").rename.rename_file() end,                       desc = "Fast Rename Current File" },
			{ "<leader>e",       function() require("snacks").explorer() end,                                 desc = "Open File Explorer" },
			-- { "<leader>e",       function() require("snacks").picker.explorer() end,                          desc = "Smart Find Files" },
		},
	},
	-- NOTE: todo comments w/ snacks
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		optional = true,
		keys = {
			{ "<leader>pt", function() require("snacks").picker.todo_comments() end,                                          desc = "Todo" },
			{ "<leader>pT", function() require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
		},
	}
}
