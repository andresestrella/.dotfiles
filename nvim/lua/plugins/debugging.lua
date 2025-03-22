vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "⏸", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "", linehl = "", numhl = "" })

local js_based_languages = {
	"typescript",
	"javascript",
	"typescriptreact",
	"javascriptreact",
	"svelte",
}

return { --debugging
	{
		"mfussenegger/nvim-dap",
		event = "BufRead",
		dependencies = {
			{
				"williamboman/mason.nvim",
				"jay-babu/mason-nvim-dap.nvim",
				"nvim-neotest/nvim-nio",
				"rcarriga/nvim-dap-ui",
				-- js debugging
				{
					"microsoft/vscode-js-debug",
					-- After install, build it and rename the dist directory to out
					build =
					"npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
					version = "1.*",
				},
				{
					"mxsdev/nvim-dap-vscode-js",
					config = function()
						---@diagnostic disable-next-line: missing-fields
						require("dap-vscode-js").setup({
							-- Path of node executable. Defaults to $NODE_PATH, and then "node"
							-- node_path = "node",

							-- Path to vscode-js-debug installation.
							debugger_path = vim.fn.resolve(vim.fn.stdpath("data") ..
								"/lazy/vscode-js-debug"),

							-- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
							-- debugger_cmd = { "js-debug-adapter" },

							-- which adapters to register in nvim-dap
							adapters = {
								"chrome",
								"pwa-node",
								"pwa-chrome",
								"pwa-msedge",
								"pwa-extensionHost",
								"node-terminal",
							},

							-- Path for file logging
							-- log_file_path = "(stdpath cache)/dap_vscode_js.log",

							-- Logging level for output to file. Set to false to disable logging.
							-- log_file_level = false,

							-- Logging level for output to console. Set to false to disable console output.
							-- log_console_level = vim.log.levels.ERROR,
						})
					end,
				},
				{ -- this is needed to parse .vscode/launch.json
					"Joakker/lua-json5",
					build = "./install.sh",
				},
			},
		},
		keys = {
			{ "<leader>db", [[:DapToggleBreakpoint <CR>]] },
			{ "<leader>dB", [[:lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>]] },
			{ "<leader>dc", [[:DapContinue <CR>]] },
			{ "<leader>dj", [[:DapStepOut <CR>]] },
			{ "<leader>dk", [[:DapStepIn <CR>]] },
			{ "<leader>dl", [[:DapStepOver <CR>]] },
			{ "<leader>dh", [[:lua require'dapui'.eval()<CR>]] },
			{ "<leader>du", [[:lua require'dapui'.toggle()<CR>]] },

			{ "<F5>",       [[:lua require"dapui".toggle()<CR>]] },
			{ "<F6>",       [[:lua require"dapui".eval()<CR>]] },
			{ "<F7>",       [[:lua require"dap.ui.widgets".hover()<CR>]] },
			{ "<F8>",       [[:lua require"dap".repl.toggle()<CR>]] },
			{ "<F9>",       [[:lua require"dap".continue()<CR>]] },
			{ "<F10>",      [[:lua require"dap".step_over()<CR>]] },
			{ "<F11>",      [[:lua require"dap".step_into()<CR>]] },
			{ "<F12>",      [[:lua require"dap".step_out()<CR>]] },
			{ "[s",         [[:lua require"dap".up()<CR>]] },
			{ "]s",         [[:lua require"dap".down()<CR>]] },
			{ "<leader>dr", [[:lua require"dap".repl.toggle()<CR>]] },
			-- { "<leader>db", [[:lua require"dapui".float_element("breakpoints", {width = 130, height = 40, position = "center", enter = true})<CR>]] },
			{ "<leader>dw", [[:lua require"dapui".float_element('watches', {width = 130, height = 40, position = "center", enter = true})<CR>]] },
			{ "<leader>ds", [[:lua require"dapui".float_element('scopes', {width = 130, height = 40, position = "center", enter = true})<CR>]] },
			{ "<leader>dt", [[:lua require"dapui".float_element('stacks', {width = 130, height = 40, position = "center", enter = true})<CR>]] },

			-- { "<leader>da", [[:lua require'dap'.attach()<CR>]] },
			{
				"<leader>da",
				function()
					if vim.fn.filereadable(".vscode/launch.json") then
						local dap_vscode = require("dap.ext.vscode")
						dap_vscode.load_launchjs(nil, {
							["pwa-node"] = js_based_languages,
							["chrome"] = js_based_languages,
							["pwa-chrome"] = js_based_languages,
						})
					end
					require("dap").continue()
				end,
				desc = "Run with Args",
			},
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			require('mason-nvim-dap').setup {
				automatic_installation = true,
				ensure_installed = {},
				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {},
			}

			dapui.setup {
				--    Feel free to remove or use ones that you like more! :)
				icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
				controls = {
					icons = {
						pause = '⏸',
						play = '▶',
						step_into = '⏎',
						step_over = '⏭',
						step_out = '⏮',
						step_back = 'b',
						run_last = '▶▶',
						terminate = '⏹',
						disconnect = '⏏',
					},
				},
			}
			dap.listeners.after.event_initialized["dapui_config"] = dapui.open()
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close()
			dap.listeners.before.event_exited["dapui_config"] = dapui.close()

			--js debugging setup
			for _, language in ipairs(js_based_languages) do
				dap.configurations[language] = {
					-- Debug single nodejs files
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
					},
					-- Debug nodejs processes (make sure to add --inspect when you run the process)
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
					},
					-- Debug web applications (client side)
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch & Debug Chrome",
						url = function()
							local co = coroutine.running()
							return coroutine.create(function()
								vim.ui.input({
									prompt = "Enter URL: ",
									default = "http://localhost:3000",
								}, function(url)
									if url == nil or url == "" then
										return
									else
										coroutine.resume(co, url)
									end
								end)
							end)
						end,
						webRoot = vim.fn.getcwd(),
						protocol = "inspector",
						sourceMaps = true,
						userDataDir = false,
					},
					-- Divider for the launch.json derived configs
					{
						name = "----- ↓ launch.json configs ↓ -----",
						type = "",
						request = "launch",
					},
				}
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
		event = "BufRead",
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
			require("dap-python").setup(
				"~/AppData/Local/nvim-data/mason/packages/debugpy/venv/Scripts/python") --directly pass path to a python venv that has debugpy installed
			--for linux:
			--require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
		end,
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
}
