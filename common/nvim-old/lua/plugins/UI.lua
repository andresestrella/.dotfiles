local iconsOpts = {
	-- your personnal icons can go here (to override)
	-- you can specify color or cterm_color instead of specifying both of them
	-- DevIcon will be appended to `name`
	override = {
		zsh = {
			icon = "",
			color = "#428850",
			cterm_color = "65",
			name = "Zsh",
		},
	},
	-- globally enable different highlight colors per icon (default to true)
	-- if set to false all icons will have the default icon's color
	color_icons = true,
	-- globally enable default icons (default to false)
	-- will get overriden by `get_icons` option
	default = true,
	-- globally enable "strict" selection of icons - icon will be looked up in
	-- different tables, first by filename, and if not found by extension; this
	-- prevents cases when file doesn't have any extension but still gets some icon
	-- because its name happened to match some extension (default to false)
	strict = true,
	-- same as `override` but specifically for overrides by filename
	-- takes effect when `strict` is true
	override_by_filename = {
		[".gitignore"] = {
			icon = "",
			color = "#f1502f",
			name = "Gitignore",
		},
	},
	-- same as `override` but specifically for overrides by extension
	-- takes effect when `strict` is true
	override_by_extension = {
		["log"] = {
			icon = "",
			color = "#81e043",
			name = "Log",
		},
	},
}
return {
	{ --prettier tabs
		"nanozuki/tabby.nvim",
		event = "TabNew",
		opts = {
			theme = {
				fill = "TabLineFill",
				head = "TabLine",
				current_tab = "TabLineSel",
				tab = "TabLine",
				win = "TabLine",
				tail = "TabLineSel",
			},
		},
		config = function(_, opts)
			local theme = opts.theme
			require("tabby.tabline").set(function(line)
				return {
					{
						{ "  ", hl = theme.head },
						line.sep("", theme.head, theme.fill),
					},
					line.tabs().foreach(function(tab)
						local hl = tab.is_current() and theme.current_tab or theme.tab
						return {
							line.sep("", hl, theme.fill),
							tab.is_current() and "" or "",
							tab.number(),
							tab.name(),
							tab.close_btn(""),
							line.sep("", hl, theme.fill),
							hl = hl,
							margin = " ",
						}
					end),
					line.spacer(),
					-- line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
					-- 	return {
					-- 		line.sep("", theme.win, theme.fill),
					-- 		win.is_current() and "" or "",
					-- 		win.buf_name(),
					-- 		line.sep("", theme.win, theme.fill),
					-- 		hl = theme.win,
					-- 		margin = " ",
					-- 	}
					-- end),
					-- {
					-- 	line.sep("", theme.tail, theme.fill),
					-- 	{ "  ", hl = theme.tail },
					-- },
					hl = theme.fill,
				}
			end)
		end,
	},
	{ -- devicons
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		opts = iconsOpts,
		config = function()
			require("nvim-web-devicons").setup({
				-- default = true,
			})
		end,
	},
	{ -- greet screen
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "Shatur/neovim-session-manager", "nvim-lua/plenary.nvim" },
		config = function()
			local is_status_ok, alpha = pcall(require, "alpha")

			if not is_status_ok then
				print("alpha plugin not found")
				return
			end

			local dashboard = require("alpha.themes.dashboard")
			--for random header
			math.randomseed(os.time())

			dashboard.section.buttons.val = {
				dashboard.button("l", "󰘁 Open last session",
					"<cmd>SessionManager load_last_session<CR>"),
				dashboard.button("s", "󱃐 Open sessions", "<cmd>SessionManager load_session<CR>"),
				dashboard.button("a", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "󰈞 Find file",
					":lua Snacks.picker.files()<CR>"),
				dashboard.button("r", "󰷊 Recently opened files", ":lua Snacks.picker.recent()<CR>"),
				-- dashboard.button("SPC f r", "  Frecency/MRU"),
				dashboard.button("w", "  Find word", ":lua Snacks.picker.grep()<CR>"),
				-- dashboard.button("SPC f m", "  Jump to bookmarks"),
				dashboard.button("q", "󰩈  Quit NVIM", ":qa<CR>"),
			}
			Headers = {

				{
					[[                                                                     ]],
					[[       ███████████           █████      ██                     ]],
					[[      ███████████             █████                             ]],
					[[      ████████████████ ███████████ ███   ███████     ]],
					[[     ████████████████ ████████████ █████ ██████████████   ]],
					[[    █████████████████████████████ █████ █████ ████ █████   ]],
					[[  ██████████████████████████████████ █████ █████ ████ █████  ]],
					[[ ██████  ███ █████████████████ ████ █████ █████ ████ ██████ ]],
					[[ ██████   ██  ███████████████   ██ █████████████████ ]],
					[[ ██████   ██  ███████████████   ██ █████████████████ ]],
				},
				{
					[[  ／|_       ]],
					[[ (o o /      ]],
					[[  |.   ~.    ]],
					[[  じしf_,)ノ ]],
				},

				{
					"          ▀████▀▄▄              ▄█ ",
					"            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ",
					"    ▄        █          ▀▀▀▀▄  ▄▀  ",
					"   ▄▀ ▀▄      ▀▄              ▀▄▀  ",
					"  ▄▀    █     █▀   ▄█▀▄      ▄█    ",
					"  ▀▄     ▀▄  █     ▀██▀     ██▄█   ",
					"   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ",
					"    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ",
					"   █   █  █      ▄▄           ▄▀   ",
				},

				{
					"                                                     ",
					"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
					"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
					"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
					"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
					"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
					"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
					"                                                     ",
				},
				{
					[[ ██▒   █▓  ██████     ▄████▄   ▒█████  ▓█████▄ ▓█████ ]],
					[[▓██░   █▒▒██    ▒   ▒██▀  ▀█  ▒██▒  ██▒▒██▀ ██▌▓█   ▀ ]],
					[[ ▓██  █▒░░ ▓██▄▄▄   ▒▓█▄      ▒██░  ██▒░██   █▌▒███   ]],
					[[  ▒██ █░░  ▒   ██▒   ▒▓▓▄ ▄██▒▒██   ██░░▓█▄   ▌▒▓█  ▄ ]],
					[[   ▒▀█░  ▒██████▒▒   ▒ ▓███▀ ░░ ████▓▒░░▒████▓ ░▒████▒]],
					[[   ░ ▐░  ▒ ▒▓▒ ▒ ░   ░ ░▒ ▒  ░░ ▒░▒░▒░  ▒▒▓  ▒ ░░ ▒░ ░]],
					[[   ░ ░░  ░ ░▒  ░ ░     ░  ▒     ░ ▒ ▒░  ░ ▒  ▒  ░ ░  ░]],
					[[     ░░  ░  ░  ░     ░        ░ ░ ░ ▒   ░ ░  ░    ░   ]],
					[[      ░        ░     ░ ░          ░ ░     ░       ░  ░]],
					[[     ░               ░                  ░            ]],
				},
				{
					[[                               __                ]],
					[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
					[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
					[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
					[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
					[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
				},
				{
					[[ ██╗   ██╗███████╗    ██████╗ ██████╗ ██████╗ ███████╗ ]],
					[[ ██║   ██║██╔════╝   ██╔════╝██╔═══██╗██╔══██╗██╔════╝ ]],
					[[ ██║   ██║███████╗   ██║     ██║   ██║██║  ██║█████╗   ]],
					[[ ╚██╗ ██╔╝╚════██║   ██║     ██║   ██║██║  ██║██╔══╝   ]],
					[[  ╚████╔╝ ███████║   ╚██████╗╚██████╔╝██████╔╝███████╗ ]],
					[[   ╚═══╝  ╚══════╝    ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝ ]],
				},
			}

			dashboard.section.header.val = Headers[math.random(#Headers)]

			local total_plugins = require("lazy").stats().count
			local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
			local version = vim.version()
			local nvim_version_info = "   v" ..
			    version.major .. "." .. version.minor .. "." .. version.patch
			local footer = datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
			dashboard.section.footer.val = footer
			dashboard.section.footer.opts.hl = "Constant"
			alpha.setup(dashboard.config)
			vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])

			-- Hook into `SessionLoadPost` to override the session's working directory
			vim.api.nvim_create_autocmd('User', {
				pattern = 'SessionLoadPost',
				callback = function()
					local Path = require('plenary.path')
					local root_patterns = { '.git', 'package.json', 'tsconfig.json' }
					local cwd = vim.loop.cwd()

					-- Traverse upward to find a root marker
					for _, pattern in ipairs(root_patterns) do
						local file_path = Path:new(cwd):find_upwards(pattern)
						if file_path then
							local dir = Path:new(file_path):parent()
							vim.cmd('cd ' .. dir.filename)
							print('Project root set to:', dir.filename)
							return
						end
					end

					-- If no marker is found, fall back to the current working directory
					vim.cmd('cd ' .. cwd)
					print('No root marker found. Using current directory:', cwd)
				end,
			})
		end,
	},
}
