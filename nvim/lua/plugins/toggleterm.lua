-- local status_ok, toggleterm = pcall(require, "toggleterm")
-- if not status_ok then
-- 	return
-- end
local opts = {
	auto_scroll = true,
	size = 20,
	open_mapping = [[<A-t>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
	on_open = function(term)
		-- cmd.startinsert()
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", [[<cmd>close<cr>]], { noremap = true, silent = true })
	end,
	on_close = function() end,
	buffer = 0,
}

function _G.set_terminal_keymaps()
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

return {
	{ --terminal
		"akinsho/toggleterm.nvim",
		opts = opts,
		event = "VeryLazy",
		version = "*",
		branch = "main",
		config = function()
			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
			local Terminal = require("toggleterm.terminal").Terminal
			local node = Terminal:new({ cmd = "node", hidden = true })
			function _NODE_TOGGLE()
				node:toggle()
			end

			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
			function _lazygit_toggle()
				lazygit:toggle()
			end
			require("toggleterm").setup({})
		end,
	},
}
