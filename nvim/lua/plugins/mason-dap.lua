-- local config = {
-- 	name, -- adapter name

-- 	-- All the items below are looked up by the adapter name.
-- 	adapters, -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/adapters.lua
-- 	configurations, -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/configurations.lua
-- 	filetypes -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/filetypes.lua
-- }
local masonDapOpts = {
	ensure_installed = {
		-- "bash",
		-- "chrome",
		-- "python",
		-- "codelldb",
		-- "coreclr",
		-- "cppdbg",
		-- "javadbg",
		-- "javatest",
		-- "js",
	},
	automatic_installation = true,
	handlers = {},
	-- handlers = {
	-- 	function(config)
	-- 		require("mason-nvim-dap").default_setup(config)
	-- 	end,
	-- 	python = function(config)
	-- 		config.adapters = {
	-- 			type = "executable",
	-- 			command = "/usr/bin/python3",
	-- 			args = { "-m", "debugpy.adapter" },
	-- 		}
	-- 		require("mason-nvim-dap").default_setup(config)
	-- 	end,
	-- 	coreclr = function(config)
	-- 		config.adapters = {
	-- 			type = "executable",
	-- 			command = require("mason-registry").get_package("netcoredbg"):get_install_path() .. "/netcoredbg/netcoredbg",
	-- 			args = { "--interpreter=vscode" },
	-- 		}
	-- 		config.configurations = {
	-- 			type = "coreclr",
	-- 			name = "launch netcoredbg",
	-- 			request = "launch",
	-- 			program = function()
	-- 				-- return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
	-- 				return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
	-- 			end,
	-- 		}
	-- 		config.filetypes = { "cs", "fsharp" }
	-- 		require("mason-nvim-dap").default_setup(config)
	-- 	end,
	-- },
}

-- all sources with no handler get passed here

local handlers = function()
	--these work on windows
	local CODELLDB_DIR = require("mason-registry").get_package("codelldb"):get_install_path()
		.. "/extension/adapter/codelldb"
	local codelldb_port = "1300" --rust debugger port
	local dap = require("dap")
	--manual rust set up, tested
	dap.adapters.codelldb = {
		type = "server",
		port = codelldb_port,
		--port = "${port}",
		executable = {
			--command = os.getenv("HOME"), "/.local/share/nvim/mason/bin/codelldb", -- installed with mason
			--command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
			-- command = os.getenv("HOME") .. "/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb", -- windows, installed with mason
			command = CODELLDB_DIR, -- windows, installed with mason
			-- command = (function()
			--         return os.getenv("HOME") ..
			--             "/AppData/Local/nvim-data/mason/packages/codelldb/extension/lldb/bin/lldb"
			--     end)(),
			args = { "--port", codelldb_port },
		},
		name = "codelldb",
		-- On windows you may have to uncomment this:
		detached = false,
	}

	dap.configurations.rust = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			-- args = function()
			--     local input = vim.fn.input("Input args: ")
			--     return vim.fn.split(input, " ", true)
			-- end,
			-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
			--
			--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
			--
			-- Otherwise you might get the following error:
			--
			--    Error on launch: Failed to attach to the target process
			--
			-- But you should be aware of the implications:
			-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
			--runInTerminal = false,
			showDisassembly = "never",
		},
	}
	-- 	},
	-- 	{
	-- 		name = "Launch file (codelldb)",
	-- 		type = "codelldb",
	-- 		request = "launch",
	-- 		program = function()
	-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	-- 		end,
	-- 		cwd = "${workspaceFolder}",
	-- 		stopOnEntry = false,
	-- 	},
	-- }
	-- dap.configurations.c = dap.configurations.cpp
end

local listeners = function()
	local dap, dapui = require("dap"), require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "BufReadPost",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("mason-nvim-dap").setup(masonDapOpts)
			-- handlers()
			listeners()
			-- require("mason-nvim-dap").setup({})
		end,
	},
}
