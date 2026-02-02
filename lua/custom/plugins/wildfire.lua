-- Smart selection expansion with Enter/Backspace
return {
  'sustech-data/wildfire.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {},
  -- Default keymaps:
  -- <CR> in normal mode: Initialize selection
  -- <CR> in visual mode: Expand selection (node incremental)
  -- <BS> in visual mode: Shrink selection (node decremental)
}
