---
date: 2025-11-15T10:30:00+01:00
researcher: Michał Lester
git_commit: 0418f80d0b514fd3e01a69295a903db2a64537dd
branch: master
repository: .dotfiles
topic: "Neovim Configuration Analysis"
tags: [research, codebase, nvim, neovim, kickstart, lua, editor-config]
status: complete
last_updated: 2025-11-15
last_updated_by: Michał Lester
---

# Research: Neovim Configuration Analysis

**Date**: 2025-11-15T10:30:00+01:00
**Researcher**: Michał Lester
**Git Commit**: 0418f80d0b514fd3e01a69295a903db2a64537dd
**Branch**: master
**Repository**: .dotfiles

## Research Question

Provide a comprehensive analysis of the Neovim configuration in the dotfiles repository, documenting its structure, plugins, keybindings, and architecture.

## Summary

The Neovim configuration is based on **Kickstart.nvim**, a minimal, educational starting point for Neovim configuration written entirely in Lua. The setup uses the **lazy.nvim** plugin manager and follows a modular structure with both base Kickstart plugins and custom user additions. The configuration emphasizes vim-style navigation consistency across tools (matching tmux and IdeaVim configurations in the repository), LSP-powered development features, and efficient lazy-loading for optimal startup performance.

**Key characteristics:**
- Single-file base configuration (`init.lua`) with modular plugin extensions
- Space (` `) configured as leader key
- 32 plugins installed (from `lazy-lock.json`)
- Strong focus on LSP integration with Mason for package management
- Telescope for fuzzy finding across files, grep, and LSP symbols
- Seamless tmux integration via `vim-tmux-navigator`
- Two theme options: Tokyo Night (dark, default) and Catppuccin Latte (light)

## Detailed Findings

### Configuration Architecture

#### File Structure

```
nvim/.config/nvim/
├── init.lua                          # Main configuration (1,148 lines)
├── lazy-lock.json                    # Plugin version lock file
├── lua/
│   ├── kickstart/
│   │   ├── plugins/                 # Optional modular plugins
│   │   │   ├── neo-tree.lua        # File explorer
│   │   │   ├── nvim-tmux-navigator.lua  # Tmux integration
│   │   │   ├── autopairs.lua       # Auto-closing pairs
│   │   │   ├── debug.lua           # DAP debugging
│   │   │   ├── gitsigns.lua        # Git integration keymaps
│   │   │   ├── indent_line.lua     # Indentation guides
│   │   │   └── lint.lua            # Linting support
│   │   └── health.lua              # Health check utilities
│   └── custom/
│       └── plugins/
│           └── init.lua            # User's custom plugins
├── CLAUDE.md                        # AI assistant instructions
└── README.md                        # Kickstart documentation
```

#### Loading Strategy

The configuration uses lazy.nvim's sophisticated loading mechanisms:

1. **Immediate Load**: Core plugins needed at startup (vim-sleuth, gitsigns, which-key, mini.nvim)
2. **Event-based**: Plugins that load on specific Vim events
   - `VimEnter`: which-key, telescope
   - `InsertEnter`: nvim-cmp (completion), autopairs
   - `BufReadPre`/`BufNewFile`: nvim-lint
   - `BufWritePre`: conform.nvim (formatting)
3. **Command-based**: Plugins that load when specific commands are invoked
   - `:Neotree` → neo-tree file explorer
   - `:LazyGit` → lazygit integration
4. **Keymap-based**: Debug plugins load only when debug keybindings are pressed
5. **Filetype-based**: render-markdown.nvim loads only for `.md` files

### Core Configuration Settings

**File**: `nvim/.config/nvim/init.lua`

#### Basic Settings (lines 90-158)

```lua
-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Display
vim.opt.number = true              -- Line numbers
vim.opt.relativenumber = true      -- Relative line numbers
vim.opt.signcolumn = 'yes'         -- Always show sign column
vim.opt.cursorline = true          -- Highlight cursor line
vim.opt.showmode = false           -- Hide mode (shown in statusline)

-- Editing
vim.opt.mouse = 'a'                -- Enable mouse
vim.opt.clipboard = 'unnamedplus'  -- System clipboard sync
vim.opt.breakindent = true         -- Wrapped line indentation
vim.opt.undofile = true            -- Persistent undo history

-- Search
vim.opt.ignorecase = true          -- Case-insensitive search
vim.opt.smartcase = true           -- Case-sensitive if capitals used
vim.opt.inccommand = 'split'       -- Live substitution preview

-- Performance
vim.opt.updatetime = 250           -- Faster CursorHold events
vim.opt.timeoutlen = 300           -- Faster which-key popup

-- Splits
vim.opt.splitright = true          -- Vertical splits go right
vim.opt.splitbelow = true          -- Horizontal splits go below
vim.opt.scrolloff = 10             -- Keep 10 lines above/below cursor
```

### Keybindings

#### Core Keybindings (init.lua)

**Leader Key**: `Space`

##### Basic Navigation & Editing (lines 165-176)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<Esc>` | Normal | Clear search highlights | Remove search highlighting |
| `J` | Visual | Move selection down | Move selected lines down |
| `K` | Visual | Move selection up | Move selected lines up |
| `<leader>x` | Normal | `chmod +x %` | Make current file executable |
| `<C-f>` | Normal | Launch tmux-sessionizer | Open tmux session selector |
| `<leader>q` | Normal | Open diagnostic quickfix | Show all diagnostics |
| `<Esc><Esc>` | Terminal | Exit terminal mode | Return to normal mode |

##### Window Navigation (lines 199-202)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-h>` | Normal | Focus left window | Move to left split/tmux pane |
| `<C-j>` | Normal | Focus lower window | Move to split/pane below |
| `<C-k>` | Normal | Focus upper window | Move to split/pane above |
| `<C-l>` | Normal | Focus right window | Move to right split/tmux pane |

##### Theme Switching (lines 204-215)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>tl` | Normal | Set light theme | Switch to Catppuccin Latte |
| `<leader>td` | Normal | Set dark theme | Switch to Tokyo Night |
| `<leader>ta` | Normal | Theme picker | Browse all available themes |

##### Telescope Fuzzy Finding (lines 495-533)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>sh` | Normal | Search help tags | Find help documentation |
| `<leader>sk` | Normal | Search keymaps | Find keyboard mappings |
| `<leader>sf` | Normal | Search files | Fuzzy find files |
| `<leader>ss` | Normal | Search select | Choose Telescope picker |
| `<leader>sw` | Normal | Search word | Grep current word |
| `<leader>sg` | Normal | Search grep | Live grep search |
| `<leader>sd` | Normal | Search diagnostics | Find LSP diagnostics |
| `<leader>sr` | Normal | Search resume | Resume last search |
| `<leader>s.` | Normal | Search recent files | Find recently opened files |
| `<leader><leader>` | Normal | Find buffers | List open buffers |
| `<leader>/` | Normal | Buffer fuzzy find | Search in current buffer |
| `<leader>s/` | Normal | Grep open files | Search across open files |
| `<leader>sn` | Normal | Search Neovim config | Find files in nvim config |
| `<C-d>` | Insert (Telescope) | Directory scope toggle | Freeze/change search directory |

##### LSP Keybindings (lines 610-651)

Configured via `LspAttach` autocmd, available when LSP is active:

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `gd` | Normal | Go to definition | Jump to definition |
| `gr` | Normal | Go to references | Find all references |
| `gI` | Normal | Go to implementation | Jump to implementation |
| `gD` | Normal | Go to declaration | Jump to declaration (e.g., C header) |
| `<leader>D` | Normal | Type definition | Show type definition |
| `<leader>ds` | Normal | Document symbols | List symbols in file |
| `<leader>ws` | Normal | Workspace symbols | List symbols in workspace |
| `<leader>rn` | Normal | Rename symbol | Rename variable/function |
| `<leader>ca` | Normal/Visual | Code action | Execute LSP code action |
| `<leader>oi` | Normal | Organize imports | Organize/sort imports |
| `<leader>th` | Normal | Toggle inlay hints | Show/hide type hints |

##### Completion (nvim-cmp) (lines 945-989)

Active in Insert mode:

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-n>` | Insert | Next item | Select next completion |
| `<C-p>` | Insert | Previous item | Select previous completion |
| `<C-y>` | Insert | Confirm | Accept completion |
| `<C-Space>` | Insert | Trigger completion | Manually open completion |
| `<C-b>` | Insert | Scroll docs back | Scroll documentation up |
| `<C-f>` | Insert | Scroll docs forward | Scroll documentation down |
| `<C-l>` | Insert/Select | Snippet jump forward | Move to next snippet field |
| `<C-h>` | Insert/Select | Snippet jump back | Move to previous snippet field |

##### Formatting (lines 850-856)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>f` | Normal/Visual | Format buffer | Run formatter (async) |

#### Plugin-Specific Keybindings

##### Neo-tree File Explorer (`kickstart/plugins/neo-tree.lua`)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-e>` | Normal | Toggle file tree | Open/close Neo-tree |
| `<C-e>` | Normal (in Neo-tree) | Close Neo-tree | Close file tree |

##### Git Signs (`kickstart/plugins/gitsigns.lua`)

**Navigation:**
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `]c` | Normal | Next change | Jump to next git hunk |
| `[c` | Normal | Previous change | Jump to previous git hunk |

**Hunk Actions:**
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>hs` | Normal | Stage hunk | Stage hunk under cursor |
| `<leader>hs` | Visual | Stage selection | Stage selected lines |
| `<leader>hr` | Normal | Reset hunk | Undo hunk under cursor |
| `<leader>hr` | Visual | Reset selection | Undo selected lines |
| `<leader>hS` | Normal | Stage buffer | Stage entire file |
| `<leader>hR` | Normal | Reset buffer | Reset entire file |
| `<leader>hu` | Normal | Undo stage | Undo last staging |
| `<leader>hp` | Normal | Preview hunk | Show hunk diff |
| `<leader>hb` | Normal | Blame line | Show git blame |
| `<leader>hd` | Normal | Diff index | Diff against index |
| `<leader>hD` | Normal | Diff HEAD | Diff against last commit |

**Toggles:**
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>tb` | Normal | Toggle blame | Show/hide inline blame |
| `<leader>tD` | Normal | Toggle deleted | Show/hide deleted lines |

##### Debug Adapter Protocol (`kickstart/plugins/debug.lua`)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<F5>` | Normal | Start/Continue | Begin or continue debugging |
| `<F1>` | Normal | Step into | Step into function |
| `<F2>` | Normal | Step over | Step over line |
| `<F3>` | Normal | Step out | Step out of function |
| `<leader>b` | Normal | Toggle breakpoint | Add/remove breakpoint |
| `<leader>B` | Normal | Conditional breakpoint | Set breakpoint with condition |
| `<F7>` | Normal | Toggle debug UI | Show/hide debug interface |

##### LazyGit (`custom/plugins/init.lua`)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>gg` | Normal | Open LazyGit | Launch LazyGit TUI |

### Plugin Ecosystem

#### Complete Plugin List (from lazy-lock.json)

The configuration has **32 plugins** installed:

**Core Infrastructure:**
1. `lazy.nvim` - Plugin manager
2. `plenary.nvim` - Lua utility library (dependency)
3. `nui.nvim` - UI component library (dependency)

**Editor Enhancement:**
4. `vim-sleuth` - Auto-detect indentation
5. `mini.nvim` - Collection of mini plugins (ai, surround, statusline)
6. `which-key.nvim` - Keybinding help popup
7. `nvim-web-devicons` - File icons

**LSP & Completion:**
8. `nvim-lspconfig` - LSP configuration
9. `mason.nvim` - LSP/tool installer
10. `mason-lspconfig.nvim` - Bridge between Mason and lspconfig
11. `nvim-cmp` - Completion engine
12. `cmp-nvim-lsp` - LSP completion source
13. `cmp-path` - Path completion source
14. `cmp_luasnip` - Snippet completion source
15. `LuaSnip` - Snippet engine
16. `lazydev.nvim` - Neovim Lua API completion
17. `luvit-meta` - Lua uv types
18. `fidget.nvim` - LSP progress notifications

**Code Quality:**
19. `conform.nvim` - Formatting (stylua, prettier)
20. `nvim-lint` - Linting (markdownlint)

**Syntax & Parsing:**
21. `nvim-treesitter` - Syntax highlighting & parsing

**Fuzzy Finding:**
22. `telescope.nvim` - Fuzzy finder framework
23. `telescope-fzf-native.nvim` - FZF sorter for Telescope
24. `telescope-ui-select.nvim` - Use Telescope for vim.ui.select

**Git Integration:**
25. `gitsigns.nvim` - Git decorations & utilities
26. `lazygit.nvim` - LazyGit integration

**Navigation & UI:**
27. `neo-tree.nvim` - File explorer
28. `vim-tmux-navigator` - Tmux/split navigation

**Themes:**
29. `tokyonight.nvim` - Tokyo Night theme (default: night variant)
30. `catppuccin` - Catppuccin theme (light: latte variant)

**Specialized:**
31. `todo-comments.nvim` - Highlight TODO comments
32. `render-markdown.nvim` - Enhanced markdown rendering

#### LSP Servers Configured (lines 734-785)

**Active Servers:**
- `clangd` - C/C++
- `lua_ls` - Lua (with Neovim API support)
- `ts_ls` - TypeScript/JavaScript
- `eslint` - JavaScript/TypeScript linting

**Formatters (conform.nvim, lines 876-887):**
- `stylua` - Lua
- `prettier` - JavaScript, TypeScript, JSX, TSX

**Format on Save**: Enabled for all filetypes except C/C++ (lines 860-875)

**Linters (nvim-lint):**
- `markdownlint` - Markdown

#### Debug Adapters (debug.lua)

**Configured Debuggers:**
- `delve` - Go debugger (auto-installed via Mason)

**Features:**
- Automatic DAP UI management
- Breakpoint configuration with conditions
- Platform-specific settings (detached mode handling for Windows)

### Theme Configuration

**Default Theme**: Tokyo Night (night variant) - lines 1014-1018
**Alternative Theme**: Catppuccin Latte (light) - lines 1025-1029

**Theme Switching**:
- `<leader>tl` - Switch to light theme (Catppuccin Latte)
- `<leader>td` - Switch to dark theme (Tokyo Night)
- `<leader>ta` - Browse all installed colorschemes via Telescope

**Comment Style**: Non-italic comments (`vim.cmd.hi 'Comment gui=none'` - line 1021)

### Custom Telescope Features

#### Directory Scope Management (lines 384-460)

The configuration implements a custom directory scoping feature for Telescope:

**Feature**: `<C-d>` in Telescope picker
- **First press**: Prompts for directory → freezes search to that directory
- **When frozen**:
  - Enter new path → changes scope and stays frozen
  - Press Escape → keeps current scope, reopens picker
  - Empty input → unfreezes, returns to project-wide search
- **State persistence**: Remembered across searches within session

**Configuration**:
- Follows symlinks (`follow = true`)
- Shows hidden files (`hidden = true`)
- Ignores `.git/` and `node_modules/` directories

### Autocommands & Auto-behaviors

**Text Yank Highlight** (lines 223-229):
- Briefly highlights yanked text
- Autocommand group: `kickstart-highlight-yank`

**Format on Save** (lines 860-875):
- Automatically formats files on save
- Timeout: 500ms
- Disabled for C/C++ (no standard style)
- Falls back to LSP formatting when no formatter configured

**Lint Triggers** (lines 44-57 in lint.lua):
- `BufEnter` - Entering a buffer
- `BufWritePost` - After saving
- `InsertLeave` - Exiting insert mode
- Skips non-modifiable buffers (prevents linting in help/popup windows)

**Diagnostic Configuration** (lines 698-706):
- Virtual text enabled (inline error messages)
- Underlines for diagnostics
- Gutter signs enabled
- Sorted by severity
- No updates during insert mode

### Integration with Other Dotfiles

This Neovim configuration maintains consistency with other editor configurations in the repository:

**Shared Patterns:**
1. **Leader Key**: Space used across Neovim, IdeaVim, and Cursor
2. **Window Navigation**: `Ctrl+hjkl` consistent across Neovim, tmux, and IdeaVim
3. **Search Prefix**: `Space+s*` pattern for search operations
4. **LSP Actions**: `Space+g*` for goto operations, `Space+r*` for refactoring
5. **Tmux Integration**: Seamless navigation via vim-tmux-navigator matches tmux config

**Referenced Files:**
- `tmux/.tmux.conf` - Contains complementary tmux configuration for unified navigation
- `ideavim/.ideavimrc` - IdeaVim configuration with similar keybinding philosophy
- `cursor/keybindings.json` - Cursor IDE vim mode configuration

## Code References

- Main configuration: `nvim/.config/nvim/init.lua:1-1148`
- Leader key definition: `nvim/.config/nvim/init.lua:90-91`
- LSP configuration: `nvim/.config/nvim/init.lua:538-842`
- Telescope setup: `nvim/.config/nvim/init.lua:360-536`
- Plugin list: `nvim/.config/nvim/init.lua:255-1144`
- Kickstart plugins: `nvim/.config/nvim/lua/kickstart/plugins/*`
- Custom plugins: `nvim/.config/nvim/lua/custom/plugins/init.lua:1-47`
- Lock file: `nvim/.config/nvim/lazy-lock.json:1-34`

## Architecture Documentation

### Design Philosophy

**Kickstart Approach**: The configuration explicitly follows Kickstart.nvim's philosophy:
1. **Educational**: Every line documented with comments explaining why
2. **Single-file**: Core configuration in one readable file (init.lua)
3. **Modular Extensions**: Optional plugins in separate files
4. **Not a Distribution**: A starting point for personalization

### Loading Performance

**Optimization Strategies**:
1. **Lazy Loading**: Most plugins deferred until needed
2. **Conditional Dependencies**: Icons only loaded if Nerd Font available
3. **Filetype-specific**: Markdown rendering only loads for `.md` files
4. **Command-based**: Heavy plugins (LazyGit, Neo-tree) load on command
5. **Event-driven**: Completion/formatting only when editing

### Extensibility Points

**Adding Custom Plugins**: Place files in `lua/custom/plugins/`
**Modifying Base Config**: Edit `init.lua` directly
**Adding LSP Servers**: Add to `servers` table (line 734)
**Adding Formatters**: Extend `formatters_by_ft` (line 876)
**Adding Linters**: Extend `linters_by_ft` (line 7 in lint.lua)

### Dependency Management

**Mason**: Centralized tool installation
- LSP servers: `:Mason` → select server → press `i`
- Formatters: Installed via Mason or package manager
- Linters: Installed via Mason or package manager
- Debug adapters: Auto-installed via `mason-nvim-dap`

**Version Locking**: `lazy-lock.json` pins exact commits for reproducibility

## Open Questions

None - this is a documentation of the existing configuration as it currently exists.

## Related Documentation

- Kickstart.nvim README: `nvim/.config/nvim/README.md`
- Kickstart documentation: `nvim/.config/nvim/doc/kickstart.txt`
- Repository README: `/Users/michallester/.dotfiles/CLAUDE.md`
- Project instructions: `/Users/michallester/.dotfiles/nvim/.config/nvim/CLAUDE.md`
