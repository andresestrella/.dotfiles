local masonOpts = {
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
}


return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		event = "BufReadPost",
		opts = masonOpts,
	},
}
