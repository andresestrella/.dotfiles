return {
	{
		'saghen/blink.compat',
		-- use v2.* for blink.cmp v1.*
		version = '2.*',
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {},
	},
	{
		'saghen/blink.cmp',
		event = { 'VeryLazy' },
		dependencies = {
			'rafamadriz/friendly-snippets',
			-- 'Kaiser-Yang/blink-cmp-avante'
		},
		version = '*',
		opts = {
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = 'default',
				-- ['<C-h>'] = { 'show_signature', 'hide_signature' }, -- I think doesn't work bc documentation autoshow is set to true.
				['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
				['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
			},
			appearance = { nerd_font_variant = 'mono' },

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = true } },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			-- sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
			-- fuzzy = { implementation = "prefer_rust_with_warning" }
			fuzzy = { implementation = "prefer_rust" },
			sources = {
				default = { 'avante_commands', 'avante_mentions', 'avante_files', 'lsp', 'path', 'snippets', 'buffer' },
				-- custom providers for avante AI plugin
				providers = {
					avante_commands = {
						name = "avante_commands",
						module = "blink.compat.source",
						score_offset = 90, -- show at a higher priority than lsp
						opts = {},
					},
					avante_files = {
						name = "avante_files",
						module = "blink.compat.source",
						score_offset = 100, -- show at a higher priority than lsp
						opts = {},
					},
					avante_mentions = {
						name = "avante_mentions",
						module = "blink.compat.source",
						score_offset = 1000, -- show at a higher priority than lsp
						opts = {},
					}
				}
			},

		},
		opts_extend = { "sources.default" }
	}
}
