-- return {
-- 	"ggandor/leap.nvim",
-- 	-- enabled = true,
-- 	dependencies = {
-- 		"tpope/vim-repeat",
-- 	},
-- 	-- config = true,
-- 	config = function()
-- 		require('leap').add_default_mappings()
-- 		require('leap').setup()
-- 	end,
-- keys = {
-- 	{
-- 		"<leader>H",
-- 		"<Plug>(leap-backward-till)",
-- 		desc = "Leap backward",
-- 	},
-- 	{
-- 		"<leader>lw",
-- 		"<Plug>(leap-cross-window)",
-- 		desc = "Leap cross window",
-- 	},
-- 	{

-- 		"<leader>h",
-- 		"<Plug>(leap-forward-till)",
-- 		desc = "Leap forward",
-- 	},
-- },
-- }

return {
	"ggandor/leap.nvim",
	dependencies = {
		"tpope/vim-repeat",
	},
	keys = {
		{ "<leader>h", "<Plug>(leap-forward-to)", mode = { "n", "x", "o" }, desc = "Leap forward to" },
		{ "<leader>H", "<Plug>(leap-backward-to)", mode = { "n", "x", "o" }, desc = "Leap backward to" },
		{ "<leader>HH", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "Leap from windows" },
	},
	config = true,
}
