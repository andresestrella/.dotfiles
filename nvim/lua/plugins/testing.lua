-- keymaps
vim.api.nvim_set_keymap("n", "<leader>dm", [[:lua require"neotest".run.run()<CR>]], { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>dM",
	[[:lua require"neotest".run.run({strategy = "dap"})<CR>]],
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>df",
	[[:lua require"neotest".run.run({vim.fn.expand("%")})<CR>]],
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>dF",
	[[:lua require"neotest".run.run({vim.fn.expand("%"), strategy = "dap"})<CR>]],
	{ noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>dS", [[:lua require"neotest".summary.toggle()<CR>]], { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>tw",
	"<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
	{}
)

return { --testing
	{
		"vim-test/vim-test",
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-jest",
		},
		lazy = true,
		keys = {
			{ "n", "<leader>dm", [[:lua require"neotest".run.run()<CR>]] },
			{ "n", "<leader>dM", [[:lua require"neotest".run.run({strategy = "dap"})<CR>]] },
			{ "n", "<leader>df", [[:lua require"neotest".run.run({vim.fn.expand("%")})<CR>]] },
			{ "n", "<leader>dF", [[:lua require"neotest".run.run({vim.fn.expand("%"), strategy = "dap"})<CR>]] },
			{ "n", "<leader>dS", [[:lua require"neotest".summary.toggle()<CR>]] },
			{ "n", "<leader>tw", "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>" },
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python")({
						dap = {
							justMyCode = false,
						},
					}),

					-- project installed jest
					-- require("neotest-jest")({
					-- 	jestCommand = "npx jest --watch ",
					-- 	-- jestCommand = "npm test --",
					-- }),

					-- global installed jest
					require("neotest-jest")({
						jestCommand = "jest --watch ",
						-- jestCommand = "npm test --",
					}),

					-- global installed jest
					-- require("neotest-jest")({
					-- 	jestCommand = "npm test --",
					-- 	jestCommand = "jest",
					-- 	jestConfigFile = "custom.jest.config.ts",
					-- 	env = { CI = true },
					-- 	cwd = function(path)
					-- 		return vim.fn.getcwd()
					-- 	end,
					-- }),
				},
			})
		end,
	},
}
-- require("neotest").setup({
--   adapters = {
--     require("neotest-python")({
--       -- Extra arguments for nvim-dap configuration
--       -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
--       dap = {
--         justMyCode = false,
--         console = "integratedTerminal",
--       },
--       args = { "--log-level", "DEBUG" },
--       runner = "pytest",
--     })
--   }
-- })
