require("mason").setup()
require("mason-nvim-dap").setup({
    ensure_installed = { "python", "js", "codelldb" },
    -- automatic_setup = true,
    automatic_installation = true,
    handlers = {
        function(config)
            -- all sources with no handler get passed here

            -- Keep original functionality of `automatic_setup = true`
            require('mason-nvim-dap').default_setup(config)
        end,
        python = function(config)
            config.adapters = {
                type = "executable",
                command = "python",
                -- command = PYTHON_DIR,
                --command = "/usr.local/bin/python3",
                --command = "python3",
                args = { "-m", "debugpy.adapter", },
            }
            config.configurations = {
                {
                    -- The first three options are required by nvim-dap
                    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
                    request = 'launch',
                    name = "Launch file",
                    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                    program = "${file}", -- This configuration will launch the current file if used.
                    pythonPath = function()
                        -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                        -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                        -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                        local PYTHON_DIR = require('mason-registry').get_package('debugpy'):get_install_path() .. '/venv/Scripts/python'
                        local cwd = vim.fn.getcwd()
                        if vim.fn.executable(cwd .. '/venv/Scripts/python') == 1 then
                            return cwd .. '/venv/Scripts/python'
                        elseif vim.fn.executable(cwd .. '/.venv/Scripts/python') == 1 then
                            return cwd .. '/.venv/Scripts/python'
                        elseif vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                            return cwd .. '/venv/bin/python'
                        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                            return cwd .. '/.venv/bin/python'
                        else
                            return PYTHON_DIR
                        end
                    end,
                },
            }
            require('mason-nvim-dap').default_setup(config)
        end,
    },
})
--require 'mason-nvim-dap'.setup_handlers {}
--require('mason-nvim-dap').setup_handlers()
require("nvim-dap-virtual-text").setup()
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "⏸", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "", linehl = "", numhl = "" })

--these work on windows
local CODELLDB_DIR = require('mason-registry').get_package('codelldb'):get_install_path() .. '/extension/adapter/codelldb'
local NODE_DIR = require('mason-registry').get_package('node-debug2-adapter'):get_install_path() .. '/out/src/nodeDebug.js'
local codelldb_port = "1300" --rust debugger port

require("dapui").setup()

--dap python setup
--require('dap-python').setup('~/.virtualenvs/debugpy/Scripts/python') --directly pass path to a python venv that has debugpy installed
--windows, installed by mason
--~/AppData/Local/nvim-data/mason/packages/debugpy/venv/Scripts/python
--for linux:
--require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

--toggle breakpoint
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)

vim.api.nvim_set_keymap('n', '<F9>', [[:lua require"dap".continue()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F10>', [[:lua require"dap".step_over()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F11>', [[:lua require"dap".step_into()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F12>', [[:lua require"dap".step_out()<CR>]], { noremap = true })

--open dapui
vim.api.nvim_set_keymap('n', '<F5>', [[:lua require"dapui".toggle()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F6>', [[:lua require"dapui".eval()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F7>', [[:lua require"dap.ui.widgets".hover()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F7>', [[:lua require"dap.ui.variables".visual_hover()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F8>', [[:lua require"dap".repl.toggle()<CR>]], { noremap = true }) --toggle breakpoint

vim.api.nvim_set_keymap('n', '[s', [[:lua require"dap".up()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', ']s', [[:lua require"dap".down()<CR>]], { noremap = true })

--automatically open and close dapui
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

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  -- args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
  args = {NODE_DIR},
}

dap.adapters.firefox = {
    type = 'executable',
    command = 'node',
    --args = { os.getenv('HOME') .. '/AppData/Local/nvim-data/mason/bin/firefox-debug-adapter.cmd' },
    args = { os.getenv('HOME') .. '/AppData/Local/nvim-data/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js' },
    --args = { os.getenv('HOME') .. '/path/to/vscode-firefox-debug/dist/adapter.bundle.js' },
}

dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {os.getenv("HOME") .. "/AppData/Local/nvim-data/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js"} -- TODO adjust
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    -- type = 'node',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    -- type = 'node',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}
dap.configurations.svelte = dap.configurations.javascript
-- dap.configurations.javascript, typescript, typescriptreact, javascriptreact, svelte
-- firefox attach
-- dap.configurations.typescript = {
--     {
--         name = 'Debug with Firefox - Attach',
--         type = 'firefox',
--         request = 'attach',
--         reAttach = true,
--         host = "127.0.0.1",
--         port = 3000,
--         url = 'http://localhost:3000',
--         webRoot = '${workspaceFolder}',
--         --firefoxExecutable = '/usr/bin/firefox'
--         --firefoxExecutable = 'C:/Program Files/Mozilla Firefox/firefox.exe'
--     }
-- }
-- dap.configurations.svelte = dap.configurations.typescript

--firefox launch
-- dap.configurations.svelte =
-- {
--     {
--         type = 'firefox',
--         request = 'launch',
--         name = 'Firefox launch',
--         reAttach = true,
--         --reloadOnAttach = true,
--         port = 3000,
--         url = 'http://localhost:3000',
--         webRoot = '${workspaceFolder}',
--         --firefoxExecutable = '/usr/bin/firefox'
--         --firefoxExecutable = 'C:/Program Files/Mozilla Firefox/firefox.exe'
--     }
-- }


--chrome attach
-- dap.configurations.svelte = { -- change this to javascript if needed
--     {
--         name = "Chrome attach",
--         type = "chrome",
--         request = "attach",
--         --trace = true,
--         program = "${file}",
--         cwd = vim.fn.getcwd(),
--         sourceMaps = true,
--         protocol = "inspector",
--         port = 3000,
--         webRoot = "${workspaceFolder}"
--     }
-- }

--chrome launch
-- dap.configurations.svelte = { -- change this to javascript if needed
--     {
--         name = "Chrome attach",
--         type = "chrome",
--         request = "launch",
--         chromeExecutable = "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe",
--         args = {"--remote-debugging-port=9222"},
--         trace = true,
--         --program = "${file}",
--         --cwd = vim.fn.getcwd(),
--         sourceMaps = true,
--         --protocol = "inspector",
--         port = 9222,
--         webRoot = "${workspaceFolder}"
--     }
-- }

-- dap.configurations.typescriptreact = { -- change to typescript if needed
--     {
--         type = "chrome",
--         request = "attach",
--         program = "${file}",
--         cwd = vim.fn.getcwd(),
--         sourceMaps = true,
--         protocol = "inspector",
--         port = 9222,
--         webRoot = "${workspaceFolder}"
--     }
-- }

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
        --command = "C:/User/User/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb", -- windows, installed with mason
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



--manual rust setup lldb-VSCO. DIFFERENT THAN CODELLDB
-- dap.adapters.lldb = {
--     type = "executable",
--     --command = "/usr/bin/lldb-vscode", -- adjust as needed -- change to Mason installed path of lldb
--     --command = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/codelldb", -- UNIX, installed with mason
--     --command = os.getenv("HOME") .. "/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb", -- windows, installed with mason
--     --command = "C:/User/User/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb", -- windows, installed with mason
--     -- command = (function()
--     --         return os.getenv("HOME") ..
--     --             "/AppData/Local/nvim-data/mason/packages/codelldb/extension/lldb/bin/lldb"
--     --     end)(),
--
--     --windows, vsco intalled
--     command = (function()
--             return os.getenv("HOME") ..
--                 "/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/adapter/codelldb"
--         end)(),
--     --windows, vsco intalled
--     -- command = (function()
--     --         return os.getenv("HOME") ..
--     --             "/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/lldb/bin/lldb"
--     --     end)(),
--     name = "lldb",
-- }
--
-- local lldb = {
--     name = "Launch lldb",
--     type = "lldb",      -- matches the adapter
--     request = "launch", -- could also attach to a currently running process
--     program = function()
--         return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     cwd = "${workspaceFolder}",
--     stopOnEntry = false,
--     args = {},
--     --runInTerminal = false,
-- }

-- require('dap').configurations.rust = {
--     lldb -- different debuggers or more configurations can be used here
-- }