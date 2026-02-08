return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    -- Telescope moved to <leader>t prefix (secondary to mini.pick)
    vim.keymap.set('n', '<leader>th', builtin.help_tags, { desc = '[T]elescope [H]elp' })
    vim.keymap.set('n', '<leader>tk', builtin.keymaps, { desc = '[T]elescope [K]eymaps' })
    vim.keymap.set('n', '<leader>tf', builtin.find_files, { desc = '[T]elescope [F]iles' })
    vim.keymap.set('n', '<leader>ts', builtin.builtin, { desc = '[T]elescope [S]elect' })
    vim.keymap.set('n', '<leader>tw', builtin.grep_string, { desc = '[T]elescope current [W]ord' })
    vim.keymap.set('n', '<leader>tg', builtin.live_grep, { desc = '[T]elescope by [G]rep' })
    vim.keymap.set('n', '<leader>td', builtin.diagnostics, { desc = '[T]elescope [D]iagnostics' })
    vim.keymap.set('n', '<leader>tr', builtin.resume, { desc = '[T]elescope [R]esume' })
    vim.keymap.set('n', '<leader>t.', builtin.oldfiles, { desc = '[T]elescope Recent Files' })

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>t/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[T]elescope [/] in Open Files' })

    vim.keymap.set('n', '<leader>tn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[T]elescope [N]eovim files' })
  end,
}
