local marksOpts = {
	-- whether to map keybinds or not. default true
	default_mappings = true,
	-- which builtin marks to show. default {}
	builtin_marks = { ".", "<", ">", "^" },
	-- whether movements cycle back to the beginning/end of buffer. default true
	cyclic = true,
	-- whether the shada file is updated after modifying uppercase marks. default false
	force_write_shada = false,
	-- how often (in ms) to redraw signs/recompute mark positions.
	-- higher values will have better performance but may cause visual lag,
	-- while lower values may cause performance penalties. default 150.
	refresh_interval = 250,
	-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
	-- marks, and bookmarks.
	-- can be either a table with all/none of the keys, or a single number, in which case
	-- the priority applies to all marks.
	-- default 10.
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	-- disables mark tracking for specific filetypes. default {}
	excluded_filetypes = {},
	-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
	-- sign/virttext. Bookmarks can be used to group together positions and quickly move
	-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
	-- default virt_text is "".
	bookmark_0 = {
		sign = "⚑",
		virt_text = "hello world",
		-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
		-- defaults to false.
		annotate = false,
	},
	mappings = {},
}
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
					line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
						return {
							line.sep("", theme.win, theme.fill),
							win.is_current() and "" or "",
							win.buf_name(),
							line.sep("", theme.win, theme.fill),
							hl = theme.win,
							margin = " ",
						}
					end),
					{
						line.sep("", theme.tail, theme.fill),
						{ "  ", hl = theme.tail },
					},
					hl = theme.fill,
				}
			end)
		end,
	},
	{ --smooth scrolling
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				easing_function = "quadratic", -- Default easing function
				-- Use the "sine" easing function
			})
			-- Syntax: t[keys] = {function, {function arguments}}
			local t = {}
			t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "50", [['sine']] } }
			t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "50", [['sine']] } }
			-- Use the "circular" easing function
			t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "200", [['quadratic']] } }
			t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "200", [['quadratic']] } }
			-- Pass "nil" to disable the easing animation (constant scrolling speed)
			t["<C-y>"] = { "scroll", { "-0.10", "false", "100", nil } }
			t["<C-e>"] = { "scroll", { "0.10", "false", "100", nil } }
			-- When no easing function is provided the default easing function (in this case "quadratic") will be used
			t["zt"] = { "zt", { "300" } }
			t["zz"] = { "zz", { "300" } }
			t["zb"] = { "zb", { "300" } }
			require("neoscroll.config").set_mappings(t)
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
	{ --marks visualizer
		"chentoast/marks.nvim",
		opts = marksOpts,
		-- config = function()
		-- 	require("marks").setup({})
		-- end,
	},
	{ -- reet screen
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "Shatur/neovim-session-manager", "stevearc/dressing.nvim" },
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
					[[														 ]],
				},
			}

			dashboard.section.header.val = Headers[math.random(#Headers)]

			-- local Quotes = {
			-- 	{},
			-- }
			-- local footer = {
			-- 	type = "text",
			-- 	-- Change 'rdn' to any program that gives you a random quote.
			-- 	-- https://github.com/BeyondMagic/scripts/blob/master/quotes/rdn
			-- 	-- Which returns one to three lines, being each divided by a line break.
			-- 	-- Or just an array: { "I see you:", "Above you." }
			-- 	val = split(capture("quote")),
			-- 	opts = {
			-- 		position = "center",
			-- 		hl = "Number",
			-- 	},
			-- }
			local total_plugins = require("lazy").stats().count
			local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
			local version = vim.version()
			local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
			local footer = datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
			--
			dashboard.section.footer.val = footer
			-- dashboard.section.footer.val = split(capture("quote"))
			-- dashboard.section.footer.val = Quotes[math.random(#Quotes)]
			dashboard.section.footer.opts.hl = "Constant"
			alpha.setup(dashboard.config)
			vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
		end,
	},
}
