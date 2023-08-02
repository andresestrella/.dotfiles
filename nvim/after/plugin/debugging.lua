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
-- local NODE_DIR = require('mason-registry').get_package('node-debug2-adapter'):get_install_path() .. '/out/src/nodeDebug.js'
local VSCODE_JS_DIR = require('mason-registry').get_package('js-debug-adapter'):get_install_path() .. '/js-debug'
local codelldb_port = "1300" --rust debugger port

require("dapui").setup()

--dap python setup
--require('dap-python').setup('~/.virtualenvs/debugpy/Scripts/python') --directly pass path to a python venv that has debugpy installed
--windows, installed by mason
--~/AppData/Local/nvim-data/mason/packages/debugpy/venv/Scripts/python
--for linux:
--require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')



--automatically open and close dapui
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--     dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--     dapui.close()
-- end

require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = VSCODE_JS_DIR, -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

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
      processId = require 'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Start Chrome with \"localhost\"",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
    }
  }
end



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


-- keymaps
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end) --toggle breakpoint
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

vim.api.nvim_set_keymap('n', '[s', [[:lua require"dap".up()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', ']s', [[:lua require"dap".down()<CR>]], { noremap = true })

-- more keymaps
vim.api.nvim_set_keymap('n', '<Leader>dr', [[:lua require"dap".repl.toggle()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>db', [[:lua require"dapui".float_element("breakpoints", {width = 130, height = 40, position = "center", enter = true})<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>dw', [[:lua require"dapui".float_element('watches', {width = 130, height = 40, position = "center", enter = true})<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>ds', [[:lua require"dapui".float_element('scopes', {width = 130, height = 40, position = "center", enter = true})<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>dt', [[:lua require"dapui".float_element('stacks', {width = 130, height = 40, position = "center", enter = true})<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>db', [[:lua require"dapui".float_element("breakpoints", {position = "nil", enter = true})<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>dw', [[:lua require"dapui".float_element('watches', {position = "nil", enter = true})<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>ds', [[:lua require"dapui".float_element('scopes', {position = "nil", enter = true})<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>dt', [[:lua require"dapui".float_element('stacks', {position = "nil", enter = true})<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>dc', [[:lua require"dap".continue()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>dk', [[:lua require"dap".step_out()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>dl', [[:lua require"dap".step_into()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>dj', [[:lua require"dap".step_over()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dh', [[:lua require'dapui'.eval()<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dh', [[:lua require'dap.ui.widgets'.cursor_float(require'dap.ui.widgets'.expression, {height=50, width=50})<CR>]], { noremap = true })
-- couldn't get this to work. don't know how to pass in the height and width correctly.
-- vim.api.nvim_set_keymap('n', '<leader>ds', [[:lua require'dap.ui.widgets'.centered_float(require'dap.ui.widgets'.scopes)<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>da', [[:lua require'dap'.attach()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>du', [[:lua require'dapui'.toggle()<CR>]], { noremap = true })


----------------------------------
-- dap.adapters.node2 = {
--   type = 'executable',
--   command = 'node',
--   -- args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
--   args = {NODE_DIR},
-- }
--
-- dap.configurations.javascript = {
--   {
--     name = 'Launch',
--     type = 'node2',
--     -- type = 'node',
--     request = 'launch',
--     program = '${file}',
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = 'inspector',
--     console = 'integratedTerminal',
--     -- runtimeArgs = { '--inspect',  }
--   },
--   {
--     -- For this to work you need to make sure the node process is started with the `--inspect` flag.
--     name = 'Attach to process',
--     type = 'node2',
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = 'inspector',
--     skipFiles = {'<node_internals>/**/*.js'},
--     -- type = 'node',
--     request = 'attach',
--     processId = require'dap.utils'.pick_process,
--   },
-- }
-- dap.configurations.svelte = dap.configurations.javascript
-- dap.configurations.javascript, typescript, typescriptreact, javascriptreact, svelte
