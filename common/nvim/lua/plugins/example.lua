Headers = {
  { [[
	  ／|_
	 (o o /
	  |.   ~.
	  じしf_,)ノ ]] },
  {
    [[
              ▀████▀▄▄              ▄█
		            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█
		    ▄        █          ▀▀▀▀▄  ▄▀
		   ▄▀ ▀▄      ▀▄              ▀▄▀
		  ▄▀    █     █▀   ▄█▀▄      ▄█
		  ▀▄     ▀▄  █     ▀██▀     ██▄█
		   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █
		    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀
		   █   █  █      ▄▄           ▄▀
						  ]],
  },
  {
    [[
	██▒   █▓  ██████     ▄████▄   ▒█████  ▓█████▄ ▓█████
	▓██░   █▒▒██    ▒   ▒██▀  ▀█  ▒██▒  ██▒▒██▀ ██▌▓█   ▀
	 ▓██  █▒░░ ▓██▄▄▄   ▒▓█▄      ▒██░  ██▒░██   █▌▒███
	  ▒██ █░░  ▒   ██▒   ▒▓▓▄ ▄██▒▒██   ██░░▓█▄   ▌▒▓█  ▄
	   ▒▀█░  ▒██████▒▒   ▒ ▓███▀ ░░ ████▓▒░░▒████▓ ░▒████▒
	   ░ ▐░  ▒ ▒▓▒ ▒ ░   ░ ░▒ ▒  ░░ ▒░▒░▒░  ▒▒▓  ▒ ░░ ▒░ ░
	   ░ ░░  ░ ░▒  ░ ░     ░  ▒     ░ ▒ ▒░  ░ ▒  ▒  ░ ░  ░
	     ░░  ░  ░  ░     ░        ░ ░ ░ ▒   ░ ░  ░    ░
	      ░        ░     ░ ░          ░ ░     ░       ░  ░
	     ░               ░                  ░            ]],
  },
  {
    [[
	    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
	    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
	    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
	    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
	    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
	    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
  },
  {
    [[
	                                   __
	      ___     ___    ___   __  __ /\_\    ___ ___
	     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\
	    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \
	    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
	     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
  },
  {
    [[
	██╗   ██╗███████╗    ██████╗ ██████╗ ██████╗ ███████╗
	██║   ██║██╔════╝   ██╔════╝██╔═══██╗██╔══██╗██╔════╝
	██║   ██║███████╗   ██║     ██║   ██║██║  ██║█████╗
	╚██╗ ██╔╝╚════██║   ██║     ██║   ██║██║  ██║██╔══╝
	 ╚████╔╝ ███████║   ╚██████╗╚██████╔╝██████╔╝███████╗
	  ╚═══╝  ╚══════╝    ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝]],
  },
}
math.randomseed(os.time())

return {
  -- Add Eslint and use it for formatting
  -- If your project is using eslint with eslint-plugin-prettier, then this will automatically fix eslint errors and format with prettier on save. Important: make sure not to add prettier to null-ls, otherwise this won't work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = { eslint = {} },
  --     setup = {
  --       eslint = function()
  --         require("lazyvim.util").lsp.on_attach(function(client)
  --           if client.name == "eslint" then
  --             client.server_capabilities.documentFormattingProvider = true
  --           elseif client.name == "tsserver" then
  --             client.server_capabilities.documentFormattingProvider = false
  --           end
  --         end)
  --       end,
  --     },
  --   },
  -- },
  ---
  {
    "Wansmer/treesj",
    keys = { "<space>m" },
    config = function()
      require("treesj").setup({})
    end,
  },
  { -- stickt lines on top that show context
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      max_lines = 5,
    },
  },
  { -- merge conflict keymaps
  	'akinsho/git-conflict.nvim',
  	event = "BufRead",
  	version = "*",
  	config = {
  		disable_diagnostics = true, -- disable diagnostics in git conflict buffers
  	}
  },
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          position = "float",
        },
      },
      dashboard = {
        preset = {
          header = Headers[math.random(#Headers)],
        },
      },
      picker = {
        sources = {
          files = { hidden = true, ignored = false },
          grep = { hidden = true, ignored = false },
          explorer = { hidden = true, ignored = true },
        },
        -- hidden = true,
        -- ignored = false,
        formatters = {
          file = {
            truncate = 80, -- truncate the file path to (roughly) this length
          },
        },
      },
    },
    keys = {
      { "<D-j>", "<cmd>lua Snacks.terminal.toggle()<cr>", desc = "Toggle terminal", mode = { "n", "t" } },
      { "<D-b>", "<cmd>lua Snacks.explorer.open()<cr>", desc = "Toggle file tree", mode = { "n", "t" } },
    },
  },
  { -- add pyright to lspconfig (Your override for a LazyVim plugin)
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false }, -- toggle with <leader>uh
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },
  -- Extend the list of default treesitter parsers installed: (Your override for a LazyVim plugin)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      })
    end,
  },
}
