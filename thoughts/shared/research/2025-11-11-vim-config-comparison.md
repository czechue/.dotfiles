---
date: 2025-11-11 22:42:24 +0100
researcher: michallester
git_commit: 9eb0115fd15d4c1181bd5621c373d751f5fda0ce
branch: master
repository: .dotfiles
topic: "Comprehensive comparison of Neovim, IdeaVim, and Cursor IDE configurations"
tags: [research, codebase, nvim, ideavim, cursor, vim, keybindings, plugins, dotfiles]
status: complete
last_updated: 2025-11-11
last_updated_by: michallester
---

# Research: Vim Configuration Comparison Across Editors

**Date**: 2025-11-11 22:42:24 +0100
**Researcher**: michallester
**Git Commit**: 9eb0115fd15d4c1181bd5621c373d751f5fda0ce
**Branch**: master
**Repository**: .dotfiles

## Research Question

Comprehensive analysis of all keybindings, plugins, and configuration settings across three Vim-based editors: Neovim, IdeaVim (IntelliJ IDEA), and Cursor IDE. The goal is to document current consistency, identify gaps, and understand feature parity.

## Summary

The dotfiles repository maintains **excellent cross-editor consistency** across three different development environments. All three editors share:

- **Identical leader key** (`Space`)
- **Unified window navigation** (`Ctrl+hjkl`)
- **Consistent search patterns** (`<leader>s*`)
- **Matching LSP keymaps** (`<leader>g*`, `<leader>r*`)
- **Synchronized multi-cursor behavior** (`<C-g>`)

The configurations prioritize **muscle memory preservation** across different IDEs while leveraging each editor's native strengths (Tree-sitter in Neovim, IntelliJ's refactoring, Cursor's AI).

## Detailed Findings

### 1. Core Configuration Philosophy

All three editors follow the CLAUDE.md principle:
> "Vim Configuration Synchronization: The configurations for Neovim, IdeaVim, and Cursor must be kept as similar as possible to ensure consistent workflow across all editors."

#### Shared Core Settings
| Setting | Neovim | IdeaVim | Cursor |
|---------|--------|---------|--------|
| **Leader Key** | `Space` | `Space` | `Space` |
| **Clipboard** | `unnamedplus` | `unnamed,unnamedplus` | System clipboard |
| **Scroll Offset** | 10 | 10 | 10 |
| **Smart Case** | Enabled | Enabled | Enabled |
| **Incremental Search** | Enabled | Enabled | Enabled |
| **Highlight Search** | Enabled | N/A | Enabled |
| **Timeout** | 300ms | 5000ms | 5000ms |

---

### 2. Keybinding Analysis

#### 2.1 Window Navigation (Perfect Parity)

All three editors use **identical** window navigation:

```vim
<C-h>  " Navigate to left window/pane
<C-j>  " Navigate to window below
<C-k>  " Navigate to window above
<C-l>  " Navigate to right window/pane
```

**Files:**
- Neovim: `nvim/.config/nvim/init.lua:199-202`
- IdeaVim: `ideavim/.ideavimrc:27-31`
- Cursor: `cursor/settings.json:28-43`

**Additional Neovim Feature**: Seamless tmux integration via `vim-tmux-navigator` plugin allows these same keybindings to navigate between Vim windows AND tmux panes.

#### 2.2 Window Management (Consistent Pattern)

All editors use `<leader>w*` prefix:

| Action | Neovim | IdeaVim | Cursor |
|--------|--------|---------|--------|
| **Split Vertically** | N/A (Vim default) | `<leader>wv` | `<leader>wv` |
| **Split Horizontally** | N/A (Vim default) | `<leader>wh` | `<leader>wh` |
| **Close Split** | N/A | `<leader>ww` | `<leader>ww` |
| **Close All Splits** | N/A | `<leader>wa` | `<leader>wa` |

**Note**: Neovim relies on Vim's default split commands (`:split`, `:vsplit`) but could add these keymaps for consistency.

#### 2.3 Search and Navigation (Telescope-style)

All editors implement `<leader>s*` search prefix with identical semantics:

| Key | Neovim (Telescope) | IdeaVim (IntelliJ) | Cursor (VSCode) |
|-----|-------------------|-------------------|-----------------|
| `<leader>sf` | Find files | `GotoFile` | `quickOpen` |
| `<leader>sg` | Live grep | `FindInPath` | `findInFiles` |
| `<leader>ss` | Document symbols | `GotoSymbol` | `gotoSymbol` |
| `<leader>sa` | Command palette | `GotoAction` | `showCommands` |
| `<leader>sd` | Diagnostics | `ShowErrorDescription` | `showHover` |
| `<leader>sr` | Recent files | `RecentFiles` | `openRecent` |

**Additional Neovim Bindings** (Telescope-specific):
- `<leader>sh` - Search help tags
- `<leader>sk` - Search keymaps
- `<leader>sw` - Search current word
- `<leader>s.` - Recent files (oldfiles)
- `<leader>/` - Fuzzy find in current buffer
- `<leader>s/` - Live grep in open files only
- `<leader>sn` - Search Neovim config files

**Files:**
- Neovim: `nvim/.config/nvim/init.lua:440-475`
- IdeaVim: `ideavim/.ideavimrc:40-45`
- Cursor: `cursor/settings.json:64-87`

#### 2.4 LSP Operations (Cross-editor Standard)

All editors use `<leader>g*` for "goto" operations and `<leader>r*` for refactoring:

| Operation | Key | Neovim | IdeaVim | Cursor |
|-----------|-----|--------|---------|--------|
| **Go to Definition** | `gd` or `<leader>gd` | `gd` | `<leader>gd` | `<leader>gd` |
| **Go to Type Definition** | `<leader>gy` | `<leader>D` | `<leader>gy` | `<leader>gy` |
| **Go to Implementation** | `<leader>gi` | `gI` | `<leader>gi` | `<leader>gi` |
| **Go to Test** | `<leader>gt` | N/A | `<leader>gt` | `<leader>gt` |
| **Go to References** | `gr` | `gr` | N/A | N/A |
| **Rename Symbol** | `<leader>rn` | `<leader>rn` | `<leader>rn` | `<leader>rn` |
| **Code Actions** | `<leader>ca` | `<leader>ca` | `<leader>ca` | `<leader>ca` |

**Notable Differences:**
- Neovim uses short forms (`gd`, `gr`, `gI`) following LSP conventions
- IdeaVim and Cursor use `<leader>g*` prefix for consistency
- Neovim: `<leader>D` for type definition (capital D)
- IdeaVim/Cursor: `<leader>gy` for type definition

**Files:**
- Neovim: `nvim/.config/nvim/init.lua:554-586`
- IdeaVim: `ideavim/.ideavimrc:48-52`
- Cursor: `cursor/settings.json:90-109`

#### 2.5 Code Formatting and Actions

All editors use `<leader><leader>` for formatting:

| Action | Neovim | IdeaVim | Cursor |
|--------|--------|---------|--------|
| **Format Document** | `<leader>f` | `<leader><leader>` | `<leader><leader>` |
| **Organize Imports** | N/A | `<leader>oi` | `<leader>oi` |
| **Refactor Menu** | N/A | `<leader>rm` | `<leader>rm` |
| **Extract Method** | N/A | `<leader>rm` | (via `<leader>rm`) |
| **Extract Variable** | N/A | `<leader>rv` | (via `<leader>rm`) |
| **Extract Field** | N/A | `<leader>rf` | (via `<leader>rm`) |

**Note**: Neovim uses `<leader>f` instead of `<leader><leader>` for formatting. Consider harmonizing this.

**Files:**
- Neovim: `nvim/.config/nvim/init.lua:737-743`
- IdeaVim: `ideavim/.ideavimrc:73-74`
- Cursor: `cursor/settings.json:147-152`

#### 2.6 Multiple Cursors (Perfect Synchronization)

All three editors use **identical** multicursor keybindings:

| Action | Key | Neovim | IdeaVim | Cursor |
|--------|-----|--------|---------|--------|
| **Add Next Occurrence** | `<C-g>` | ✅ | ✅ | ✅ |
| **Select All Occurrences** | `<leader><C-g>` | ✅ | ✅ | ✅ |
| **Skip Occurrence** | `<C-x>` (visual) | N/A | ✅ | ✅ |
| **Remove Cursor** | `<C-p>` (visual) | N/A | ✅ | N/A |
| **Undo Cursor** | `<C-x>` (visual) | N/A | N/A | ✅ |

**Implementation:**
- **Neovim**: `smoka7/multicursors.nvim` (modern, Hydra-based)
- **IdeaVim**: `terryma/vim-multiple-cursors` (classic plugin)
- **Cursor**: Native VSCode multicursor API

**Files:**
- Neovim: `nvim/.config/nvim/lua/custom/plugins/init.lua:6-20`
- IdeaVim: `ideavim/.ideavimrc:17,80-94`
- Cursor: `cursor/settings.json:155-189`

**Historical Note**: Recently migrated Neovim from `vim-visual-multi` to `multicursors.nvim` due to configuration issues with Neovim 0.11.

#### 2.7 Text Manipulation

All editors use `Shift+j/k` in visual mode to move lines:

```vim
Visual mode:
<S-j>  " Move selected lines down
<S-k>  " Move selected lines up
```

**Files:**
- Neovim: `nvim/.config/nvim/init.lua:169-170`
- IdeaVim: `ideavim/.ideavimrc:77-78`
- Cursor: `cursor/settings.json:168-175`

#### 2.8 File Operations

Common pattern across all editors:

| Action | Key | All Editors |
|--------|-----|-------------|
| **Close Current File** | `<leader>qq` | ✅ |
| **Close All Files** | `<leader>qa` | ✅ |
| **New File** | `<leader>nf` | ✅ |
| **New Directory** | `<leader>nd` | IdeaVim only |

#### 2.9 Error/Diagnostic Navigation

Consistent across editors:

```vim
<leader>en  " Next error/diagnostic
<leader>ep  " Previous error/diagnostic
```

**Additional Neovim**:
- `<leader>q` - Open quickfix list with diagnostics
- `<leader>sd` - Search all diagnostics with Telescope

#### 2.10 File Explorer Toggle

All editors use `<C-e>` to toggle file tree:

- **Neovim**: Neo-tree (`:Neotree reveal`)
- **IdeaVim**: NERDTree + IntelliJ Project Tool Window
- **Cursor**: VSCode Explorer (`workbench.view.explorer`)

**Files:**
- Neovim: `nvim/.config/nvim/lua/kickstart/plugins/neo-tree.lua`
- IdeaVim: `ideavim/.ideavimrc:25`
- Cursor: `cursor/keybindings.json:8-12`

#### 2.11 Theme Switching (Neovim-only)

Neovim includes theme toggle keybindings not present in other editors:

```vim
<leader>tl  " Switch to light theme (catppuccin-latte)
<leader>td  " Switch to dark theme (tokyonight-night)
<leader>th  " Toggle inlay hints (LSP)
```

**File**: `nvim/.config/nvim/init.lua:205-211,622-624`

#### 2.12 IntelliJ-style Shortcuts (Cursor-only)

Cursor includes additional IntelliJ-style keybindings via `keybindings.json`:

| Key | Action | Description |
|-----|--------|-------------|
| `Cmd+I` | `composerMode.agent` | Open AI Composer |
| `Shift+Space` | `triggerSuggest` | Show completions (IntelliJ-style) |
| `Cmd+1` | `toggleSidebarVisibility` | Toggle sidebar |
| `Cmd+Shift+R` | `replaceInFiles` | Global replace |
| `Cmd+Right` | `acceptNextWord` | Accept next word of AI suggestion |
| `Cmd+Shift+Right` | `acceptNextLine` | Accept next line of AI suggestion |
| `Ctrl+K Ctrl+D` | `moveSelectionToNextFindMatch` | Skip and go to next (multicursor) |
| `Cmd+Shift+L` | `selectHighlights` | Select all occurrences |

**File**: `cursor/keybindings.json`

---

### 3. Plugin and Extension Ecosystem

#### 3.1 Neovim Plugins (29 total)

**Plugin Manager**: lazy.nvim

##### Core Functionality
- `tpope/vim-sleuth` - Auto-detect indentation

##### UI/UX
- `folke/which-key.nvim` - Keybinding hints
- `folke/tokyonight.nvim` - Dark colorscheme (default)
- `catppuccin/nvim` - Light/dark colorscheme
- `echasnovski/mini.nvim` (statusline) - Minimalist status bar
- `nvim-tree/nvim-web-devicons` - File type icons

##### Search & Navigation
- `nvim-telescope/telescope.nvim` - Fuzzy finder
- `nvim-telescope/telescope-fzf-native.nvim` - FZF sorter
- `nvim-telescope/telescope-ui-select.nvim` - UI picker override
- `nvim-neo-tree/neo-tree.nvim` - File explorer

##### LSP
- `neovim/nvim-lspconfig` - LSP client configuration
- `williamboman/mason.nvim` - LSP/tool installer
- `williamboman/mason-lspconfig.nvim` - Mason-LSP bridge
- `j-hui/fidget.nvim` - LSP progress UI
- `folke/lazydev.nvim` - Lua development for Neovim
- `Bilal2453/luvit-meta` - Lua type definitions

##### Completion
- `hrsh7th/nvim-cmp` - Completion engine
- `L3MON4D3/LuaSnip` - Snippet engine
- `saadparwaiz1/cmp_luasnip` - LuaSnip source for nvim-cmp
- `hrsh7th/cmp-nvim-lsp` - LSP completion source
- `hrsh7th/cmp-path` - Path completion source

##### Formatting
- `stevearc/conform.nvim` - Formatter with auto-format on save

##### Syntax
- `nvim-treesitter/nvim-treesitter` - Syntax highlighting via AST

##### Text Manipulation
- `echasnovski/mini.nvim` (mini.ai) - Enhanced text objects
- `echasnovski/mini.nvim` (mini.surround) - Surround operations
- `smoka7/multicursors.nvim` - Multiple cursors
- `nvimtools/hydra.nvim` - Sub-modes (dependency for multicursors)

##### Git
- `lewis6991/gitsigns.nvim` - Git change indicators
- `folke/todo-comments.nvim` - Highlight TODO/FIXME/etc

##### Tmux Integration
- `christoomey/vim-tmux-navigator` - Seamless Vim-tmux navigation

##### Utilities
- `nvim-lua/plenary.nvim` - Lua utility library
- `MunifTanjim/nui.nvim` - UI component library

**Configuration Files:**
- `nvim/.config/nvim/init.lua` (main config)
- `nvim/.config/nvim/lua/custom/plugins/init.lua` (custom plugins)
- `nvim/.config/nvim/lua/kickstart/plugins/*.lua` (modular plugins)

#### 3.2 IdeaVim Plugins (5 total)

**Plugin System**: IdeaVim's Plug system

| Plugin | Purpose | Neovim Equivalent |
|--------|---------|-------------------|
| `machakann/vim-highlightedyank` | Highlight yanked text | Built-in (autocmd) |
| `tpope/vim-commentary` | Comment/uncomment | Built-in (Neovim 0.10+) |
| `preservim/nerdtree` | File tree explorer | neo-tree |
| `tpope/vim-surround` | Surround operations | mini.surround |
| `terryma/vim-multiple-cursors` | Multiple cursors | multicursors.nvim |

**Configuration File**: `ideavim/.ideavimrc`

#### 3.3 Cursor IDE Configuration

Cursor uses **native VSCode features** rather than extensions. Configuration via `settings.json` enables:

| Feature | Equivalent in Neovim | Equivalent in IdeaVim |
|---------|---------------------|----------------------|
| Vim emulation | Native | Native |
| Vim-surround | mini.surround | vim-surround |
| Window navigation | Built-in + tmux-navigator | Built-in |
| LSP | nvim-lspconfig | IntelliJ Platform LSP |
| Completion | nvim-cmp | IntelliJ completion |
| Multicursor | multicursors.nvim | vim-multiple-cursors |
| File explorer | neo-tree | NERDTree |
| Search | Telescope | IntelliJ Search Everywhere |
| Git indicators | gitsigns | IntelliJ VCS |
| AI assistance | External (Copilot) | IntelliJ AI Assistant |
| **Native AI** | N/A | N/A |

**Unique Cursor Features:**
- Native AI code generation (Composer mode)
- Partial AI suggestion accepts (word/line)
- Integrated AI chat with codebase context

**Configuration Files:**
- `cursor/settings.json` (main settings + Vim keybindings)
- `cursor/keybindings.json` (non-Vim keybindings)

---

### 4. Feature Parity Matrix

| Feature Category | Neovim | IdeaVim | Cursor |
|-----------------|--------|---------|--------|
| **Leader Key** | Space | Space | Space |
| **Window Nav** | `<C-hjkl>` | `<C-hjkl>` | `<C-hjkl>` |
| **Window Mgmt** | Vim defaults | `<leader>w*` | `<leader>w*` |
| **File Explorer** | Neo-tree | NERDTree | Built-in |
| **Fuzzy Find** | Telescope | IntelliJ | Quick Open |
| **LSP** | nvim-lspconfig | IntelliJ | VSCode |
| **Completion** | nvim-cmp | IntelliJ | IntelliSense |
| **Formatting** | conform.nvim | IntelliJ | VSCode |
| **Syntax** | Tree-sitter | IntelliJ | TextMate |
| **Git Signs** | gitsigns | IntelliJ VCS | VSCode Git |
| **Multicursor** | multicursors.nvim | vim-multiple-cursors | Built-in |
| **Surround** | mini.surround | vim-surround | Native emulation |
| **Commenting** | Built-in | vim-commentary | Built-in |
| **Yank Highlight** | Built-in | vim-highlightedyank | Built-in |
| **Tmux Integration** | vim-tmux-navigator | N/A | N/A |
| **AI Assistance** | External | IntelliJ AI | **Native** |
| **Theme Switch** | `<leader>t*` | N/A | N/A |
| **Statusline** | mini.statusline | IntelliJ | VSCode |

**Legend:**
- ✅ **Perfect Parity**: Feature available with same/similar keybindings
- ⚠️ **Partial Parity**: Feature available but with different implementation
- ❌ **Missing**: Feature not available in this editor
- **Bold**: Unique strength of that editor

---

### 5. Configuration Architecture

#### 5.1 Neovim Architecture

**Base**: Kickstart.nvim (educational, single-file configuration)

**Structure**:
```
nvim/.config/nvim/
├── init.lua                    # Main config (1034 lines)
├── lazy-lock.json              # Plugin versions
└── lua/
    ├── kickstart/plugins/
    │   ├── neo-tree.lua        # File explorer
    │   └── nvim-tmux-navigator.lua  # Tmux integration
    └── custom/plugins/
        └── init.lua            # Custom plugins (multicursors)
```

**Philosophy**:
- Educational comments throughout
- Single-file core with optional modular extensions
- Users expected to understand every line
- Follows Neovim 0.11+ conventions

**Key Characteristics**:
- Lazy loading via `lazy.nvim`
- LSP via `vim.lsp.config()` (Neovim 0.11+)
- Auto-install language servers via Mason
- Format on save (except C/C++)
- Telescope as universal interface
- Tree-sitter for syntax

**File**: `nvim/.config/nvim/init.lua`

#### 5.2 IdeaVim Architecture

**Structure**:
```
ideavim/
└── .ideavimrc                  # Single config file (104 lines)
```

**Philosophy**:
- Minimal configuration (leverages IntelliJ defaults)
- Focuses on keybinding harmonization
- Uses IntelliJ actions instead of reimplementing features
- Which-key integration for discoverability

**Key Characteristics**:
- 5 plugins (all focused on Vim emulation improvements)
- Delegates to IntelliJ for LSP, completion, refactoring
- No syntax highlighting config (uses IntelliJ)
- `<C-e>` activates IntelliJ Project Tool Window
- Mac-specific multicursor key mappings (avoids Alt key dead keys)

**File**: `ideavim/.ideavimrc`

#### 5.3 Cursor Architecture

**Structure**:
```
cursor/
├── settings.json              # Main config (201 lines)
└── keybindings.json           # Additional shortcuts (52 lines)
```

**Philosophy**:
- VSCode-based with Vim emulation layer
- Balances Vim keybindings with IDE productivity features
- Heavy use of AI-native features
- Maintains compatibility with VSCode ecosystem

**Key Characteristics**:
- Vim mode via `vim.*` settings in JSON
- Extensive `vim.normalModeKeyBindings` array
- `vim.handleKeys` exclusions for AI features
- Native multicursor (no plugin needed)
- IntelliJ-inspired keybindings (Shift+Space, Ctrl+E, Cmd+1)
- AI partial accepts for suggestions

**Files**:
- `cursor/settings.json` (Vim config + editor settings)
- `cursor/keybindings.json` (non-Vim shortcuts)

---

### 6. Language Server and Formatter Configuration

#### 6.1 Neovim LSP Servers

**Configured via**: `nvim-lspconfig` + `mason.nvim`

**Installed Servers**:
- `clangd` - C/C++
- `lua_ls` - Lua (configured for Neovim development)
- `ts_ls` - TypeScript/JavaScript

**Formatters** (via `conform.nvim`):
- `stylua` - Lua
- `prettier` - JavaScript/TypeScript/React

**Auto-format on save**: Enabled (500ms timeout)
**Disabled for**: C, C++

**File**: `nvim/.config/nvim/init.lua:655-688`

#### 6.2 IdeaVim LSP

Uses IntelliJ IDEA's native language servers and inspections. No explicit configuration needed in `.ideavimrc`.

#### 6.3 Cursor LSP

Uses VSCode's native LSP client. Language servers installed via VSCode extensions (not managed in dotfiles).

---

### 7. Identified Gaps and Inconsistencies

#### 7.1 Missing Keybindings

**Neovim Missing**:
- `<leader>wv/wh/ww/wa` - Window management shortcuts (uses Vim defaults)
- Could benefit from IdeaVim's explicit window management keys

**IdeaVim Missing**:
- `<leader>tl/td` - Theme switching (not applicable to IDEs)
- `<leader>/` - Fuzzy find in current buffer (could map to IntelliJ action)
- `<leader>s/` - Live grep in open files

**Cursor Missing**:
- `<leader>tl/td` - Theme switching (VSCode uses settings UI)
- `<leader>nd` - New directory command

#### 7.2 Different Key Choices

| Function | Neovim | IdeaVim | Cursor | Recommendation |
|----------|--------|---------|--------|----------------|
| **Format** | `<leader>f` | `<leader><leader>` | `<leader><leader>` | Standardize on `<leader><leader>` |
| **Go to Definition** | `gd` | `<leader>gd` | `<leader>gd` | Keep both (Neovim: `gd` is LSP standard) |
| **Type Definition** | `<leader>D` | `<leader>gy` | `<leader>gy` | Consider `<leader>gy` for all |

#### 7.3 Plugin Feature Gaps

**Neovim-only features**:
- `which-key.nvim` - Visual keybinding helper (IdeaVim has built-in which-key, Cursor doesn't)
- `vim-tmux-navigator` - Seamless tmux integration
- `todo-comments.nvim` - TODO highlighting in code
- Tree-sitter syntax highlighting

**IdeaVim-only features**:
- IntelliJ's advanced refactoring tools
- Database tools integration
- Generate code actions (constructors, getters, etc.)

**Cursor-only features**:
- Native AI composer mode
- Partial AI suggestion accepts
- Integrated codebase-aware AI chat

---

### 8. Code References

#### Neovim
- Main config: `nvim/.config/nvim/init.lua`
  - Core settings: lines 87-158
  - Basic keymaps: lines 160-212
  - Lazy.nvim setup: lines 228-238
  - Plugin definitions: lines 251-1031
  - Window navigation: lines 199-202
  - Telescope keymaps: lines 440-475
  - LSP configuration: lines 493-728
  - LSP keymaps: lines 554-586
  - Format keymap: lines 737-743
  - nvim-cmp keymaps: lines 832-879
  - Theme switching: lines 205-211
- Custom plugins: `nvim/.config/nvim/lua/custom/plugins/init.lua`
  - Multicursors: lines 6-20
- Neo-tree config: `nvim/.config/nvim/lua/kickstart/plugins/neo-tree.lua`
- Tmux navigator: `nvim/.config/nvim/lua/kickstart/plugins/nvim-tmux-navigator.lua`

#### IdeaVim
- Config file: `ideavim/.ideavimrc`
  - Basic settings: lines 1-10
  - Plugins: lines 12-17
  - Leader key: line 20
  - Which-key settings: lines 21-22
  - File explorer: line 25
  - Window navigation: lines 27-31
  - Window management: lines 33-37
  - Search mappings: lines 39-45
  - LSP operations: lines 47-52
  - Code actions: lines 54-60
  - Errors: lines 62-64
  - File operations: lines 66-70
  - Formatting: lines 72-74
  - Text manipulation: lines 76-78
  - Multicursor: lines 80-94
  - Which-key descriptions: lines 96-103

#### Cursor
- Settings: `cursor/settings.json`
  - Vim configuration: lines 6-23
  - Window navigation: lines 26-43
  - Window management: lines 45-61
  - Search mappings: lines 63-87
  - LSP operations: lines 89-109
  - Code actions: lines 111-119
  - Errors: lines 121-129
  - File operations: lines 131-143
  - Formatting: lines 145-153
  - Multicursor (normal): lines 155-163
  - Visual mode keybindings: lines 166-190
  - AI settings: lines 194-200
- Keybindings: `cursor/keybindings.json`
  - Composer mode: lines 3-6
  - Project explorer: lines 8-12
  - IntelliJ-style shortcuts: lines 14-51

---

## Architecture Documentation

### Keybinding Organization Philosophy

All three editors follow a **mnemonic prefix system**:

| Prefix | Meaning | Examples |
|--------|---------|----------|
| `<leader>s*` | **Search** | `sf`=files, `sg`=grep, `ss`=symbols |
| `<leader>g*` | **Goto** | `gd`=definition, `gy`=type, `gi`=implementation |
| `<leader>r*` | **Refactor** | `rn`=rename, `rm`=extract method, `rv`=extract variable |
| `<leader>w*` | **Window** | `wv`=split vertical, `wh`=split horizontal, `ww`=close split |
| `<leader>q*` | **Quit** | `qq`=close file, `qa`=close all |
| `<leader>n*` | **New** | `nf`=new file, `nd`=new directory |
| `<leader>e*` | **Errors** | `en`=next error, `ep`=previous error |
| `<leader>t*` | **Theme/Toggle** | `tl`=light theme, `td`=dark theme, `th`=toggle hints |
| `<leader>o*` | **Organize** | `oi`=organize imports |
| `<leader>c*` | **Code** | `ca`=code action |
| `<leader>d*` | **Document/Diagnostics** | `ds`=document symbols, `sd`=search diagnostics |

This creates a **self-documenting** keybinding system where the first letter after leader indicates the category.

### Window Navigation Philosophy

All editors use `<C-hjkl>` for window navigation because:
1. **Muscle Memory**: Same keys as Vim motion (`hjkl`)
2. **Universal**: Works in Neovim, IdeaVim, Cursor, AND tmux (via vim-tmux-navigator)
3. **No Conflicts**: Ctrl+hjkl rarely used by other applications
4. **Ergonomic**: No reaching for arrow keys

### Multicursor Philosophy

`<C-g>` chosen for multicursor because:
1. **IntelliJ-inspired**: Matches IntelliJ IDEA's default (commonly known to developers)
2. **Available**: Ctrl+G traditionally shows file status in Vim (low-value command)
3. **Mnemonic**: "G" for "get next occurrence"
4. **Consistent**: Same binding across all three editors

---

## Open Questions

1. **Should Neovim adopt `<leader>wv/wh/ww/wa` for window management** to match IdeaVim and Cursor?
   - Pro: Complete parity across editors
   - Con: Vim users may prefer standard `:split`/`:vsplit`

2. **Should formatting be standardized on `<leader><leader>` or `<leader>f`?**
   - Current: Neovim uses `<leader>f`, others use `<leader><leader>`
   - Consideration: `<leader><leader>` conflicts with Neovim's "find buffers" binding

3. **Should go-to-type-definition be `<leader>D` or `<leader>gy`?**
   - Current: Neovim uses `<leader>D`, others use `<leader>gy`
   - Neovim's `<leader>D` is harder to type (requires Shift)

4. **Should Cursor add theme toggle keymaps** like Neovim's `<leader>tl/td`?
   - Would require VSCode extension or settings integration

5. **Should IdeaVim emulate Telescope-specific bindings** like `<leader>/` and `<leader>s/`?
   - Could map to IntelliJ's equivalent actions

---

## Related Research

This is the first comprehensive configuration research document for this repository.

**Potential future research**:
- Snippet synchronization across all three editors
- Git workflow keybindings comparison
- Completion behavior comparison
- LSP configuration deep-dive
- Performance comparison (startup time, responsiveness)

---

## Conclusion

The dotfiles repository achieves **exceptional consistency** across three very different editors (terminal Neovim, IntelliJ-based IdeaVim, Electron-based Cursor). This allows seamless context-switching between editors while preserving muscle memory.

Key strengths:
- Perfect window navigation parity (`<C-hjkl>`)
- Consistent search patterns (`<leader>s*`)
- Unified LSP operations (`<leader>g*`, `<leader>r*`)
- Synchronized multicursor (`<C-g>`)
- Mnemonic keybinding organization

Minor inconsistencies (format key, window management) are acceptable trade-offs given each editor's native conventions and strengths.

The configuration follows the CLAUDE.md directive perfectly:
> "Always analyze and update the other configurations accordingly to maintain feature parity."
