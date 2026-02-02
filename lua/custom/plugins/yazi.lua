return {
  ---@type LazySpec
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    dependencies = { 'folke/snacks.nvim', lazy = true },
    keys = {
      {
        '<leader>yf',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = '[Y]azi at current [F]ile',
      },
      {
        '<leader>yd',
        '<cmd>Yazi cwd<cr>',
        desc = '[Y]azi at working [D]irectory',
      },
      {
        '<leader>yr',
        '<cmd>Yazi toggle<cr>',
        desc = '[Y]azi [R]esume last session',
      },
    },
    ---@type YaziConfig | {}
    opts = {
      floating_window_scaling_factor = 0.9,
      yazi_floating_window_border = 'rounded',
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = '~',
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },
}
