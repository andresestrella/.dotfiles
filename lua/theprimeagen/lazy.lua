local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  --file finding
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.1',
    -- or                              , branch = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  --theme, colors
  -- {
  --   "catppuccin/nvim", name = "catppuccin"
  -- },

  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "medium" -- hard, medium, soft, none
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },

  -- LSP troubleshooting
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        icons = false,
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },

  --parse tree
  {
    "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
  },
  --use("nvim-treesitter/playground")
  "nvim-treesitter/nvim-treesitter-context",
  "theprimeagen/harpoon", --quick file access
  "theprimeagen/refactoring.nvim",
  --undo history
  "mbbill/undotree",
  --git
  "tpope/vim-fugitive",
  "theprimeagen/git-worktree.nvim",


  --lsp all in one
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  },
  "jose-elias-alvarez/null-ls.nvim",
  "jay-babu/mason-null-ls.nvim",
  --"pangloss/vim-javascript",
  --"othree/html5.vim",
  --"evanleck/vim-svelte",--requires the 2 above this
  "leafOfTree/vim-svelte-plugin",
  --use("github/copilot.vim")        --AI completion
  "zbirenbaum/copilot.lua",

  --commenting
  {
    "numToStr/Comment.nvim",
    keys = {{"gcc"}, {"gbc"}, {"gc", mode = "v"}, {"gb", mode = "v"} },
    config = true,
  },
  "nvim-lualine/lualine.nvim",                    --status line
  { "nvim-tree/nvim-web-devicons", lazy = true }, -- not strictly required, but recommended

  -- file tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
    }
  },

  --sessions
  {
    'Shatur/neovim-session-manager',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  "chentoast/marks.nvim", --marks visualizer
  "tpope/vim-sleuth",     --auto detect indent
  "tpope/vim-surround",   --surrounding
  "jiangmiao/auto-pairs", --auto pairs

  --debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      --dap setup
      "mfussenegger/nvim-dap-python",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = { "<leader>b", "F9", "F5" },
    config = function()
      local ok_cmp, cmp = pcall(require, "cmp")
      if ok_cmp then
        cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
          sources = cmp.config.sources({
            { name = "dap" },
          }, {
            { name = "buffer" },
          }),
        })
      end
    end,
  },

  "lewis6991/gitsigns.nvim", --git signs

  "akinsho/toggleterm.nvim", --terminal
  "nanozuki/tabby.nvim",     --prettier tabs
  "karb94/neoscroll.nvim",   --smooth scrolling"

}

require("lazy").setup(plugins, opts)
