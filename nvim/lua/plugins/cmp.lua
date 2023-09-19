-- local source_mapping = {
-- 	nvim_lsp = "[LSP]",
-- 	nvim_lua = "[LUA]",
-- 	luasnip = "[SNIP]",
-- 	buffer = "[BUF]",
-- 	path = "[PATH]",
-- 	treesitter = "[TREE]",
-- cmp_ai = "[AI]",
-- }

local config = function()
	local cmp = require("cmp")
	local cmp_action = require("lsp-zero").cmp_action()
	local lspkind = require("lspkind")
	local luasnip = require("luasnip")
	local cmp_tailwind = require("tailwindcss-colorizer-cmp")
	-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	-- local cmp_is_enabled = require("util.cmp").cmp_is_enabled
	-- local cmp_ai = require("cmp_ai.config")
	-- require("luasnip.loaders.from_vscode").lazy_load()
	-- load snippets from path/of/your/nvim/config/my-cool-snippets
	-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-cool-snippets" } })

	cmp.setup({
		sources = {
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "luasnip" },
			{ name = "buffer", keyword_length = 4 },
			{ name = "crates" },
		},
		enabled = true,
		preselect = cmp.PreselectMode.Item,
		-- keyword_length = 2,
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		view = {
			entries = { name = "custom", selection_order = "near_cursor" },
		},
		mapping = cmp.mapping.preset.insert({
			["C-n"] = cmp_action.luasnip_jump_forward(),
			["C-p"] = cmp_action.luasnip_jump_backward(),
			["<C-b>"] = cmp.mapping.scroll_docs(-5),
			["<C-f>"] = cmp.mapping.scroll_docs(5),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-q>"] = cmp.mapping.abort(),
			["<C-x>"] = cmp.mapping(
				cmp.mapping.complete({
					config = {
						sources = cmp.config.sources({
							{ name = "cmp_ai" },
						}),
					},
				}),
				{ "i" }
			),
		}),
		-- sources = cmp.config.sources({
		-- 	{
		-- 		name = "luasnip",
		-- 		group_index = 1,
		-- 		option = { use_show_condition = true },
		-- 		entry_filter = function()
		-- 			local context = require("cmp.config.context")
		-- 			return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
		-- 		end,
		-- 	},
		-- 	{
		-- 		name = "nvim_lsp",
		-- 		group_index = 2,
		-- 	},
		-- 	{
		-- 		name = "codeium",
		-- 		group_index = 2,
		-- 	},
		-- 	{
		-- 		name = "nvim_lua",
		-- 		group_index = 3,
		-- 	},
		-- 	{
		-- 		name = "crates",
		-- 		group_index = 3,
		-- 	},
		-- 	{
		-- 		name = "treesitter",
		-- 		keyword_length = 4,
		-- 		group_index = 4,
		-- 	},
		-- 	{
		-- 		name = "path",
		-- 		keyword_length = 4,
		-- 		group_index = 4,
		-- 	},
		-- 	{
		-- 		name = "buffer",
		-- 		keyword_length = 3,
		-- 		group_index = 5,
		-- 		option = {
		-- 			get_bufnrs = function()
		-- 				local bufs = {}
		-- 				for _, win in ipairs(vim.api.nvim_list_wins()) do
		-- 					bufs[vim.api.nvim_win_get_buf(win)] = true
		-- 				end
		-- 				return vim.tbl_keys(bufs)
		-- 			end,
		-- 		},
		-- 	},
		-- 	{
		-- 		name = "emoji",
		-- 		keyword_length = 2,
		-- 		group_index = 6,
		-- 	},
		-- 	{
		-- 		name = "nerdfont",
		-- 		keyword_length = 2,
		-- 		group_index = 6,
		-- 	},
		-- }),
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				-- maxwidth = 50,
				ellipsis_char = "...",
				before = function(entry, vim_item)
					cmp_tailwind.formatter(entry, vim_item)
					return vim_item
				end,
				-- menu = source_mapping,
			}),
		},
		sorting = {
			priority_weight = 2,
			comparators = {
				-- require("cmp_ai.compare"),
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				-- require("clangd_extensions.cmp_scores"),
				cmp.config.compare.locality,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
		experimental = {
			native_menu = false,
			ghost_text = false,
		},
	})

	-- remaps to jump around snippet placeholders
	local keymap = vim.api.nvim_set_keymap
	local opts = { noremap = true, silent = true }
	keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
	keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
	keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
	keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

	local cmp_select = { behavior = cmp.SelectBehavior.Select }

	--@diagnostic disable-next-line: undefined-field
	-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

	-- require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
	-- 	sources = {
	-- 		{ name = "dap" },
	-- 	},
	-- })

	-- cmp_ai:setup({
	-- 	max_lines = 1000,
	-- 	provider = "OpenAI",
	-- 	model = "gpt-3.5-turbo",
	-- 	notify = true,
	-- 	notify_callback = function(msg)
	-- 		require("notify").notify(msg, vim.log.levels.INFO, {
	-- 			title = "OpenAI",
	-- 			render = "compact",
	-- 		})
	-- 	end,
	-- 	run_on_every_keystroke = true,
	-- 	ignored_file_types = {},
	-- })
end

return {
	{
		"hrsh7th/nvim-cmp",
		config = config,
		event = { "InsertEnter", "BufReadPre" },
		dependencies = {
			-- "jiangmiao/auto-pairs", --auto pairs
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip", -- Snippet engine
			"roobert/tailwindcss-colorizer-cmp.nvim",
			{
				"rafamadriz/friendly-snippets",
				-- dependencies = "L3MON4D3/LuaSnip",
				lazy = true,
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").load({ paths = { "~/.config/nvim/snippets/" } })
				end,
				after = "nvim-cmp",
			},
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			"ray-x/cmp-treesitter",
			"saadparwaiz1/cmp_luasnip",
			-- "hrsh7th/cmp-emoji",
			-- "chrisgrieser/cmp-nerdfont",
			-- {
			-- "tzachar/cmp-ai",
			-- dependencies = "nvim-lua/plenary.nvim",
			-- },
			-- "jcdickinson/codeium.nvim",
			dependencies = {},
		},
	},
}
