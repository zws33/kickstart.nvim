return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'frappe',
      term_colors = true,
      auto_integrations = true,
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.lavender, bold = true },
        }
      end,
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}