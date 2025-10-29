-- zirebaum's copilot config
local opts = {
	panel = {
		enabled = true,
		auto_refresh = false,
		keymap = {
			jump_prev = "[[",
			jump_next = "]]",
			accept = "<CR>",
			refresh = "gr",
			open = "<M-a>",
		},
		layout = {
			position = "bottom", -- | top | left | right
			ratio = 0.4,
		},
	},
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 75,
		keymap = {
			accept = "<Tab>",
			accept_word = false,
			accept_line = "<M-l",
			next = "<M-n>",
			prev = "<M-p>",
			dismiss = "<M-e>",
		},
	},
	filetypes = {
		yaml = false,
		markdown = false,
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		["."] = false,
	},
	copilot_node_command = "node", -- Node.js version must be > 16.x
	server_opts_overrides = {},
}

return {
	-- inline AI completion suggestions
	--use("github/copilot.vim")
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = opts,
	},
	{
		"folke/sidekick.nvim",
		opts = {
			-- add any options here
			cli = {
				mux = {
					backend = "tmux", -- tmux / zellij
					enabled = true,
				},
			},
		},
		keys = {
			{
				"<tab>",
				function()
					-- if there is a next edit, jump to it, otherwise apply it if any
					if not require("sidekick").nes_jump_or_apply() then
						return "<Tab>" -- fallback to normal tab
					end
				end,
				expr = true,
				desc = "Goto/Apply Next Edit Suggestion",
			},
			{
				"<c-.>",
				function()
					require("sidekick.cli").focus()
				end,
				mode = { "n", "x", "i", "t" },
				desc = "Sidekick Switch Focus",
			},
			{
				"<leader>aa",
				function()
					require("sidekick.cli").toggle({ focus = true })
				end,
				desc = "Sidekick Toggle CLI",
				mode = { "n", "v" },
			},
			{
				"<leader>as",
				function() require("sidekick.cli").select() end,
				-- Or to select only installed tools:
				-- require("sidekick.cli").select({ filter = { installed = true } })
				desc = "Select CLI",
			},
			{
				"<leader>ad",
				function() require("sidekick.cli").close() end,
				desc = "Detach a CLI Session",
			},
			{
				"<leader>at",
				function() require("sidekick.cli").send({ msg = "{this}" }) end,
				mode = { "x", "n" },
				desc = "Send This",
			},
			{
				"<leader>af",
				function() require("sidekick.cli").send({ msg = "{file}" }) end,
				desc = "Send File",
			},
			{
				"<leader>av",
				function() require("sidekick.cli").send({ msg = "{selection}" }) end,
				mode = { "x" },
				desc = "Send Visual Selection",
			},
			{
				"<leader>ap",
				function() require("sidekick.cli").prompt() end,
				mode = { "n", "x" },
				desc = "Sidekick Select Prompt",
			},
			{
				"<leader>ag",
				function()
					require("sidekick.cli").toggle({ name = "gemini", focus = true })
				end,
				desc = "Sidekick Gemini Toggle",
				mode = { "n", "v" },
			},
			{
				"<leader>aq",
				function()
					require("sidekick.cli").toggle({ name = "qwen", focus = true })
				end,
				desc = "Sidekick Qwen Toggle",
				mode = { "n", "v" },
			},
		},
	},
}
