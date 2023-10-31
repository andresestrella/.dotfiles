--vim.cmd([[ let g:AutoPairsShortcutToggle = '<M->' ]])
-- local opts = {
-- 	disable_filetype = { "TelescopePrompt" },
-- }

return {
	"jiangmiao/auto-pairs", --auto pairs
	-- "windwp/nvim-autopairs",
	-- opts = opts,
	event = "InsertEnter",
	config = function()
		vim.cmd([[ let g:AutoPairsShortcutToggle = '' ]])
	end,
	-- config = function()
	-- 	require("nvim-autopairs").setup({
	-- 		vim.cmd([[ let g:AutoPairsShortcutToggle = '' ]]),
	-- 	})
	-- end,
}
