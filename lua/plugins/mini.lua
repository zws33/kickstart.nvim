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
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
    
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
        { mode = 'n', keys = '<Leader>t', desc = '[T]oggle/TypeScript' },
        { mode = 'n', keys = '<Leader>h', desc = 'Git [H]unk' },
        { mode = 'x', keys = '<Leader>h', desc = 'Git [H]unk' },
        { mode = 'n', keys = '<Leader>g', desc = '[G]it' },
        { mode = 'n', keys = '<Leader>c', desc = '[C]ode' },
        { mode = 'x', keys = '<Leader>c', desc = '[C]ode' },
        { mode = 'n', keys = '<Leader>u', desc = '[U]ndo' },
        { mode = 'n', keys = '<Leader>y', desc = '[Y]azi' },
        
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
