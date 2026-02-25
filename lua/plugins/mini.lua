return {
  'echasnovski/mini.nvim',
  config = function()
    ---------------------------------------------------------------------------
    -- Core editing modules
    ---------------------------------------------------------------------------
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
    require('mini.pairs').setup()
    require('mini.bracketed').setup()
    require('mini.comment').setup()

    ---------------------------------------------------------------------------
    -- UI: indent guides
    ---------------------------------------------------------------------------
    require('mini.indentscope').setup {
      symbol = '│',
      options = { try_as_border = true },
      draw = {
        delay = 100,
        animation = require('mini.indentscope').gen_animation.none(),
      },
    }

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

    ---------------------------------------------------------------------------
    -- Starter (dashboard)
    ---------------------------------------------------------------------------
    require('mini.starter').setup {
      header = ' Mini.nvim starter ',
      items = {
        require('mini.starter').sections.builtin_actions(),
        require('mini.starter').sections.recent_files(10, true),
        require('mini.starter').sections.sessions(5, true),
      },
      content_hooks = {
        require('mini.starter').gen_hook.adding_bullet(),
        require('mini.starter').gen_hook.aligning('center', 'center'),
      },
    }

    ---------------------------------------------------------------------------
    -- Files (file explorer)
    ---------------------------------------------------------------------------
    vim.g.loaded_netrwPlugin = 1
    local minifiles = require 'mini.files'
    minifiles.setup {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
    }

    local function open_mini_files()
      local path = vim.api.nvim_buf_get_name(0)
      if vim.fn.isdirectory(path) == 1 then minifiles.open(path, false) end
    end

    vim.api.nvim_create_autocmd('BufEnter', {
      desc = 'Hijack netrw with mini.files',
      callback = open_mini_files,
    })

    vim.keymap.set('n', '<leader>ee', function() minifiles.open(vim.api.nvim_buf_get_name(0), true) end, { desc = '[E]xplore at current file' })
    vim.keymap.set('n', '<leader>eE', function() minifiles.open(vim.uv.cwd(), true) end, { desc = '[E]xplore at cwd' })
    vim.keymap.set('n', '<leader>er', function() minifiles.reveal(vim.api.nvim_buf_get_name(0), true) end, { desc = '[E]xplore [R]eveal current file' })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        local mf = require 'mini.files'

        vim.keymap.set('n', 'g~', function()
          local path = mf.get_fs_entry().path
          local dir = vim.fn.isdirectory(path) == 1 and path or vim.fn.fnamemodify(path, ':h')
          vim.fn.chdir(dir)
          vim.notify('Changed cwd to: ' .. dir)
        end, { buffer = buf_id, desc = 'Set cwd to current directory' })

        vim.keymap.set('n', 'gy', function()
          local path = mf.get_fs_entry().path
          vim.fn.setreg('+', path)
          vim.notify('Yanked path: ' .. path)
        end, { buffer = buf_id, desc = 'Yank entry path' })

        vim.keymap.set('n', 'go', function()
          local path = mf.get_fs_entry().path
          vim.ui.open(path)
        end, { buffer = buf_id, desc = 'Open entry externally' })
      end,
    })

    ---------------------------------------------------------------------------
    -- Extra pickers (LSP, diagnostics, visits, etc.)
    ---------------------------------------------------------------------------
    require('mini.extra').setup()

    ---------------------------------------------------------------------------
    -- Pick (fuzzy finder)
    ---------------------------------------------------------------------------
    require('mini.pick').setup()

    local pick = require 'mini.pick'
    local extra = require 'mini.extra'

    vim.keymap.set('n', '<leader>sf', function() pick.builtin.files() end, { desc = '[S]earch [F]iles' })

    vim.keymap.set('n', '<leader>sb', function() pick.builtin.buffers() end, { desc = '[S]earch [B]uffers' })

    vim.keymap.set('n', '<leader>sh', function() pick.builtin.help() end, { desc = '[S]earch [H]elp' })

    vim.keymap.set('n', '<leader>sg', function() pick.builtin.grep_live() end, { desc = '[S]earch by [G]rep (live)' })

    vim.keymap.set('n', '<leader>sw', function() pick.builtin.grep { pattern = vim.fn.expand '<cword>' } end, { desc = '[S]earch current [W]ord' })

    -- Repurposed <leader>sr for LSP references (old resume -> :Pick resume)
    vim.keymap.set('n', '<leader>sr', function() extra.pickers.lsp { scope = 'references' } end, { desc = '[S]earch LSP [R]eferences' })

    vim.keymap.set('n', '<leader>sd', function() extra.pickers.lsp { scope = 'definition' } end, { desc = '[S]earch [D]efinition(s)' })

    vim.keymap.set('n', '<leader>ss', function() extra.pickers.lsp { scope = 'document_symbol' } end, { desc = '[S]earch document [S]ymbols' })

    vim.keymap.set('n', '<leader>sS', function() extra.pickers.lsp { scope = 'workspace_symbol' } end, { desc = '[S]earch workspace [S]ymbols' })

    vim.keymap.set('n', '<leader>sdg', function() extra.pickers.diagnostic() end, { desc = '[S]earch [D]ia[g]nostics' })

    vim.keymap.set('n', '<leader>sl', function() extra.pickers.buf_lines { scope = 'current' } end, { desc = '[S]earch buffer [L]ines' })

    vim.keymap.set('n', '<leader>so', function() extra.pickers.visit_paths() end, { desc = '[S]earch [O]ften visited files' })

    -- TS project files only
    vim.keymap.set(
      'n',
      '<leader>sp',
      function()
        pick.builtin.files {
          globs = { 'src/**/*.ts', 'src/**/*.tsx', 'src/**/*.js', 'src/**/*.jsx' },
        }
      end,
      { desc = '[S]earch [P]roject TS/JS files' }
    )

    -- Resume is now via :Pick resume
    vim.keymap.set('n', '<leader>srr', function() pick.builtin.resume() end, { desc = '[S]earch [R]esume (picker)' })

    vim.keymap.set(
      'n',
      '<leader>sn',
      function() pick.builtin.files(nil, { source = { cwd = vim.fn.stdpath 'config' } }) end,
      { desc = '[S]earch [N]eovim files' }
    )

    ---------------------------------------------------------------------------
    -- Sessions & visits
    ---------------------------------------------------------------------------
    require('mini.sessions').setup()

    vim.keymap.set('n', '<leader>ws', function() require('mini.sessions').write() end, { desc = '[W]orkspace [S]ave session' })

    vim.keymap.set('n', '<leader>wS', function() require('mini.sessions').select() end, { desc = '[W]orkspace [S]elect session' })

    require('mini.visits').setup()

    ---------------------------------------------------------------------------
    -- Clue (which‑key‑like)
    ---------------------------------------------------------------------------
    require('mini.clue').setup {
      triggers = {
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },
        { mode = 'i', keys = '<C-x>' },
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
        { mode = 'n', keys = '\\\\' },
      },

      clues = {
        { mode = 'n', keys = '<Leader>s', desc = '[S]earch' },
        { mode = 'n', keys = '<Leader>t', desc = '[T]ypescript' },
        { mode = 'n', keys = '<Leader>h', desc = 'Git [H]unk' },
        { mode = 'x', keys = '<Leader>h', desc = 'Git [H]unk' },
        { mode = 'n', keys = '<Leader>g', desc = '[G]it' },
        { mode = 'n', keys = '<Leader>c', desc = '[C]ode' },
        { mode = 'x', keys = '<Leader>c', desc = '[C]ode' },
        { mode = 'n', keys = '<Leader>u', desc = '[U]ndo' },
        { mode = 'n', keys = '<Leader>e', desc = '[E]xplore' },
        { mode = 'n', keys = '<Leader>w', desc = '[W]orkspace' },
        { mode = 'n', keys = '<Leader>f', desc = '[F]ormat buffer' },

        -- Search sub-menu
        { mode = 'n', keys = '<Leader>sf', desc = '[F]iles' },
        { mode = 'n', keys = '<Leader>sb', desc = '[B]uffers' },
        { mode = 'n', keys = '<Leader>sh', desc = '[H]elp' },
        { mode = 'n', keys = '<Leader>sg', desc = '[G]rep live' },
        { mode = 'n', keys = '<Leader>sw', desc = 'current [W]ord' },
        { mode = 'n', keys = '<Leader>sr', desc = 'LSP [R]eferences' },
        { mode = 'n', keys = '<Leader>sd', desc = '[D]efinitions' },
        { mode = 'n', keys = '<Leader>ss', desc = 'document [S]ymbols' },
        { mode = 'n', keys = '<Leader>sS', desc = 'workspace [S]ymbols' },
        { mode = 'n', keys = '<Leader>sdg', desc = '[D]iagnostics' },
        { mode = 'n', keys = '<Leader>sl', desc = 'buffer [L]ines' },
        { mode = 'n', keys = '<Leader>so', desc = '[O]ften visited' },
        { mode = 'n', keys = '<Leader>sp', desc = '[P]roject TS/JS' },

        -- mini.basics option toggles (\\prefix)
        { mode = 'n', keys = '\\\\b', desc = 'Toggle background' },
        { mode = 'n', keys = '\\\\c', desc = 'Toggle cursorline' },
        { mode = 'n', keys = '\\\\C', desc = 'Toggle cursorcolumn' },
        { mode = 'n', keys = '\\\\d', desc = 'Toggle diagnostic' },
        { mode = 'n', keys = '\\\\h', desc = 'Toggle hlsearch' },
        { mode = 'n', keys = '\\\\i', desc = 'Toggle ignorecase' },
        { mode = 'n', keys = '\\\\l', desc = 'Toggle list' },
        { mode = 'n', keys = '\\\\n', desc = 'Toggle number' },
        { mode = 'n', keys = '\\\\r', desc = 'Toggle relativenumber' },
        { mode = 'n', keys = '\\\\s', desc = 'Toggle spell' },
        { mode = 'n', keys = '\\\\w', desc = 'Toggle wrap' },

        -- mini.basics basic mappings
        { mode = 'n', keys = 'gO', desc = 'Put empty line above' },
        { mode = 'n', keys = 'go', desc = 'Put empty line below' },
        { mode = 'n', keys = 'gy', desc = 'Copy to system clipboard' },
        { mode = 'n', keys = 'gp', desc = 'Paste from system clipboard' },
        { mode = 'n', keys = 'gV', desc = 'Select last changed/put/yanked' },

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

    -- Ensure clue triggers are refreshed in normal file buffers
    local miniclue = require 'mini.clue'
    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function(ev)
        -- Check if buffer is still valid (it might have been invalidated by previous callbacks, e.g., mini.files hijacking)
        if not vim.api.nvim_buf_is_valid(ev.buf) then return end
        -- avoid special mini buffers, terminals, etc.
        if vim.bo[ev.buf].buftype ~= '' then return end
        miniclue.ensure_buf_triggers()
      end,
    })

    ---------------------------------------------------------------------------
    -- Statusline
    ---------------------------------------------------------------------------
    require('mini.statusline').setup {
      use_icons = vim.g.have_nerd_font,
      set_vim_settings = false,
      content = {
        active = function()
          local ms = require 'mini.statusline'
          local mode, mode_hl = ms.section_mode { trunc_width = 120 }
          local git = ms.section_git { trunc_width = 40 }
          local diff = ms.section_diff { trunc_width = 75 }
          local diagnostics = ms.section_diagnostics { trunc_width = 75 }
          local lsp = ms.section_lsp { trunc_width = 75 }
          local filename = ms.section_filename { trunc_width = 140 }
          local fileinfo = ms.section_fileinfo { trunc_width = 120 }
          local location = ms.section_location { trunc_width = 75 }
          local search = ms.section_searchcount { trunc_width = 75 }

          return ms.combine_groups {
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
            '%<',
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=',
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          }
        end,
        inactive = function()
          local ms = require 'mini.statusline'
          local filename = ms.section_filename { trunc_width = 140 }
          local location = ms.section_location { trunc_width = 75 }

          return ms.combine_groups {
            { hl = 'MiniStatuslineInactive', strings = { filename } },
            '%=',
            { hl = 'MiniStatuslineInactive', strings = { location } },
          }
        end,
      },
    }

    ---------------------------------------------------------------------------
    -- Basics (popular mappings/autocommands only)
    ---------------------------------------------------------------------------
    require('mini.basics').setup {
      options = { basic = false }, -- Don't touch your options.lua
      mappings = {
        basic = true, -- <C-s> save, jk escape, gh/gH, etc.
        option_toggle_prefix = '\\\\', -- \\w toggle wrap, \\ss toggle spell
        windows = false, -- Skip window mappings (you have custom ones)
        move_with_alt = false, -- Skip Alt-hjkl resize
        reset_c_h = false, -- Skip C-h (you probably use it for splits)
      },
      autocommands = {
        basic = true, -- Yank highlight + terminal insert mode
        relnum_in_visual_mode = false,
      },
    }
  end,
}
