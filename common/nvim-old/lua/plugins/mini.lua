return {
	{
		'echasnovski/mini.nvim',
		version = '*',
		event = 'BufReadPre',
		config = function()
			require('mini.surround').setup() -- change surrounding characters
			require('mini.ai').setup() -- new  text objects for functions and function arguments, f(functions), a(arguments), q(quotes), p(parentheses), b(brackets), c(curly braces), t(tags), <space>
			-- i can delete, replace, change, yank, select, and move text objects
			require('mini.pairs').setup() -- auto pairs
			require('mini.jump').setup() -- extend f,F,t,T to work on multiple lines. also repeat jump by pressing the same key again
			-- require('mini.jump2d').setup() -- hop, but I like hop better still
			require('mini.splitjoin').setup({ -- split and join lines
				mappings = {
					toggle = '<leader>m',
				},
			})
		end
	},
}
