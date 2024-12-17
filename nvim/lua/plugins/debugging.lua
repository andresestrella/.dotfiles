--require 'mason-nvim-dap'.setup_handlers {}
--require('mason-nvim-dap').setup_handlers()
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "⏸", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "", linehl = "", numhl = "" })

-- local VSCODE_JS_DIR = "~/AppData/Local/nvim-data/lazy/vscode-js-debug"
local VSCODE_JS_DIR = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"

return { --debugging
	{
		"mfussenegger/nvim-dap",
		event = "BufRead",
		dependencies = {
			{ "jay-babu/mason-nvim-dap.nvim" },
			--dap setup
			-- "rcarriga/nvim-dap-ui",
		},
		keys = { "<leader>b", "F9", "F5" },
		config = function()
			local js_based_languages = { "typescript", "javascript", "typescriptreact", "svelte" }

			for _, language in ipairs(js_based_languages) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-chrome",
						request = "launch",
						name = 'Start Chrome with "localhost"',
						url = "http://localhost:3000",
						webRoot = "${workspaceFolder}",
						userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
					},
				}
			end
			local ok_cmp, cmp = pcall(require, "cmp")
			if ok_cmp then
				cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
					sources = cmp.config.sources({
						{ name = "dap" },
					}, {
						{ name = "buffer" },
					}),
				})
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = true,
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
		event = "BufRead",
	},
	{
		"rcarriga/nvim-dap-ui",
		-- config = true,
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio"
		},
		keys = {
			{ "<leader>b", [[:DapToggleBreakpoint <CR>]] },
			{ "<leader>B", [[:lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>]] },
			{ "<leader>dc", [[:DapContinue <CR>]] },
			{ "<leader>dj", [[:DapStepOut <CR>]] },
			{ "<leader>dk", [[:DapStepIn <CR>]] },
			{ "<leader>dl", [[:DapStepOver <CR>]] },
			{ "<leader>dh", [[:lua require'dapui'.eval()<CR>]] },
			{ "<leader>da", [[:lua require'dap'.attach()<CR>]] },
			{ "<leader>du", [[:lua require'dapui'.toggle()<CR>]] },

			{ "<F5>", [[:lua require"dapui".toggle()<CR>]] },
			{ "<F6>", [[:lua require"dapui".eval()<CR>]] },
			{ "<F7>", [[:lua require"dap.ui.widgets".hover()<CR>]] },
			{ "<F8>", [[:lua require"dap".repl.toggle()<CR>]] },
			{ "<F9>", [[:lua require"dap".continue()<CR>]] },
			{ "<F10>", [[:lua require"dap".step_over()<CR>]] },
			{ "<F11>", [[:lua require"dap".step_into()<CR>]] },
			{ "<F12>", [[:lua require"dap".step_out()<CR>]] },
			{ "[s", [[:lua require"dap".up()<CR>]] },
			{ "]s", [[:lua require"dap".down()<CR>]] },
			{ "<leader>dr", [[:lua require"dap".repl.toggle()<CR>]] },
			{ "<leader>db", [[:lua require"dapui".float_element("breakpoints", {width = 130, height = 40, position = "center", enter = true})<CR>]] },
			{ "<leader>dw", [[:lua require"dapui".float_element('watches', {width = 130, height = 40, position = "center", enter = true})<CR>]] },
			{ "<leader>ds", [[:lua require"dapui".float_element('scopes', {width = 130, height = 40, position = "center", enter = true})<CR>]] },
			{ "<leader>dt", [[:lua require"dapui".float_element('stacks', {width = 130, height = 40, position = "center", enter = true})<CR>]] }
		},
		opts = {},
		config = function(_, opts)
			-- local neotree_open = require("helpers.toggle").is_neotree_open()

			vim.api.nvim_set_keymap("n", "<Leader>du", [[:lua require'dapui'.toggle()<CR>]], { noremap = true })
			--automatically open and close dapui
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		ft = { "javascript", "typescript", "typescriptreact", "svelte", "javascriptreact" },
		config = function()
			require("dap-vscode-js").setup({
				debugger_path = VSCODE_JS_DIR, -- Path to vscode-js-debug installation.
				adapters = {
					"chrome",
					"pwa-node",
					"pwa-chrome",
					"pwa-msedge",
					"node-terminal",
					"pwa-extensionHost",
					"node",
					"chrome",
				}, -- which adapters to register in nvim-dap
				-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
				-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
				-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
			})
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		config = function()
			--dap python setup
			-- require('dap-python').setup('~/.virtualenvs/debugpy/Scripts/python') --directly pass path to a python venv that has debugpy installed
			--windows, installed by mason
			require("dap-python").setup("~/AppData/Local/nvim-data/mason/packages/debugpy/venv/Scripts/python") --directly pass path to a python venv that has debugpy installed
			--for linux:
			--require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
		end,
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
		},
	},
	{ -- vscode's js dbug adapter
		"microsoft/vscode-js-debug",
		lazy = true,
		build = function()
			local is_win = vim.loop.os_uname().version:match("Windows")
			local move_cmd = is_win and "move dist out" or "mv dist out"
			os.execute("npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && " .. move_cmd)
		end,
	},
}

-- python = function(config)
-- 	config.adapters = {
-- 		type = "executable",
-- 		command = "python",
-- 		-- command = PYTHON_DIR,
-- 		--command = "/usr.local/bin/python3",
-- 		--command = "python3",
-- 		args = { "-m", "debugpy.adapter" },
-- 	}
-- 	config.configurations = {
-- 		{
-- 			-- The first three options are required by nvim-dap
-- 			type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
-- 			request = "launch",
-- 			name = "Launch file",
-- 			-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
--
-- 			program = "${file}", -- This configuration will launch the current file if used.
-- 			pythonPath = function()
-- 				-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
-- 				-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
-- 				-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
-- 				local PYTHON_DIR = require("mason-registry").get_package("debugpy"):get_install_path()
-- 					.. "/venv/Scripts/python"
-- 				local cwd = vim.fn.getcwd()
-- 				if vim.fn.executable(cwd .. "/venv/Scripts/python") == 1 then
-- 					return cwd .. "/venv/Scripts/python"
-- 				elseif vim.fn.executable(cwd .. "/.venv/Scripts/python") == 1 then
-- 					return cwd .. "/.venv/Scripts/python"
-- 				elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
-- 					return cwd .. "/venv/bin/python"
-- 				elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
-- 					return cwd .. "/.venv/bin/python"
-- 				else
-- 					return PYTHON_DIR -- if no virtualenv is found fall back to the python installed by MASON
-- 				end
-- 			end,
-- 		},
-- 	}
-- 	require("mason-nvim-dap").default_setup(config)
-- end,


-- vim.api.nvim_set_keymap('n', '<Leader>db', [[:lua require"dapui".float_element("breakpoints", {position = "nil", enter = true})<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>dw', [[:lua require"dapui".float_element('watches', {position = "nil", enter = true})<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>ds', [[:lua require"dapui".float_element('scopes', {position = "nil", enter = true})<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>dt', [[:lua require"dapui".float_element('stacks', {position = "nil", enter = true})<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>dh", [[:lua require'dapui'.eval()<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dh', [[:lua require'dap.ui.widgets'.cursor_float(require'dap.ui.widgets'.expression, {height=50, width=50})<CR>]], { noremap = true })
-- couldn't get this to work. don't know how to pass in the height and width correctly.
-- vim.api.nvim_set_keymap('n', '<leader>ds', [[:lua require'dap.ui.widgets'.centered_float(require'dap.ui.widgets'.scopes)<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>da", [[:lua require'dap'.attach()<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap("n", "<Leader>du", [[:lua require'dapui'.toggle()<CR>]], { noremap = true })

