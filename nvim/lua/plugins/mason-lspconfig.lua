local opts = {
	ensure_installed = {
		"cssls",
		"cssmodules_ls",
		"diagnosticls",
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
	},
	automatic_installation = true,
}

return {
	"williamboman/mason-lspconfig.nvim",
	opts = opts,
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
}