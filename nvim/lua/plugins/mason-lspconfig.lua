-- return {}
local handlers = {
	function(server_name) -- default automatic handlers (optional)
		require("lspconfig")[server_name].setup({})
	end,

	-- Next, you can provide targeted overrides for specific servers.
	[ "jdtls" ] = function() end,
	-- tsserver = function() end,
	-- rust_analyzer = function() end,
	-- gopls = function() end,
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
				"tsserver",
				"cssls",
				"cssmodules_ls",
				-- "diagnosticls",
				"docker_compose_language_service",
				"dockerls",
				"html",
				"jsonls",
				"marksman",
				"powershell_es",
				"sqlls",
				"yamlls",
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
			},
		})
		-- require("mason-lspconfig").setup_handlers(handlers)
	end,
}
