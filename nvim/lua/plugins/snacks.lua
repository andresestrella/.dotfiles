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
			-- refer to the configuration section below
			bigfile = { enabled = true },
			quickfile = { enabled = true },
			indent = { enabled = true },
			words = { enabled = true },
			input = { enabled = true },
			terminal = {
				win = {
					position = "float",
				},
			},

			dashboard = {
				enabled = false,
				-- preset = {
				-- 	header = Headers[math.random(#Headers)],
				-- },
			},

			rename = { enabled = false }, --tested this one didn't work, couldn't replace nvim-lsp-file-operations
			picker = { enabled = false },
			explorer = { enabled = false },
			notifier = { enabled = false },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
		},
		keys = {
			{ "<A-t>", "<cmd>lua Snacks.terminal.toggle()<cr>", desc = "Toggle terminal", mode = { "n", "t" } },
			-- { "<A-t>", "1<cmd>lua Snacks.terminal.toggle()<cr>", desc = "Toggle terminal 1", mode = { "n", "t" } },
		},
	}
}
