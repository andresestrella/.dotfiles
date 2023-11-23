-- specifying to use null-ls for formatting
-- local lsp_formatting = function(bufnr)
-- 	vim.lsp.buf.format({
-- 		filter = function(client)
-- 			-- apply whatever logic you want (in this example, we'll only use null-ls)
-- 			return client.name == "null-ls"
-- 		end,
-- 		bufnr = bufnr,
-- 	})
-- end
--
-- if I use eslint-lsp, I can use this
-- require("lspconfig").eslint.setup({
-- 	-...
-- 	on_attach = function(client, bufnr)
-- 		vim.api.nvim_create_autocmd("BufWritePre", {
-- 			buffer = bufnr,
-- 			command = "EslintFixAll",
-- 		})
-- 	end,
-- })

local kindConfig = function()
	require("lspkind").init({
		mode = "symbol_text",
		preset = "default",
		symbol_map = {
			Copilot = "",
			Codeium = "",
		},
	})
end

local masonNullOpts = {
	automatic_installation = true,
	ensure_installed = { "prettier", "eslint_d" },
	automatic_setup = true,
	handlers = {},
}

local cratesOpts = {
	null_ls = {
		enabled = true,
		name = "crates.nvim",
	},
}

local nullConfig = function()
	local null_ls = require("null-ls")
	local ca = null_ls.builtins.code_actions
	local d = null_ls.builtins.diagnostics
	local f = null_ls.builtins.formatting

	local sources = {
		-- d.eslint,
		-- f.eslint,
		d.eslint_d.with({ filetypes = { "svelte" } }), -- looks like this works how I inteded... instead of extra_filetypes...
		-- f.eslint_d.with({ extre_filetypes = { "svelte" } }),
		-- a.eslint_d,
		-- f.prettier,
		-- f.prettierd.with({ filetypes = { "css", "scss", "less", "html", "json", "yaml", "markdown", "graphql", } }),
		-- f.stylua,
		-- You can add tools not supported by mason.nvim
	}

	null_ls.setup({
		sources = sources,
		should_attach = function(bufnr)
			return not vim.api.nvim_buf_get_name(bufnr):match(".env$")
		end,
		on_init = function(new_client, _)
			new_client.offset_encoding = "utf-16"
		end,
		temp_dir = "/tmp",
	})
end

return {
	{ -- lsp icons"
		"onsails/lspkind-nvim",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = kindConfig,
	},
	{ --lsp for non lsp
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		config = nullConfig,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		opts = masonNullOpts,
		event = "BufReadPre",
		dependencies = "williamboman/mason.nvim",
	},
	{
		"saecki/crates.nvim",
		tag = "v0.4.0",
		ft = { "toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufRead Cargo.toml" },
		opts = cratesOpts,
		config = function()
			local crates = require("crates")
			crates.setup({
				src = {
					cmp = {
						enabled = true,
					},
				},
			})

			local opts = { silent = true }
			--keymaps
			vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
			vim.keymap.set("n", "<leader>cr", crates.reload, opts)

			vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
			vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
			vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)

			vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
			vim.keymap.set("v", "<leader>cu", crates.update_crates, opts)
			vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts)
			vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts)
			vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, opts)
			vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, opts)

			vim.keymap.set("n", "<leader>ce", crates.expand_plain_crate_to_inline_table, opts)
			vim.keymap.set("n", "<leader>cE", crates.extract_crate_into_table, opts)

			vim.keymap.set("n", "<leader>cH", crates.open_homepage, opts)
			vim.keymap.set("n", "<leader>cR", crates.open_repository, opts)
			vim.keymap.set("n", "<leader>cD", crates.open_documentation, opts)
			vim.keymap.set("n", "<leader>cC", crates.open_crates_io, opts)
		end,
	},
	{ --lsp all in one
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{
				"neovim/nvim-lspconfig",
				after = "LuaSnip",
			},
			-- { "williamboman/mason.nvim" },
			-- { "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			-- { "hrsh7th/nvim-cmp", event = "InsertEnter", after = "nvim-lspconfig" },
			-- { "hrsh7th/cmp-path" },
			-- { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			-- { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
			-- { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			-- { "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			-- {
			-- 	"L3MON4D3/LuaSnip",
			-- 	event = "CursorMoved",
			-- },
			-- { "rafamadriz/friendly-snippets", after = "nvim-cmp" },
		},
		-- dependencies = {
		-- 	-- LSP Support
		-- 	"neovim/nvim-lspconfig",
		-- 	"williamboman/mason.nvim",
		-- },
		config = function()
			local lsp = require("lsp-zero").preset({})

			lsp.omnifunc.setup({
				trigger = "<C-Space>",
				use_fallback = true,
				update_on_delete = true,
			})

			local signs = {
				Error = " ",
				Warn = "",
				Hint = "󰋗 ",
				Info = " ",
			}

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			--format on save
			-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

			-- pylsp edit default config to ignore some annoying warnings
			-- lsp.configure("pylsp", {
			-- 	settings = {
			-- 		pylsp = {
			-- 			plugins = {
			-- 				pycodestyle = {
			-- 					ignore = { "W391" },
			-- 					maxLineLength = 150,
			-- 					max_line_length = 160,
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- })

			-- require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
			-- require("lspconfig").svelte.setup({
			-- 	on_attach = lsp.on_attach,
			-- 	cmd = { "svelteserver", "--stdio" },
			-- 	-- uncomment this if I want the svelte LSP to run on .js and .ts files as well
			-- 	-- filetypes = { "svelte", "html", "javascript", "typescript", "css" },
			-- 	settings = { svelte = { plugin = { html = { completions = { enable = true, emmet = true } } } } },
			-- })

			-- load snippets from path/of/your/nvim/config/my-cool-snippets
			-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-cool-snippets" } })

			-- allow html snippets in htmldjango files
			-- require("luasnip").filetype_extend("htmldjango", { "html" })

			-- show diagnostics in virtual text
			vim.diagnostic.config({
				virtual_text = true,
			})

			lsp.on_attach(function(client, bufnr)
				--comment this out to enable eslint
				-- if client.name == "eslint" then
				-- 	vim.cmd([[ LspStop eslint ]])
				-- 	return
				-- end
				-- if client.name ==

				--keymaps
				lsp.default_keymaps({ buffer = bufnr })

				local bufopts = { remap = false, noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "<leader>ws", function()
					vim.lsp.buf.workspace_symbol()
				end, bufopts)
				vim.keymap.set("n", "<leader>a", function()
					vim.lsp.buf.code_action()
				end, bufopts)
				vim.keymap.set("v", "<leader>a", function()
					vim.lsp.buf.code_action()
				end, bufopts)
				-- vim.keymap.set("v,n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				--rename all occurrences
				vim.keymap.set("n", "<leader>r", function()
					vim.lsp.buf.rename()
				end, bufopts)
				--show signature help
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, bufopts)
				-- vim.keymap.set("n,i", "<C-k>", function() vim.lsp.buf.signature_help() end, bufopts)
				vim.keymap.set("n", "<leader>f", function()
					vim.lsp.buf.format()
				end, bufopts) --maps leader f to format code
				vim.keymap.set("n", "<leader>wa", function()
					vim.lsp.buf.add_workspace_folder()
				end, bufopts)
				vim.keymap.set("n", "<leader>wr", function()
					vim.lsp.buf.remove_workspace_folder()
				end, bufopts)
			end)

			lsp.setup()
		end,
	},
}
