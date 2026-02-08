return {
  'echasnovski/mini.nvim',
  config = function()
    -- Enhanced text objects (existing)
    require('mini.ai').setup { n_lines = 500 }

    -- Surround operations (existing)
    require('mini.surround').setup()

    -- Automatic pairs - replaces windwp/nvim-autopairs
    require('mini.pairs').setup()

    -- Indent scope visualization - replaces lukas-reineke/indent-blankline.nvim
    require('mini.indentscope').setup {
      symbol = '│',
      options = { try_as_border = true },
      draw = {
        delay = 100,
        animation = require('mini.indentscope').gen_animation.none(),
      },
    }

    -- Disable indentscope for certain filetypes
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'help',
        'alpha',
        'dashboard',
        'neo-tree',
        'Trouble',
        'trouble',
        'lazy',
        'mason',
        'notify',
        'toggleterm',
        'lazyterm',
      },
      callback = function() vim.b.miniindentscope_disable = true end,
    })

    -- File explorer - replaces yazi.nvim
    vim.g.loaded_netrwPlugin = 1 -- Disable netrw
    require('mini.files').setup {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
    }

    -- File explorer keymaps (using <leader>e prefix to avoid format conflict)
    vim.keymap.set('n', '<leader>ee', function() require('mini.files').open(vim.api.nvim_buf_get_name(0), true) end, { desc = '[E]xplore at current file' })

    vim.keymap.set('n', '<leader>eE', function() require('mini.files').open(vim.uv.cwd(), true) end, { desc = '[E]xplore at cwd' })

    vim.keymap.set(
      'n',
      '<leader>er',
      function() require('mini.files').reveal(vim.api.nvim_buf_get_name(0), true) end,
      { desc = '[E]xplore [R]eveal current file' }
    )

    -- Buffer-local mini.files enhancements
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Set local cwd to current directory
        vim.keymap.set('n', 'g~', function()
          local path = require('mini.files').get_fs_entry().path
          local dir = vim.fn.isdirectory(path) == 1 and path or vim.fn.fnamemodify(path, ':h')
          vim.fn.chdir(dir)
          vim.notify('Changed cwd to: ' .. dir)
        end, { buffer = buf_id, desc = 'Set cwd to current directory' })

        -- Yank entry path
        vim.keymap.set('n', 'gy', function()
          local path = require('mini.files').get_fs_entry().path
          vim.fn.setreg('+', path)
          vim.notify('Yanked path: ' .. path)
        end, { buffer = buf_id, desc = 'Yank entry path' })

        -- Open entry externally
        vim.keymap.set('n', 'go', function()
          local path = require('mini.files').get_fs_entry().path
          vim.ui.open(path)
        end, { buffer = buf_id, desc = 'Open entry externally' })
      end,
    })

    -- Fuzzy finder - primary search interface (replaces telescope as default)
    require('mini.pick').setup()

    -- Mini.pick keymaps (primary search interface)
    vim.keymap.set('n', '<leader>sf', function() require('mini.pick').builtin.files() end, { desc = '[S]earch [F]iles' })

    vim.keymap.set('n', '<leader>sb', function() require('mini.pick').builtin.buffers() end, { desc = '[S]earch [B]uffers' })

    vim.keymap.set('n', '<leader>sh', function() require('mini.pick').builtin.help() end, { desc = '[S]earch [H]elp' })

    vim.keymap.set('n', '<leader>sg', function() require('mini.pick').builtin.grep_live() end, { desc = '[S]earch by [G]rep (live)' })

    vim.keymap.set(
      'n',
      '<leader>sw',
      function() require('mini.pick').builtin.grep { pattern = vim.fn.expand '<cword>' } end,
      { desc = '[S]earch current [W]ord' }
    )

    vim.keymap.set('n', '<leader>sr', function() require('mini.pick').builtin.resume() end, { desc = '[S]earch [R]esume' })

    vim.keymap.set('n', '<leader><leader>', function() require('mini.pick').builtin.buffers() end, { desc = '[ ] Find existing buffers' })

    vim.keymap.set(
      'n',
      '<leader>sn',
      function() require('mini.pick').builtin.files(nil, { source = { cwd = vim.fn.stdpath 'config' } }) end,
      { desc = '[S]earch [N]eovim files' }
    )

    -- Bracket navigation
    require('mini.bracketed').setup()

    -- Session management
    require('mini.sessions').setup()

    -- Session keymaps (using <leader>w prefix to avoid quickfix conflict)
    vim.keymap.set('n', '<leader>ws', function() require('mini.sessions').write() end, { desc = '[W]orkspace [S]ave session' })

    vim.keymap.set('n', '<leader>wS', function() require('mini.sessions').select() end, { desc = '[W]orkspace [S]elect session' })

    -- File visits tracking
    require('mini.visits').setup()

    -- Visits integration with mini.pick
    vim.keymap.set('n', '<leader>so', function()
      local visits = require 'mini.visits'
      require('mini.pick').start {
        source = {
          items = visits.list_paths(),
          name = 'Visits (recent/frequent files)',
          choose = function(item) vim.cmd('edit ' .. item) end,
        },
      }
    end, { desc = '[S]earch [O]ften visited files' })

    -- Key hint popup - replaces folke/which-key.nvim
    require('mini.clue').setup {
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
      },

      clues = {
        -- Enhance this by adding descriptions for `Leader` key
        { mode = 'n', keys = '<Leader>s', desc = '[S]earch' },
        { mode = 'n', keys = '<Leader>t', desc = '[T]elescope' },
        { mode = 'n', keys = '<Leader>h', desc = 'Git [H]unk' },
        { mode = 'x', keys = '<Leader>h', desc = 'Git [H]unk' },
        { mode = 'n', keys = '<Leader>g', desc = '[G]it' },
        { mode = 'n', keys = '<Leader>c', desc = '[C]ode' },
        { mode = 'x', keys = '<Leader>c', desc = '[C]ode' },
        { mode = 'n', keys = '<Leader>u', desc = '[U]ndo' },
        { mode = 'n', keys = '<Leader>e', desc = '[E]xplore' },
        { mode = 'n', keys = '<Leader>w', desc = '[W]orkspace' },
        { mode = 'n', keys = '<Leader>f', desc = '[F]ormat buffer' },

        -- Submode hints
        require('mini.clue').gen_clues.builtin_completion(),
        require('mini.clue').gen_clues.g(),
        require('mini.clue').gen_clues.marks(),
        require('mini.clue').gen_clues.registers(),
        require('mini.clue').gen_clues.windows(),
        require('mini.clue').gen_clues.z(),
      },

      window = {
        delay = 0,
        config = {
          width = 'auto',
          border = 'none',
        },
      },
    }

    -- Statusline - replaces nvim-lualine/lualine.nvim
    require('mini.statusline').setup {
      content = {
        active = function()
          local mode, mode_hl = require('mini.statusline').section_mode { trunc_width = 120 }
          local git = require('mini.statusline').section_git { trunc_width = 40 }
          local diff = require('mini.statusline').section_diff { trunc_width = 75 }
          local diagnostics = require('mini.statusline').section_diagnostics { trunc_width = 75 }
          local lsp = require('mini.statusline').section_lsp { trunc_width = 75 }
          local filename = require('mini.statusline').section_filename { trunc_width = 140 }
          local fileinfo = require('mini.statusline').section_fileinfo { trunc_width = 120 }
          local location = require('mini.statusline').section_location { trunc_width = 75 }
          local search = require('mini.statusline').section_searchcount { trunc_width = 75 }

          return require('mini.statusline').combine_groups {
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          }
        end,
        inactive = function()
          local filename = require('mini.statusline').section_filename { trunc_width = 140 }
          local location = require('mini.statusline').section_location { trunc_width = 75 }

          return require('mini.statusline').combine_groups {
            { hl = 'MiniStatuslineInactive', strings = { filename } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineInactive', strings = { location } },
          }
        end,
      },
      use_icons = vim.g.have_nerd_font,
      set_vim_settings = false,
    }
  end,
}
