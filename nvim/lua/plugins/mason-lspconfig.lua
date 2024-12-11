-- return {}
local handlers = {
	function(server_name) -- default automatic handlers (optional)
		require("lspconfig")[server_name].setup({})
	end,

	-- Next, you can provide targeted overrides for specific servers.
	[ "jdtls" ] = function() end,
	-- tsserver = function() end,
}

return {
	"williamboman/mason-lspconfig.nvim",
	-- opts = opts,
	event = "BufReadPost",
	dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "VonHeikemen/lsp-zero.nvim" },
	config = function()
		local lsp_zero = require("lsp-zero")
		-- require('mason').setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				-- "tsserver",
				-- "cssls",
				-- "cssmodules_ls",
				"docker_compose_language_service",
				"dockerls",
				"html",
				"jsonls",
				-- "marksman",
				-- "sqlls",
				-- "yamlls",
				-- "diagnosticls",
				-- "jedi_language_server",
				-- "tailwindcss",
				-- "lua_ls",
				-- "svelte",
				-- "jdtls",
			},
			-- handlers = handlers,
			handlers = {
				lsp_zero.default_setup,
				jdtls = lsp_zero.noop,

				clangd = function() -- custom handler for clangd, fix for "Multiple different client offset_encodings detected" error
					local cmp_nvim_lsp = require "cmp_nvim_lsp"

					require("lspconfig").clangd.setup {
					  on_attach = on_attach,
					  capabilities = cmp_nvim_lsp.default_capabilities(),
					  cmd = {
					    "clangd",
					    "--offset-encoding=utf-16",
					  },
					}
				end,
			},
		})
		-- require("mason-lspconfig").setup_handlers(handlers)
	end,
}
