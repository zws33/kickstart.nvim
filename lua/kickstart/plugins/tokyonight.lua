return {
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      transparent = true,
      styles = {
        comments = { italic = false }, -- Disable italics in comments
        sidebars = 'transparent',
        floats = 'transparent',
      },
      on_highlights = function(hl, c)
        -- Core UI
        hl.CursorLine = { bg = 'NONE' }
        hl.CursorLineNr = { fg = c.dark5, bg = 'NONE' }
        hl.LineNr = { fg = c.dark5, bg = 'NONE' }
        hl.SignColumn = { bg = 'NONE' }
        hl.WinSeparator = { fg = c.dark5, bg = 'NONE' }
        hl.StatusLine = { bg = 'NONE' }
        hl.StatusLineNC = { bg = 'NONE' }

        -- Floating windows
        hl.NormalFloat = { bg = 'NONE' }
        hl.FloatBorder = { fg = c.dark5, bg = 'NONE' }

        -- Popup menu
        hl.Pmenu = { bg = 'NONE' }
        hl.PmenuSel = { bg = c.bg_highlight }

        -- Neo-tree
        hl.NeoTreeNormal = { bg = 'NONE' }
        hl.NeoTreeNormalNC = { bg = 'NONE' }
        hl.NeoTreeWinSeparator = { fg = c.dark5, bg = 'NONE' }

        -- Telescope
        hl.TelescopeNormal = { bg = 'NONE' }
        hl.TelescopeBorder = { fg = c.dark5, bg = 'NONE' }
        hl.TelescopePromptNormal = { bg = 'NONE' }
        hl.TelescopePromptBorder = { fg = c.dark5, bg = 'NONE' }
        hl.TelescopeResultsNormal = { bg = 'NONE' }
        hl.TelescopeResultsBorder = { fg = c.dark5, bg = 'NONE' }
        hl.TelescopePreviewNormal = { bg = 'NONE' }
        hl.TelescopePreviewBorder = { fg = c.dark5, bg = 'NONE' }

        -- Which-key
        hl.WhichKeyFloat = { bg = 'NONE' }
        hl.WhichKeyBorder = { fg = c.dark5, bg = 'NONE' }
      end,
    }

    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.cmd.colorscheme 'tokyonight-storm'
  end,
}
