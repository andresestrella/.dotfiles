return {
  { "ellisonleao/gruvbox.nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "gruvbox" },
  },

  -- {
  --   "sainnhe/gruvbox-material",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.gruvbox_material_background = "hard" -- hard, medium, soft, none
  --     vim.cmd.colorscheme("gruvbox-material")
  --   end,
  -- },
  -- {
  -- 	'sainnhe/sonokai',
  -- 	lazy = false,
  -- 	priority = 1000,
  -- 	config = function()
  -- 		vim.cmd.colorscheme('sonokai')
  -- 	end,
  -- },
  -- {
  -- 	'sainnhe/edge',
  -- 	lazy = false,
  -- 	priority = 1000,
  -- 	config = function()
  -- 		-- Configure edge theme for darker variant
  -- 		vim.g.edge_style = 'aura' -- Options: 'default', 'neon', 'aura'
  -- 		vim.g.edge_dim_foreground = 1
  -- 		vim.g.edge_transparent_background = 0
  -- 		vim.g.edge_enable_italic = 1
  -- 		vim.g.edge_dim_inactive_windows = 1
  -- 		vim.cmd.colorscheme('edge')
  -- 	end,
  -- },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
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
