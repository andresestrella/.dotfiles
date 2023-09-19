--this is now done on lazy.lua
--catppuccin = "catppuccin-mocha"
--catppuccin = "catppuccin-macchiato"
--vim.cmd.colorscheme(catppuccin)
--vim.g.gruvbox_material_background = "medium" -- hard, medium, soft, none
--vim.cmd.colorscheme("gruvbox-material")
return {
	{ -- theme
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "medium" -- hard, medium, soft, none
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{ --theme
		"catppuccin/nvim",
		name = "catppuccin",
	},
}
