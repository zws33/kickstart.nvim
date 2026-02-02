return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000, -- ensure it loads before other plugins
  lazy = false,
  opts = {
    flavour = 'macchiato', -- latte, frappe, macchiato, mocha
    transparent_background = true,
    integrations = {
      cmp = true,
      gitsigns = true,
      neotree = true,
      treesitter = true,
      telescope = true,
      which_key = true,
      -- more integrations available
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin'
  end,
}