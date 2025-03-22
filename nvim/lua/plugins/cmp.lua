return {
	{
		"hrsh7th/nvim-cmp",
		config = config,
		event = { "InsertEnter", "BufReadPost" },
		lazy = true,
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
						return
					end
					return 'make install_jsregexp'
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    https://github.com/rafamadriz/friendly-snippets
					{
						'rafamadriz/friendly-snippets',
						config = function()
							require('luasnip.loaders.from_vscode').lazy_load()
							require("luasnip.loaders.from_vscode").load({
								paths = { "~/.config/nvim/snippets/" },
							})
						end,
					},
				},
			},
			"saadparwaiz1/cmp_luasnip",

			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			'hrsh7th/cmp-nvim-lsp-signature-help',
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			"ray-x/cmp-treesitter",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			-- local cmp_tailwind = require("tailwindcss-colorizer-cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = 'menu,menuone,noinsert' },
				sources = {
					{ name = "nvim_lsp" },
					-- { name = "codeium" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "vsnip" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "buffer",                 keyword_length = 4 },
					-- { name = "crates" },
				},
				preselect = cmp.PreselectMode.Item,
				keyword_length = 2,
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				view = {
					entries = { name = "custom", selection_order = "near_cursor" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-5),
					["<C-f>"] = cmp.mapping.scroll_docs(5),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-q>"] = cmp.mapping.abort(),

					-- snippet movement
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					['<C-l>'] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { 'i', 's' }),
					['<C-h>'] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { 'i', 's' }),
				}),
				experimental = {
					native_menu = false,
					ghost_text = false,
				},
			})
		end
	},
}
