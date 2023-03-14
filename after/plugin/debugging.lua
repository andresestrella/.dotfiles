require("mason").setup()
require("mason-nvim-dap").setup({
    ensure_installed = { "python", "firefox", "javadb", "javatest", "js", "codelldb" },
    automatic_setup = true,
    automatic_installation = true,
})
--require 'mason-nvim-dap'.setup_handlers {}
--require('mason-nvim-dap').setup_handlers()
require("nvim-dap-virtual-text").setup()

local dap = require('dap')
-- require 'mason-nvim-dap'.setup_handlers {
--     function(source_name)
--         -- all sources with no handler get passed here
--
--
--         -- Keep original functionality of `automatic_setup = true`
--         require('mason-nvim-dap.automatic_setup')(source_name)
--     end,
--     python = function(source_name)
--         dap.adapters.python = {
--             type = "executable",
--             command = "python",
--             --command = "/usr.local/bin/python3",
--             --command = "python3",
--             args = { "-m", "debugpy.adapter", },
--         }
--
--         dap.configurations.python = {
--             {
--                 type = "python",
--                 request = "launch",
--                 name = "Launch file",
--                 program = "${file}", -- This configuration will launch the current file if used.
--                 pythonPath = function()
--                     -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
--                     -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
--                     -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
-- local cwd = vim.fn.getcwd()
-- if vim.fn.executable(cwd .. '/venv/Scripts/python') == 1 then
--     return cwd .. '/venv/Scripts/python'
-- elseif vim.fn.executable(cwd .. '/.venv/Scripts/python') == 1 then
--     return cwd .. '/.venv/Scripts/python'
-- elseif vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
--     return cwd .. '/venv/bin/python'
-- elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
--     return cwd .. '/.venv/bin/python'
-- else
--     return '/usr/bin/python'
-- end
--                 end,
--             },
--         }
--     end,
--
--     rust = function(source_name)
--         dap.adapters.lldb = {
--             type = 'executable',
--             --command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
--             --command = os.getenv("HOME") .. "/" .. ".local/share/nvim/mason/bin/codelldb", -- UNIX, installed with mason
--             --command = os.getenv("HOME") .. "/" .. "AppData/Local/nvim-data/mason/packages/codelldb", -- windows, installed with mason
--             --command = os.getenv("HOME") .. "/" .. "AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb",                                -- windows, installed with mason
--             command = os.getenv("HOME") .. "/" .. "AppData/Local/nvim-data/mason/packages/codelldb/extension/lldb/bin/lldb", -- windows, installed with mason
--             name = 'lldb'
--         }
--         dap.configurations.rust = {
--             {
--                 name = "Launch",
--                 type = "codelldb",
--                 request = "launch",
--                 program = function()
--                     return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--                 end,
--                 cwd = "${workspaceFolder}",
--                 stopOnEntry = false,
--                 args = function()
--                     local input = vim.fn.input("Input args: ")
--                     return vim.fn.split(input, " ", true)
--                 end,
--                 -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
--                 --
--                 --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
--                 --
--                 -- Otherwise you might get the following error:
--                 --
--                 --    Error on launch: Failed to attach to the target process
--                 --
--                 -- But you should be aware of the implications:
--                 -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
--                 runInTerminal = false,
--             },
--         }
--     end,
-- }

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
vim.api.nvim_set_keymap('n', '<F8>', [[:lua require"dap".repl.toggle()<CR>]], { noremap = true }) --toggle breakpoint
-- vim.api.nvim_set_keymap('n', '<F5>', [[:lua require"osv".launch({port = 8086})<CR>]], { noremap = true })

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


--python manual setup
dap.adapters.python = {
    type = 'executable',
    command = 'python',
    args = { '-m', 'debugpy.adapter' },
}

local dap = require('dap')
dap.configurations.python = {
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
                return '/usr/bin/python'
            end
        end,
    },
}



local codelldb_port = "1300"
dap.adapters.codelldb = {
    type = "server",
    port = codelldb_port,
    --port = "${port}",
    executable = {
        --command = os.getenv("HOME"), "/.local/share/nvim/mason/bin/codelldb", -- installed with mason
        --command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
        -- command = (function()
        --         return os.getenv("HOME") ..
        --             "/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/adapter/codelldb" -- windows, vscode
        --     end)(),
        -- command = (function()
        --         return os.getenv("HOME") ..
        --             "/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/lldb/bin/lldb" -- windows, vscode
        --     end)(),
        command = os.getenv("HOME") .. "/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb", -- windows, installed with mason
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

--official
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

