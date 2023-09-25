return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
		vim.keymap.set("n", "<leader>", "<cmd>WhichKey <leader><CR>", { silent = true })
		vim.keymap.set("v", "<leader>", "<cmd>WhichKey <leader><CR>", { silent = true })
		local wk = require("which-key")
		local opts = {
			mode = "n",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		}
		local vopts = {
			mode = "v", -- VISUAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		}
		local mappings = {
			-- ["<leader>"] = { "<cmd>WhichKey <leader><CR>", "WhichKey" },
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			["u"] = { "UndoTreeToggle<CR> ", "Undo tree" },
			["e"] = { ":Neotree toggle right<CR>", "File Tree toggle" },
			d = {
				name = "Debug",
				t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
				b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
				c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
				C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
				d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
				g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
				i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
				o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
				u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
				p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
				r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
				s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
				q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
				U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
			},
			j = {
				name = "Java only LSP",
				ji = { "<cmd>lua require'jdtls'.organize_imports()<CR>", "Organize Imports" },
				jt = { "<Cmd>lua require'jdtls'.test_class()<CR>", "Test class" },
				j = { "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", "test neares method" },
				je = { "<Cmd>lua require('jdtls').extract_variable()<CR>", "extract variable" },
				jea = { "<Cmd>lua require('jdtls').extract_variable_all()<CR>", "extract and replace all" },
				jc = { "<Cmd>lua require('jdtls').extract_constant()<CR>", "extract constant" },
				jtg = { "<Cmd>lua require'jdtls.tests'.generate()<CR>", "generate test class" },
				jgt = { "<Cmd>lua require'jdtls.tests'.goto_subjects()<CR>", "goto test subject" },
			},
			g = {
				name = "Git",
				-- g = { "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", "Lazygit" },
				j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
				k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
				l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
				p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
				r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
				R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
				s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
				u = {
					"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
					"Undo Stage Hunk",
				},
				o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
				b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
				C = {
					"<cmd>Telescope git_bcommits<cr>",
					"Checkout commit(for current file)",
				},
				d = {
					"<cmd>Gitsigns diffthis HEAD<cr>",
					"Git Diff",
				},
			},
			f = {
				name = "Find",
				t = { "<cmd>Telescope <cr>", "Open Telescope" },
				f = { "<cmd>Telescope find_files<cr>", "Find File" },
				g = { "<cmd>Telescope git_files<cr>", "Find Git Files" },
				G = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				b = { "<cmd>Telescope buffers<cr>", "Resume last search" },
				c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
				h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
				q = { "<cmd>Telescope macroscope<cr>", "Find Help" },
				H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
				M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
				r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
				R = { "<cmd>Telescope registers<cr>", "Registers" },
				d = { "<cmd>Telescope live_grep<cr>", "live grep" },
				k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
				C = { "<cmd>Telescope commands<cr>", "Commands" },
				l = { "<cmd>Telescope resume<cr>", "Resume last search" },
				p = { "<cmd>Telescope neoclip<cr>", "Resume last search" },
				z = {
					"<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
					"Colorscheme with Preview",
				},
			},
			T = {
				name = "Treesitter",
				i = { ":TSConfigInfo<cr>", "Info" },
			},
		}
		local vmappings = {

			j = {
				name = "Java only LSP",
				je = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "extract variable" },
				jm = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "extract method" },
			},
		}
		wk.register(mappings, opts)
		wk.register(vmappings, vopts)
	end,
	opts = {
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		},
		presets = {
			operators = false,
			motions = false,
			text_objects = false,
			windows = false,
			nav = false,
			z = false,
			g = false,
			c = false,
		},
		operators = { gc = "Comments" },
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 0,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3,           -- spacing between columns
			align = "left",        -- align columns left, center or right
		},
		ignore_missing = true,
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true,                                                       -- show help message on the command line when the popup is visible
		show_keys = true,                                                       -- show the currently pressed key and its label as a message in the command line
		triggers = {
			"<leader>",
			"`",
		},
		-- triggers_nowait = {
		-- 	"o",
		-- },
		triggers_blacklist = {
			i = { "j", "k" },
			v = { "j", "k" },
			n = { "j", "k", "o", "O", "c", "C", "<leader>c" },
		},
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
	},
}
