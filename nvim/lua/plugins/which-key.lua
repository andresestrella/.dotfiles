return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	keys = {
	    {
	      "<leader>?",
	      function()
		require("which-key").show({ global = false })
	      end,
	      desc = "Buffer Local Keymaps (which-key)",
	    },
	},
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
			silent = false,
			noremap = false,
			nowait = false,
		}
		local vopts = {
			mode = "v", -- VISUAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = false, -- use `nowait` when creating keymaps
		}
		local mappings = {
		    { "<leader>,", group = "logs", nowait = false, remap = true, silent = false },
		    { "<leader>,D", "<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>", desc = "Open the default logfile", nowait = false, remap = true, silent = false },
		    { "<leader>,L", "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", desc = "Open the LSP logfile", nowait = false, remap = true, silent = false },
		    { "<leader>,N", "<cmd>edit $NVIM_LOG_FILE<cr>", desc = "Open the Neovim logfile", nowait = false, remap = true, silent = false },
		    { "<leader>,d", "<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>", desc = "view default log", nowait = false, remap = true, silent = false },
		    { "<leader>,l", "<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>", desc = "view lsp log", nowait = false, remap = true, silent = false },
		    { "<leader>,n", "<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>", desc = "view neovim log", nowait = false, remap = true, silent = false },
		    { "<leader>H", "<Plug>(leap-backward-till)", desc = "Leap backward", nowait = false, remap = true, silent = false },
		    { "<leader>T", group = "Treesitter", nowait = false, remap = true, silent = false },
		    { "<leader>Ti", ":TSConfigInfo<cr>", desc = "Info", nowait = false, remap = true, silent = false },
		    { "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = false, remap = true, silent = false },
		    { "<leader>b", ":DapToggleBreakpoint <CR>", desc = "Breakpoint Toggle", nowait = false, remap = true, silent = false },
		    { "<leader>d", group = "Debug", nowait = false, remap = true, silent = false },
		    { "<leader>dB", desc = "<cr>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", nowait = false, remap = true, silent = false },
		    { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor", nowait = false, remap = true, silent = false },
		    { "<leader>dU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI", nowait = false, remap = true, silent = false },
		    { "<leader>da", desc = "<cr>lua require'dap'.attach()<CR>", nowait = false, remap = true, silent = false },
		    { "<leader>db", "<cr>lua require'dapui'.float_element('breakpoints', {width = 130, height = 40, position = 'center', enter = true})<CR>", desc = "breakpoints UI", nowait = false, remap = true, silent = false },
		    { "<leader>dc", "<cr>DapContinue <CR>", desc = "Continue", nowait = false, remap = true, silent = false },
		    { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect", nowait = false, remap = true, silent = false },
		    { "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session", nowait = false, remap = true, silent = false },
		    { "<leader>dh", desc = "<cr>lua require'dapui'.eval()<CR>", nowait = false, remap = true, silent = false },
		    { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", nowait = false, remap = true, silent = false },
		    { "<leader>dj", "<cr>DapStepOut <CR>", desc = "Step Out", nowait = false, remap = true, silent = false },
		    { "<leader>dk", "<cr>DapStepIn <CR>", desc = "Step In", nowait = false, remap = true, silent = false },
		    { "<leader>dl", "<cr>DapStepOver <CR>", desc = "Step Over", nowait = false, remap = true, silent = false },
		    { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", nowait = false, remap = true, silent = false },
		    { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause", nowait = false, remap = true, silent = false },
		    { "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit", nowait = false, remap = true, silent = false },
		    { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Repl Toggle", nowait = false, remap = true, silent = false },
		    { "<leader>ds", "<cr>lua require'dapui'.float_element('scopes', {width = 130, height = 40, position = 'center', enter = true})<CR>", desc = "scopes UI", nowait = false, remap = true, silent = false },
		    { "<leader>dt", "<cr>lua require'dapui'.float_element('stacks', {width = 130, height = 40, position = 'center', enter = true})<CR>", desc = "stack UI", nowait = false, remap = true, silent = false },
		    { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", nowait = false, remap = true, silent = false },
		    { "<leader>dw", "<cr>lua require'dapui'.float_element('watches', {width = 130, height = 40, position = 'center', enter = true})<CR>", desc = "watches UI", nowait = false, remap = true, silent = false },
		    { "<leader>e", ":Neotree toggle right<CR>", desc = "File Tree toggle", nowait = false, remap = true, silent = false },
		    { "<leader>g", group = "Git", nowait = false, remap = true, silent = false },
		    { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", nowait = false, remap = true, silent = false },
		    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff", nowait = false, remap = true, silent = false },
		    { "<leader>gh", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", nowait = false, remap = true, silent = false },
		    { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", desc = "Next Hunk", nowait = false, remap = true, silent = false },
		    { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", desc = "Prev Hunk", nowait = false, remap = true, silent = false },
		    { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = false, remap = true, silent = false },
		    { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", nowait = false, remap = true, silent = false },
		    { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk", nowait = false, remap = true, silent = false },
		    { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", nowait = false, remap = true, silent = false },
		    { "<leader>h", "<Plug>(leap-forward-till)", desc = "Leap forward", nowait = false, remap = true, silent = false },
		    { "<leader>j", group = "Java only LSP", nowait = false, remap = true, silent = false },
		    { "<leader>jE", "<Cmd>lua require('jdtls').extract_variable_all()<CR>", desc = "extract and replace all", nowait = false, remap = true, silent = false },
		    { "<leader>jG", "<Cmd>lua require'jdtls.tests'.generate()<CR>", desc = "generate test class", nowait = false, remap = true, silent = false },
		    { "<leader>jc", "<Cmd>lua require('jdtls').extract_constant()<CR>", desc = "extract constant", nowait = false, remap = true, silent = false },
		    { "<leader>je", "<Cmd>lua require('jdtls').extract_variable()<CR>", desc = "extract variable", nowait = false, remap = true, silent = false },
		    { "<leader>jg", "<Cmd>lua require'jdtls.tests'.goto_subjects()<CR>", desc = "goto test subject", nowait = false, remap = true, silent = false },
		    { "<leader>ji", "<cmd>lua require'jdtls'.organize_imports()<CR>", desc = "Organize Imports", nowait = false, remap = true, silent = false },
		    { "<leader>jj", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", desc = "test neares method", nowait = false, remap = true, silent = false },
		    { "<leader>jt", "<Cmd>lua require'jdtls'.test_class()<CR>", desc = "Test class", nowait = false, remap = true, silent = false },
		    { "<leader>l", group = "LSP", nowait = false, remap = true, silent = false },
		    { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Info", nowait = false, remap = true, silent = false },
		    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = false, remap = true, silent = false },
		    { "<leader>lf", "<cmd>lua require('lvim.lsp.utils').format()<cr>", desc = "Format", nowait = false, remap = true, silent = false },
		    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", nowait = false, remap = true, silent = false },
		    { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic", nowait = false, remap = true, silent = false },
		    { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic", nowait = false, remap = true, silent = false },
		    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", nowait = false, remap = true, silent = false },
		    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix", nowait = false, remap = true, silent = false },
		    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = false, remap = true, silent = false },
		    { "<leader>m", "<cmd>lua require('treesj').toggle()<CR>", desc = "collapse/join toggle", nowait = false, remap = true, silent = false },
		    { "<leader>r", group = "Refactoring", nowait = false, remap = true, silent = false },
		    { "<leader>rb", "<cmd>Refactor extract_block<cr>", desc = "Extract Block", nowait = false, remap = true, silent = false },
		    { "<leader>rbf", "<cmd>Refactor extract_block_to_file<cr>", desc = "Extract Block to file", nowait = false, remap = true, silent = false },
		    { "<leader>re", "<cmd>Refactor extract<cr>", desc = "Extract", nowait = false, remap = true, silent = false },
		    { "<leader>rf", "<cmd>Refactor extract_to_file<cr>", desc = "Extract to file", nowait = false, remap = true, silent = false },
		    { "<leader>ri", "<cmd>Refactor inline_var<cr>", desc = "Extract inline var", nowait = false, remap = true, silent = false },
		    { "<leader>rl", "<cmd>Refactor inline_func<cr>", desc = "Extract inline function", nowait = false, remap = true, silent = false },
		    { "<leader>rr", "<cmd>lua require('refactoring').refactor('Rename')<cr>", desc = "Rename", nowait = false, remap = true, silent = false },
		    { "<leader>rv", "<cmd>Refactor extract_var<cr>", desc = "Extract Variable", nowait = false, remap = true, silent = false },
		    { "<leader>t", group = "Tabs / Testing", nowait = false, remap = true, silent = false },
		    { "<leader>tF", "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", desc = "Run File with DAP", nowait = false, remap = true, silent = false },
		    { "<leader>tM", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Run with DAP", nowait = false, remap = true, silent = false },
		    { "<leader>tf", "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", desc = "Run File", nowait = false, remap = true, silent = false },
		    { "<leader>tm", "<cmd>lua require('neotest').run.run()<cr>", desc = "Run", nowait = false, remap = true, silent = false },
		    { "<leader>tn", "<cmd>tabn<cr>", desc = "Next tab", nowait = false, remap = true, silent = false },
		    { "<leader>tp", "<cmd>tabp<cr>", desc = "Previous tab", nowait = false, remap = true, silent = false },
		    { "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Summary", nowait = false, remap = true, silent = false },
		    { "<leader>tw", "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>", desc = "Watch", nowait = false, remap = true, silent = false },
		    { "<leader>tx", "<cmd>tabclose<cr>", desc = "Close Tab", nowait = false, remap = true, silent = false },
		    { "<leader>u", "UndoTreeToggle<CR> ", desc = "Undo tree", nowait = false, remap = true, silent = false },
		    { "<leader>w", group = "Workspace LSP", nowait = false, remap = true, silent = false },
		    { "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", desc = "Add Folder", nowait = false, remap = true, silent = false },
		    { "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", desc = "List Folders", nowait = false, remap = true, silent = false },
		    { "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", desc = "Remove Folder", nowait = false, remap = true, silent = false },
		    { "<leader>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", desc = "Workspace Symbol", nowait = false, remap = true, silent = false },
		    { "<leader>x", group = "Trouble", nowait = false, remap = true, silent = false },
			{ "<leader>x", ":Trouble diagnostics toggle filter.buf=0<CR>", desc = "Togle trouble document diagnostics" },
			{ "<leader>xx", ":Trouble diagnostics toggle<CR>", desc = "Toggle trouble diagnostics" },
			{ "<leader>xa", ":Trouble diagnostics toggle<CR>", desc = "Toggle trouble diagnostics" },
			{ "<leader>xt", ":Trouble todo toggle<CR>", desc = "Toggle trouble todos list" },
			{ "<leader>xq", ":Trouble quickfix toggle<CR>", desc = "Toggle trouble quickfix list" },
			{ "<leader>xl", ":Trouble loclist toggle<CR>", desc = "Toggle trouble location list" },
		}

		local vmappings =  {
				mode = { "v" },
				{ "<leader>j", group = "Java only LSP", nowait = false, remap = false },
				{ "<leader>jje", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", desc = "extract variable", nowait = false, remap = false, },
				{ "<leader>jjm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", desc = "extract method", nowait = false, remap = false, },
				{ "<leader>r", group = "Refactoring", nowait = false, remap = false },
				{ "<leader>rb", "<cmd>lua require('refactoring').refactor('Extract Block')<cr>", desc = "Extract Table", nowait = false, remap = false, },
				{ "<leader>rf", "<cmd>lua require('refactoring').refactor('Extract Function')<cr>", desc = "Extract Table", nowait = false, remap = false, },
				{ "<leader>rr", "<cmd>lua require('refactoring').select_refactor('')<cr>", desc = "Select refactor", nowait = false, remap = false, },
				{ "<leader>rs", "<cmd>lua require('refactoring').refactor('Extract Selection')<cr>", desc = "Extract Selection", nowait = false, remap = false, },
				{ "<leader>rv", "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>", desc = "Extract Variable", nowait = false, remap = false, },
			},
		wk.add(mappings, opts)
		wk.add(vmappings, vopts)
	end,
	opts = {
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		},
		presets = {
			motions = false,
			text_objects = false,
			windows = false,
			nav = false,
			z = false,
			g = false,
			c = false,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		show_help = true, -- show help message on the command line when the popup is visible
		show_keys = true, -- show the currently pressed key and its label as a message in the command line
		disable = {
			buftypes = {},
		},
	},
}
