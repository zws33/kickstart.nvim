# Neovim Cheatsheet

> Leader key: `<Space>`

---

## Navigation

### Basic Movement
| Key | Action |
|-----|--------|
| `h/j/k/l` | Left/Down/Up/Right |
| `w/W` | Next word/WORD |
| `b/B` | Previous word/WORD |
| `e/E` | End of word/WORD |
| `0` | Start of line |
| `^` | First non-blank character |
| `$` | End of line |
| `gg` | First line |
| `G` | Last line |
| `{num}G` | Go to line number |
| `{` / `}` | Previous/Next paragraph |
| `%` | Jump to matching bracket |
| `Ctrl-d/u` | Half-page down/up |
| `Ctrl-f/b` | Full page down/up |
| `zz` | Center cursor on screen |
| `zt/zb` | Cursor to top/bottom |

### Window/Split Navigation (Custom)
| Key | Action |
|-----|--------|
| `Ctrl-h` | Move to left split |
| `Ctrl-j` | Move to split below |
| `Ctrl-k` | Move to split above |
| `Ctrl-l` | Move to right split |

### Jumping
| Key | Action |
|-----|--------|
| `Ctrl-o` | Jump back |
| `Ctrl-i` | Jump forward |
| `gd` | Go to local definition |
| `gD` | Go to global definition |
| `gi` | Go to last insert position |
| `` ` `` + mark | Jump to mark |
| `'` + mark | Jump to mark line start |

---

## Editing

### Insert Mode Entry
| Key | Action |
|-----|--------|
| `i/I` | Insert before cursor/line start |
| `a/A` | Insert after cursor/line end |
| `o/O` | Open line below/above |
| `s/S` | Substitute char/line |
| `c{motion}` | Change (delete + insert) |
| `C` | Change to end of line |

### Delete/Change
| Key | Action |
|-----|--------|
| `x` | Delete character |
| `dd` | Delete line |
| `D` | Delete to end of line |
| `d{motion}` | Delete motion |
| `cc` | Change entire line |
| `cw` | Change word |
| `ciw` | Change inner word |
| `ci"` | Change inside quotes |
| `ca"` | Change around quotes |

### Copy/Paste
| Key | Action |
|-----|--------|
| `y{motion}` | Yank (copy) |
| `yy` | Yank line |
| `Y` | Yank to end of line |
| `p/P` | Paste after/before |
| `"0p` | Paste from yank register |
| `"+y` | Yank to system clipboard |
| `"+p` | Paste from system clipboard |
| `<leader>ra` | Replace all with clipboard (custom) |

> Note: Your config syncs with system clipboard automatically

### Undo/Redo
| Key | Action |
|-----|--------|
| `u` | Undo |
| `Ctrl-r` | Redo |
| `.` | Repeat last change |

---

## Visual Mode

| Key | Action |
|-----|--------|
| `v` | Character-wise visual |
| `V` | Line-wise visual |
| `Ctrl-v` | Block visual |
| `gv` | Reselect last selection |
| `o` | Move to other end of selection |
| `>` / `<` | Indent/unindent selection |
| `=` | Auto-indent selection |
| `~` | Toggle case |
| `U/u` | Uppercase/lowercase |

---

## Search & Replace

### Search
| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n/N` | Next/previous match |
| `*/#` | Search word under cursor forward/backward |
| `Esc` | Clear search highlight (custom) |

### Replace
| Command | Action |
|---------|--------|
| `:s/old/new/` | Replace first on line |
| `:s/old/new/g` | Replace all on line |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all with confirmation |

---

## Telescope (Fuzzy Finder)

| Key | Action |
|-----|--------|
| `<leader>sf` | Search files |
| `<leader>sg` | Live grep (search content) |
| `<leader>sw` | Search current word |
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>ss` | Search Telescope builtins |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader><leader>` | Find open buffers |
| `<leader>/` | Fuzzy search current buffer |
| `<leader>s/` | Live grep in open files |
| `<leader>sn` | Search Neovim config |

### Inside Telescope
| Key | Action |
|-----|--------|
| `Ctrl-n/p` | Next/previous item |
| `Ctrl-j/k` | Next/previous item (alt) |
| `Enter` | Open selected |
| `Ctrl-x` | Open in horizontal split |
| `Ctrl-v` | Open in vertical split |
| `Ctrl-t` | Open in new tab |
| `Ctrl-u/d` | Scroll preview up/down |
| `Esc` | Close telescope |

---

## LSP (Language Server)

### Navigation
| Key | Action |
|-----|--------|
| `grd` | Go to definition |
| `grD` | Go to declaration |
| `grr` | Find references |
| `gri` | Go to implementations |
| `grt` | Go to type definition |
| `gO` | Document symbols |
| `gW` | Workspace symbols |

### Actions
| Key | Action |
|-----|--------|
| `grn` | Rename symbol |
| `gra` | Code actions |
| `K` | Hover documentation |
| `<leader>th` | Toggle inlay hints |

### Diagnostics
| Key | Action |
|-----|--------|
| `<leader>e` | Show diagnostic float |
| `<leader>q` | Diagnostic quickfix list |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

---

## Completion (blink.cmp)

| Key | Action |
|-----|--------|
| `Ctrl-y` | Accept completion |
| `Ctrl-e` | Cancel completion |
| `Ctrl-n/p` | Next/previous item |
| `Tab` | Next snippet placeholder |
| `Shift-Tab` | Previous snippet placeholder |

---

## Formatting & Linting

| Key | Action |
|-----|--------|
| `<leader>f` | Format buffer |

> Format on save is enabled (except C/C++)

### Configured Formatters
- **Lua**: stylua
- **JS/TS/JSX/TSX**: prettier/prettierd

### Configured Linters
- **Markdown**: markdownlint

---

## Git (gitsigns)

### Navigation
| Key | Action |
|-----|--------|
| `]c` | Next git change |
| `[c` | Previous git change |

### Staging & Reset
| Key | Action |
|-----|--------|
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage entire buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hR` | Reset entire buffer |

### Inspection
| Key | Action |
|-----|--------|
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame current line |
| `<leader>hd` | Diff against index |
| `<leader>hD` | Diff against last commit |

### Toggles
| Key | Action |
|-----|--------|
| `<leader>tb` | Toggle blame line |
| `<leader>tD` | Toggle deleted lines |

---

## File Explorer (Neo-tree)

| Key | Action |
|-----|--------|
| `\` | Toggle file tree |

### Inside Neo-tree
| Key | Action |
|-----|--------|
| `Enter` / `o` | Open file/toggle folder |
| `a` | Add file/directory |
| `d` | Delete |
| `r` | Rename |
| `c` | Copy |
| `m` | Move |
| `y` | Copy path |
| `H` | Toggle hidden files |
| `R` | Refresh |
| `?` | Show help |

---

## mini.nvim Plugins

### mini.surround
| Key | Action |
|-----|--------|
| `sa{motion}{char}` | Add surrounding |
| `sd{char}` | Delete surrounding |
| `sr{old}{new}` | Replace surrounding |

**Examples:**
- `saiw)` - Surround word with parentheses
- `sd'` - Delete surrounding quotes
- `sr)"` - Replace ) with "

### mini.ai (Text Objects)
| Key | Action |
|-----|--------|
| `va)` | Select around parentheses |
| `vi"` | Select inside quotes |
| `yinq` | Yank inside next quote |
| `ci'` | Change inside quotes |
| `daf` | Delete around function |

---

## Debugging (DAP)

| Key | Action |
|-----|--------|
| `F5` | Start/Continue |
| `F1` | Step into |
| `F2` | Step over |
| `F3` | Step out |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Conditional breakpoint |
| `F7` | Toggle DAP UI |

---

## Buffers & Windows

### Buffers
| Command | Action |
|---------|--------|
| `:e {file}` | Edit file |
| `:bn` / `:bp` | Next/previous buffer |
| `:bd` | Delete buffer |
| `:ls` | List buffers |
| `:b {num/name}` | Switch to buffer |

### Windows
| Key | Action |
|-----|--------|
| `Ctrl-w s` | Horizontal split |
| `Ctrl-w v` | Vertical split |
| `Ctrl-w q` | Close window |
| `Ctrl-w o` | Close other windows |
| `Ctrl-w =` | Equal size windows |
| `Ctrl-w _` | Maximize height |
| `Ctrl-w \|` | Maximize width |
| `Ctrl-w +/-` | Increase/decrease height |
| `Ctrl-w >/<` | Increase/decrease width |

### Tabs
| Key | Action |
|-----|--------|
| `:tabnew` | New tab |
| `gt` / `gT` | Next/previous tab |
| `:tabclose` | Close tab |

---

## Terminal

| Key | Action |
|-----|--------|
| `:term` | Open terminal |
| `Esc Esc` | Exit terminal mode (custom) |
| `i` | Enter terminal mode |

---

## Macros & Registers

### Macros
| Key | Action |
|-----|--------|
| `q{register}` | Start recording macro |
| `q` | Stop recording |
| `@{register}` | Play macro |
| `@@` | Repeat last macro |
| `{n}@{register}` | Play macro n times |

### Registers
| Register | Content |
|----------|---------|
| `"` | Default register |
| `0` | Last yank |
| `1-9` | Delete history |
| `+` | System clipboard |
| `_` | Black hole (discard) |
| `/` | Last search |

---

## Marks

| Key | Action |
|-----|--------|
| `m{a-z}` | Set local mark |
| `m{A-Z}` | Set global mark |
| `` `{mark} `` | Jump to mark |
| `'{mark}` | Jump to mark line |
| `:marks` | List marks |
| `:delmarks {mark}` | Delete mark |

---

## Folds

| Key | Action |
|-----|--------|
| `za` | Toggle fold |
| `zo/zc` | Open/close fold |
| `zO/zC` | Open/close all folds under cursor |
| `zR/zM` | Open/close all folds |
| `zj/zk` | Next/previous fold |

---

## Useful Ex Commands

| Command | Action |
|---------|--------|
| `:w` | Save |
| `:q` | Quit |
| `:wq` / `:x` | Save and quit |
| `:q!` | Quit without saving |
| `:wa` | Save all buffers |
| `:e!` | Revert to saved |
| `:!{cmd}` | Run shell command |
| `:r !{cmd}` | Insert command output |
| `:h {topic}` | Help |
| `:Mason` | Open Mason (LSP installer) |
| `:Lazy` | Open plugin manager |
| `:checkhealth` | Check Neovim health |

---

## Your Installed LSPs

- **gopls** - Go
- **ts_ls** - TypeScript/JavaScript
- **lua_ls** - Lua

---

## Your Theme

**Active**: TokyoNight Storm (transparent)
**Alternative**: Catppuccin Macchiato

---

## Quick Reference: Leader Key Groups

| Prefix | Category |
|--------|----------|
| `<leader>s` | Search (Telescope) |
| `<leader>h` | Git hunks |
| `<leader>t` | Toggles |
| `<leader>b` | Breakpoints |
| `<leader>f` | Format |
| `<leader>e` | Diagnostics |
| `<leader>q` | Quickfix |
| `gr` | LSP go-to |
