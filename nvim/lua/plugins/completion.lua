-- this plugin is meant to replace nvim-cmp
-- much less configs and faster
-- however I tested it and was not happy with signature and documentation display. it didn't work correctly

return {}
-- return {
-- 	'saghen/blink.cmp',
-- 	event = { 'LspAttach' },
-- 	dependencies = 'rafamadriz/friendly-snippets',
-- 	version = '*',

-- 	---@module 'blink.cmp'
-- 	---@type blink.cmp.Config
-- 	opts = {
-- 		keymap = {
-- 			preset = 'default', --default, none, super-tab, enter
-- 			-- ['<C-k>'] = { 'select_prev', 'fallback' },
-- 			-- ['<C-j>'] = { 'select_next', 'fallback' },
-- 			-- ['<C-h>'] = { 'show_signature', 'hide_signature' },
-- 		},
-- 		signature = {
-- 			enabled = true,
-- 			window = { border = 'single' },
-- 		},
-- 		-- documentation = { auto_show = true, auto_show_delay_ms = 500 },
-- 		appearance = {
-- 			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
-- 			-- Useful for when your theme doesn't support blink.cmp
-- 			-- Will be removed in a future release
-- 			use_nvim_cmp_as_default = true,
-- 			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
-- 			-- Adjusts spacing to ensure icons are aligned
-- 			nerd_font_variant = 'mono'
-- 		},

-- 		-- Default list of enabled providers defined so that you can extend it
-- 		-- elsewhere in your config, without redefining it, due to `opts_extend`
-- 		sources = {
-- 			default = { 'lsp', 'path', 'snippets', 'buffer' },
-- 		},
-- 	},
-- 	opts_extend = { "sources.default" }
-- }
--
--
-- copied this next config from reddit:
-- return {
--     "saghen/blink.cmp",
--     dependencies = {
--         "rafamadriz/friendly-snippets",
--         "onsails/lspkind.nvim",
--     },
--     version = "*",

--     ---@module 'blink.cmp'
--     ---@type blink.cmp.Config
--     opts = {

--         appearance = {
--             use_nvim_cmp_as_default = false,
--             nerd_font_variant = "mono",
--         },

--         completion = {
--             accept = { auto_brackets = { enabled = true } },

--             documentation = {
--                 auto_show = true,
--                 auto_show_delay_ms = 250,
--                 treesitter_highlighting = true,
--                 window = { border = "rounded" },
--             },

--             list = {
--                 selection = function(ctx)
--                     return ctx.mode == "cmdline" and "auto_insert" or "preselect"
--                 end,
--             },

--             menu = {
--                 border = "rounded",

--                 cmdline_position = function()
--                     if vim.g.ui_cmdline_pos ~= nil then
--                         local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
--                         return { pos[1] - 1, pos[2] }
--                     end
--                     local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
--                     return { vim.o.lines - height, 0 }
--                 end,

--                 draw = {
--                     columns = {
--                         { "kind_icon", "label", gap = 1 },
--                         { "kind" },
--                     },
--                     components = {
--                         kind_icon = {
--                             text = function(item)
--                                 local kind = require("lspkind").symbol_map[item.kind] or ""
--                                 return kind .. " "
--                             end,
--                             highlight = "CmpItemKind",
--                         },
--                         label = {
--                             text = function(item)
--                                 return item.label
--                             end,
--                             highlight = "CmpItemAbbr",
--                         },
--                         kind = {
--                             text = function(item)
--                                 return item.kind
--                             end,
--                             highlight = "CmpItemKind",
--                         },
--                     },
--                 },
--             },
--         },

--         -- My super-TAB configuration
--         keymap = {
--             ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
--             ["<C-e>"] = { "hide", "fallback" },
--             ["<CR>"] = { "accept", "fallback" },

--             ["<Tab>"] = {
--                 function(cmp)
--                     return cmp.select_next()
--                 end,
--                 "snippet_forward",
--                 "fallback",
--             },
--             ["<S-Tab>"] = {
--                 function(cmp)
--                     return cmp.select_prev()
--                 end,
--                 "snippet_backward",
--                 "fallback",
--             },

--             ["<Up>"] = { "select_prev", "fallback" },
--             ["<Down>"] = { "select_next", "fallback" },
--             ["<C-p>"] = { "select_prev", "fallback" },
--             ["<C-n>"] = { "select_next", "fallback" },
--             ["<C-up>"] = { "scroll_documentation_up", "fallback" },
--             ["<C-down>"] = { "scroll_documentation_down", "fallback" },
--         },

--         -- Experimental signature help support
--         signature = {
--             enabled = true,
--             window = { border = "rounded" },
--         },

--         sources = {
--             default = { "lsp", "path", "snippets", "buffer" },
--             cmdline = {}, -- Disable sources for command-line mode
--             providers = {
--                 lsp = {
--                     min_keyword_length = 2, -- Number of characters to trigger porvider
--                     score_offset = 0, -- Boost/penalize the score of the items
--                 },
--                 path = {
--                     min_keyword_length = 0,
--                 },
--                 snippets = {
--                     min_keyword_length = 2,
--                 },
--                 buffer = {
--                     min_keyword_length = 5,
--                     max_items = 5,
--                 },
--             },
--         },
--     },
-- }

