-- return {}
local handlers = {
	function(server_name) -- default automatic handlers (optional)
		require("lspconfig")[server_name].setup({})
	end,

	-- Next, you can provide targeted overrides for specific servers.
	jdtls = function() end,
	-- tsserver = function() end,
	-- rust_analyzer = function() end,
	-- gopls = function() end,
}

return {
	"williamboman/mason-lspconfig.nvim",
	-- opts = opts,
	event = "BufReadPre",
	dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"tsserver",
				"cssls",
				"cssmodules_ls",
				-- "diagnosticls",
				"docker_compose_language_service",
				"dockerls",
				"html",
				"jedi_language_server",
				"jsonls",
				"lua_ls",
				"marksman",
				"powershell_es",
				"sqlls",
				"tailwindcss",
				"tsserver",
				"yamlls",
				"svelte",
				"jdtls",
			},
			automatic_installation = false,
			handlers = handlers,
		})
		-- require("mason-lspconfig").setup_handlers(handlers)
	end,
}
