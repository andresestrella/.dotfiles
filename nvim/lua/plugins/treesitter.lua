-- set html files to filetype htmldjango
-- vim.cmd [[autocmd BufNewFile,BufRead *.html set filetype=htmldjango]]
return { --parse tree, syntax highlighting, folds, and more
	"nvim-treesitter/nvim-treesitter",
	event = "BufRead",
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })
		-- require("nvim-treesitter.install").compilers = { "zig" }
		require("nvim-treesitter.install").prefer_git = true
	end or ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = {},
		},
	},
	config = function()
		-- require("nvim-treesitter.install").compilers = { "zig" }
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all"
			ensure_installed = { "javascript", "lua" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,
			autotag = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},

			-- ignore_install = { "javascript", "typescript" }, -- List of parsers to ignore installing

			highlight = {
				-- `false` will disable the whole extension
				enable = true,
				extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
				disable = {}, -- list of language that will be disabled

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},

			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { "BufWrite", "CursorHold" },
			},

			indent = {
				enable = true,
				disable = {},
			},
		})
	end,
}
