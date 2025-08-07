return {
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard" -- hard, medium, soft, none
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	-- { -- lua/plugins/rose-pine.lua
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	config = function()
	-- 		vim.cmd("colorscheme rose-pine")
	-- 	end
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- },
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	-- lazy= false,
	-- 	config = function()
	-- 		vim.cmd("colorscheme kanagawa")
	-- 		-- vim.cmd("colorscheme kanagawa-dragon")
	-- 		-- vim.cmd("colorscheme kanagawa-wave")
	-- 	end
	-- }
}
