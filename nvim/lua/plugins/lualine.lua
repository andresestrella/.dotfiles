return {
  "nvim-lualine/lualine.nvim", --status line
  enabled = true,
  event = "VeryLazy",
  config = function()
    require('lualine').setup({
      options = {
        icons_enabled = true,
        --theme = 'catppuccin'
        theme = 'gruvbox-material'
      },
      sections = {
        lualine_a = {
          {
            'filename',
            path = 1,
          }
        }
      }
    })
  end,
}
