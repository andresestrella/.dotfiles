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
			-- [";"] = { "<cmd><cmd>"," Dashboard"},
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			u = { "UndoTreeToggle<CR> ", "Undo tree" },
			e = { ":Neotree toggle right<CR>", "File Tree toggle" },
			b = { ":DapToggleBreakpoint <CR>", "Breakpoint Toggle" },
			m = { "<CMD>TSJToggle<CR>", "collapse/join toggle" },
			-- r = { ":lua vim.lsp.buf.rename()<CR>", "Rename" },
			-- f = { ":lua vim.lsp.buf.format()<CR>", "Format" },
			T = { name = "Treesitter", i = { ":TSConfigInfo<cr>", "Info" } },
			t = {
				name = "tabs",
				x = { "<cmd>tabclose<cr>", "Close Tab" },
				n = { "<cmd>tabn<cr>", "Next tab" },
				p = { "<cmd>tabp<cr>", "Previous tab" },
			},
			r = {
				name = "Refactoring",
				r = { "<cmd>lua require('refactoring').refactor('Rename')<cr>", "Rename" },
				v = { "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>", "Extract Variable" },
				s = { "<cmd>lua require('refactoring').refactor('Extract Selection')<cr>", "Extract Selection" },
				f = { "<cmd>lua require('refactoring').refactor('Extract Function')<cr>", "Extract Table" },
				b = { "<cmd>lua require('refactoring').refactor('Extract Block')<cr>", "Extract Table" },
			},
			w = {
				name = "Workspace LSP",
				s = { "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", "Workspace Symbol" },
				a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add Folder" },
				r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Folder" },
				l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List Folders" },
			},
			d = {
				name = "Debug",
				-- t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
				B = { "<cr>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" },
				c = { "<cr>DapContinue <CR>", "Continue" },
				C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
				q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },

				h = { "<cr>lua require'dapui'.eval()<CR>" },

				a = { "<cr>lua require'dap'.attach()<CR>" },
				d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },

				-- u = { "<cr>lua require'dapui'.toggle()<CR>" },
				U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
				g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
				r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl Toggle" },
				b = {
					"<cr>lua require'dapui'.float_element('breakpoints', {width = 130, height = 40, position = 'center', enter = true})<CR>",
					"breakpoints UI",
				},
				w = {
					"<cr>lua require'dapui'.float_element('watches', {width = 130, height = 40, position = 'center', enter = true})<CR>",
					"watches UI",
				},
				s = {
					"<cr>lua require'dapui'.float_element('scopes', {width = 130, height = 40, position = 'center', enter = true})<CR>",
					"scopes UI",
				},
				t = {
					"<cr>lua require'dapui'.float_element('stacks', {width = 130, height = 40, position = 'center', enter = true})<CR>",
					"stack UI",
				},

				j = { "<cr>DapStepOut <CR>", "Step Out" },
				k = { "<cr>DapStepIn <CR>", "Step In" },
				l = { "<cr>DapStepOver <CR>", "Step Over" },

				i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
				o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
				u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
				p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
			},
			j = {
				name = "Java only LSP",
				i = { "<cmd>lua require'jdtls'.organize_imports()<CR>", "Organize Imports" },
				t = { "<Cmd>lua require'jdtls'.test_class()<CR>", "Test class" },
				j = { "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", "test neares method" },
				e = { "<Cmd>lua require('jdtls').extract_variable()<CR>", "extract variable" },
				E = { "<Cmd>lua require('jdtls').extract_variable_all()<CR>", "extract and replace all" },
				c = { "<Cmd>lua require('jdtls').extract_constant()<CR>", "extract constant" },
				g = { "<Cmd>lua require'jdtls.tests'.goto_subjects()<CR>", "goto test subject" },
				G = { "<Cmd>lua require'jdtls.tests'.generate()<CR>", "generate test class" },
			},
			g = {
				name = "Goto / Git",
				r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },

				-- g = { "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", "Lazygit" },
				j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
				k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
				l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
				p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
				h = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
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
				d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },

				t = { "<cmd>lua require'telescope'.extensions.git_worktree.git_worktrees()<cr>", "Git Worktree" },
				n = {
					"<cmd>lua require'telescope'.extensions.git_worktree.create_git_worktrees()<cr>",
					"Create Git Worktree",
				},
			},
			l = {
				name = "LSP",
				a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
				d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
				w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
				f = { "<cmd>lua require('lvim.lsp.utils').format()<cr>", "Format" },
				i = { "<cmd>LspInfo<cr>", "Info" },
				I = { "<cmd>Mason<cr>", "Mason Info" },
				j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
				k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
				l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
				q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
				r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
				s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
				S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
				e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
			},
			s = {
				name = "Harpoon",
				s = { "<cmd>lua require'harpoon.ui'.toggle_quick_menu()<CR>", "toggle menu" },
				a = { "<cmd>lua require'harpoon.mark'.add_file()<CR>", "add file" },
				u = { "<cmd>lua require'harpoon.ui'.nav_file(1)<CR>", "go to file 1" },
				i = { "<cmd>lua require'harpoon.ui'.nav_file(2)<CR>", "go to file 2" },
				o = { "<cmd>lua require'harpoon.ui'.nav_file(3)<CR>", "go to file 3" },
				p = { "<cmd>lua require'harpoon.ui'.nav_file(3)<CR>", "go to file 4" },
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
			l = {
				name = "+logs",
				d = {
					"<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>",
					"view default log",
				},
				D = {
					"<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>",
					"Open the default logfile",
				},
				l = {
					"<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>",
					"view lsp log",
				},
				L = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", "Open the LSP logfile" },
				n = {
					"<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>",
					"view neovim log",
				},
				N = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open the Neovim logfile" },
			},
			x = {
				name = "Trouble",
				x = { "<cmd>TroubleToggle<cr>", "Trouble" },
				a = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Workspace" },
				d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Document" },
				q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
				l = { "<cmd>TroubleToggle loclist<cr>", "Location List" },
			},
		}
		local vmappings = {
			r = {
				name = "Refactoring",
				r = { "<cmd>lua require('refactoring').select_refactor('')<cr>", "Select refactor" },
				v = { "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>", "Extract Variable" },
				s = { "<cmd>lua require('refactoring').refactor('Extract Selection')<cr>", "Extract Selection" },
				f = { "<cmd>lua require('refactoring').refactor('Extract Function')<cr>", "Extract Table" },
				b = { "<cmd>lua require('refactoring').refactor('Extract Block')<cr>", "Extract Table" },
			},
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
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		ignore_missing = true,
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true, -- show help message on the command line when the popup is visible
		show_keys = true, -- show the currently pressed key and its label as a message in the command line
		triggers = {
			"<leader>",
			"`",
		},
		triggers_nowait = {
			-- marks
			"`",
			"'",
			"g`",
			"g'",
			-- registers
			'"',
			"<c-r>",
			-- spelling
			"z=",
		},
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
