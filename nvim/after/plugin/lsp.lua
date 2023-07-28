local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(client, bufnr)
--comment this out to enable eslint
	-- if client.name == "eslint" then
	-- 	vim.cmd([[ LspStop eslint ]])
	-- 	return
	-- end

	local signs = {
		Error = " ",
		Warn = " ",
		Hint = "󰋗 ",
		Info = " ",
	}

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	lsp.default_keymaps({buffer = bufnr})
	local bufopts = { remap = false, noremap = true, silent = true, buffer = bufnr }
	-- go to definition
	vim.keymap.set("n", "gll", function()
		vim.lsp.diagnostic.show_line_diagnostics()
	end, bufopts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, bufopts)
	vim.keymap.set("n", "<leader>a", function()
		vim.lsp.buf.code_action()
	end, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	--rename all occurrences
	vim.keymap.set("n", "<leader>r", function()
		vim.lsp.buf.rename()
	end, bufopts)
	--show signature help
	vim.keymap.set("i", "<A-h>", function()
		vim.lsp.buf.signature_help()
	end, bufopts)

	--maps leader f to format code
	vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
end)

-- pylsp edit default config to ignore some annoying warnings
lsp.configure("pylsp", {
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = { "W391" },
					maxLineLength = 150,
					max_line_length = 160,
				},
			},
		},
	},
})
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
require("luasnip.loaders.from_vscode").lazy_load()
-- load snippets from path/of/your/nvim/config/my-cool-snippets
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-cool-snippets" } })

cmp.setup({
	sources = {
		{ name = "buffer" },
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
	mapping = {
		["C-n"] = cmp_action.luasnip_jump_forward(),
		["C-p"] = cmp_action.luasnip_jump_backward(),
		["<Tab>"] = cmp_action.luasnip_supertab(),
		["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
		-- ['<C-Space>'] = cmp.mapping.complete(), -- need to disable autocompletion for this to work
		--disable autocompletion for tab and shift-tab
		-- ["<Tab>"] = nil,
		-- ["<S-Tab>"] = nil,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
})

-- remaps to jump around snippet placeholders
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

local cmp_select = { behavior = cmp.SelectBehavior.Select }

--lets me use enter freely
lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	preselect = "none",
	completion = {
		completeopt = "menu,menuone,noinsert,noselect",
	},
})

-- allow html snippets in htmldjango files
-- require("luasnip").filetype_extend("htmldjango", { "html" })

-- show diagnostics in virtual text
vim.diagnostic.config({
	virtual_text = true,
})

local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})
null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)
	end,
	sources = {
		-- null_ls.builtins.formatting.prettier,
		-- null_ls.builtins.diagnostics.eslint,
		-- null_ls.builtins.formatting.stylua,
		-- You can add tools not supported by mason.nvim
	},
})

-- See mason-null-ls.nvim's documentation for more details:
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
require("mason-null-ls").setup({
	ensure_installed = {"prettier", "eslint"},
	automatic_installation = true, -- You can still set this to `true`
	automatic_setup = true,
})


-- specifying to use null-ls for formatting
local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- run formatting on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end
