local nullConfig = function()
	local null_ls = require("null-ls")
	-- local ca = null_ls.builtins.code_actions
	-- local d = null_ls.builtins.diagnostics
	-- local f = null_ls.builtins.formatting

	local sources = {
		-- d.eslint,
		-- f.eslint,
		-- f.clang_format,
		-- d.eslint_d.with({ filetypes = { "svelte" } }),
		require("none-ls.diagnostics.eslint_d"),
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
	{ --lsp for non lsp
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		event = "BufReadPost",
		config = nullConfig,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		opts = {
			automatic_installation = true,
			ensure_installed = { "prettierd", "eslint_d" },
			automatic_setup = true,
			handlers = {},
		},
		event = "BufReadPost",
		dependencies = "williamboman/mason.nvim",
	},
	{ -- lsp file operations, like rename, move, etc
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-neo-tree/neo-tree.nvim",
			"nvim-lua/plenary.nvim",
		},
		lazy = false,
		config = function()
			require("lsp-file-operations").setup()
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

			--auto format on save
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
			vim.diagnostic.config({ virtual_text = true })

			lsp.on_attach(function(client, bufnr)
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
				-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, bufopts)
				-- vim.keymap.set("n,i", "<C-k>", function() vim.lsp.buf.signature_help() end, bufopts)
				vim.keymap.set("n", "<S-h>", function() vim.lsp.buf.hover() end, bufopts)

				vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, bufopts) --maps leader f to format code
				vim.keymap.set("n", "<leader>wa", function() vim.lsp.buf.add_workspace_folder() end,
					bufopts)
				vim.keymap.set("n", "<leader>wr", function() vim.lsp.buf.remove_workspace_folder() end,
					bufopts)
			end)

			lsp.setup()
		end,
	},
}
