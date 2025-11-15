vim.g.ai_cmp = false -- set to true ai completion (copilot / supermaven suggestion) to show up in nvim-cmp / blink, false to use standalone

return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },
      -- keymap = {
      --   preset = "super-tab",
      -- },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      keymaps = {
        accept_suggestion = "<tab>", -- handled by nvim-cmp / blink.cmp
      },
      disable_inline_completion = vim.g.ai_cmp,
      ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
      color = {
        suggestion_color = "#1C1C1C",
        cterm = 244,
      },
    },
  },
}
