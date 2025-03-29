return {
	{
		'saghen/blink.cmp',
		event = { 'VeryLazy' },
		dependencies = { 'rafamadriz/friendly-snippets' },
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
			sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
			-- fuzzy = { implementation = "prefer_rust_with_warning" }
			fuzzy = { implementation = "prefer_rust" }
		},
		opts_extend = { "sources.default" }
	}
}
