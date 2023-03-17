-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  --file finding
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  --theme, colors
  use { "catppuccin/nvim", as = "catppuccin" }
  use("sainnhe/gruvbox-material")

  -- LSP troubleshooting
  use({
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        icons = false,
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  })

  --parse tree
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  --use("nvim-treesitter/playground")
  use("nvim-treesitter/nvim-treesitter-context");
  use("theprimeagen/harpoon") --quick file access
  use("theprimeagen/refactoring.nvim")
  --undo history
  use("mbbill/undotree")
  --git
  use("tpope/vim-fugitive")

  --lsp all in one
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
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
  }

  --use("pangloss/vim-javascript")
  --use("othree/html5.vim")
  --use("evanleck/vim-svelte")--requires the 2 above this
  use("leafOfTree/vim-svelte-plugin")
  --use("github/copilot.vim")        --AI completion
  use("zbirenbaum/copilot.lua")
  use("numToStr/Comment.nvim")     --commenting
  use("nvim-lualine/lualine.nvim") --status line

  -- Unless you are still migrating, remove the deprecated commands from v1.x
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  -- file tree
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
    }
  }
  --practice vim
  use("theprimeagen/vim-be-good")

  --sessions
  use {
    'Shatur/neovim-session-manager',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use("chentoast/marks.nvim") --marks visualizer
  use("tpope/vim-sleuth")     --auto detect indent
  use("tpope/vim-surround")   --surrounding
  use("jiangmiao/auto-pairs") --auto pairs
  --debugging
  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("theHamsta/nvim-dap-virtual-text")

  --git signs
  use("lewis6991/gitsigns.nvim")
  --
  --dap setup
  use("mfussenegger/nvim-dap-python")
  use("jay-babu/mason-nvim-dap.nvim")

  use("akinsho/toggleterm.nvim") --terminal
  use("nanozuki/tabby.nvim")     --prettier tabs
end)
