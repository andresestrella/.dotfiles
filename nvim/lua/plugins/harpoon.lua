local opts = {
	save_on_toggle = true,
	save_on_change = true,
	enter_on_sendcmd = true,
	tmux_autoclose_windows = true,
	excluded_filetypes = { "harpoon" },
	mark_branch = false,
}

return {
	"theprimeagen/harpoon", --quick file access
	opts = opts,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon").setup(opts)
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>ss", ui.toggle_quick_menu)
		vim.keymap.set("n", "<leader>sa", mark.add_file)

		vim.keymap.set("n", "<leader>su", function()
			ui.nav_file(1)
		end)
		vim.keymap.set("n", "<leader>si", function()
			ui.nav_file(2)
		end)
		vim.keymap.set("n", "<leader>so", function()
			ui.nav_file(3)
		end)
		vim.keymap.set("n", "<leader>sp", function()
			ui.nav_file(4)
		end)
	end,
	keys = {
		{ "<leader>ss", "ui.toggle_quick_menu" },
		{ "<leader>sa", "mark.add_file" },
		{ "<leader>su", "ui.nav_file(1)" },
		{ "<leader>si", "ui.nav_file(2)" },
		{ "<leader>so", "ui.nav_file(3)" },
		{ "<leader>sp", "ui.nav_file(4)" },
	}
}
