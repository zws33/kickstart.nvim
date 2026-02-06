return {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    lightbulb = { enable = false },
    symbol_in_winbar = { enable = true },
    ui = {
      border = 'rounded',
    },
  },
  keys = {
    { 'K', '<cmd>Lspsaga hover_doc<cr>', desc = 'Hover documentation' },
    { '<leader>ca', '<cmd>Lspsaga code_action<cr>', mode = { 'n', 'v' }, desc = '[C]ode [A]ction' },
    { '<leader>cr', '<cmd>Lspsaga rename<cr>', desc = '[C]ode [R]ename' },
    { '<leader>cd', '<cmd>Lspsaga peek_definition<cr>', desc = '[C]ode peek [D]efinition' },
    { '<leader>cD', '<cmd>Lspsaga goto_definition<cr>', desc = '[C]ode goto [D]efinition' },
    { '<leader>co', '<cmd>Lspsaga outline<cr>', desc = '[C]ode [O]utline' },
    { '<leader>ci', '<cmd>Lspsaga incoming_calls<cr>', desc = '[C]ode [I]ncoming calls' },
    { '<leader>cO', '<cmd>Lspsaga outgoing_calls<cr>', desc = '[C]ode [O]utgoing calls' },
    { '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', desc = 'Previous [D]iagnostic' },
    { ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', desc = 'Next [D]iagnostic' },
    { '<leader>cl', '<cmd>Lspsaga show_line_diagnostics<cr>', desc = '[C]ode [L]ine diagnostics' },
  },
}
