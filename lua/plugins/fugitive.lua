return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G', 'Gdiffsplit', 'Gvdiffsplit', 'Gread', 'Gwrite', 'Ggrep', 'GMove', 'GDelete', 'GBrowse' },
  keys = {
    { '<leader>gs', '<cmd>Git<cr>', desc = '[G]it [S]tatus' },
    { '<leader>gd', '<cmd>Gdiffsplit<cr>', desc = '[G]it [D]iff split' },
    { '<leader>gc', '<cmd>Git commit<cr>', desc = '[G]it [C]ommit' },
    { '<leader>gb', '<cmd>Git blame<cr>', desc = '[G]it [B]lame' },
    { '<leader>gl', '<cmd>Git log --oneline<cr>', desc = '[G]it [L]og' },
    { '<leader>gp', '<cmd>Git push<cr>', desc = '[G]it [P]ush' },
    { '<leader>gP', '<cmd>Git pull<cr>', desc = '[G]it [P]ull' },
  },
}
