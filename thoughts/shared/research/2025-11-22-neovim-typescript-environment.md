---
date: 2025-11-22T14:37:04.000Z
researcher: Claude
git_commit: 3099e108c89541429ae89f11dc87c130f204f505
branch: master
repository: .dotfiles
topic: "Neovim configuration for TypeScript development environment (ESLint, Prettier)"
tags: [research, codebase, neovim, typescript, eslint, prettier, lsp, formatting]
status: complete
last_updated: 2025-11-22
last_updated_by: Claude
---

# Research: Neovim configuration for TypeScript development environment (ESLint, Prettier)

**Date**: 2025-11-22T14:37:04.000Z
**Researcher**: Claude
**Git Commit**: 3099e108c89541429ae89f11dc87c130f204f505
**Branch**: master
**Repository**: .dotfiles

## Research Question
Analyze Neovim configuration with a focus on TypeScript development environment setup, including ESLint and Prettier integration.

## Summary

The Neovim configuration provides a sophisticated TypeScript development environment using a hybrid approach:
- **TypeScript Language Server (ts_ls)** provides IntelliSense, type checking, and code navigation
- **ESLint LSP Server** provides real-time linting with automatic fixes on save
- **Prettier via conform.nvim** handles code formatting
- **Two-phase formatting** with `<leader>f` runs Prettier first, then ESLint auto-fix

Key features:
- Real-time ESLint diagnostics as you type
- Automatic ESLint fixes on save
- Prettier formatting on save with 500ms timeout
- Manual format+fix with `<leader>f`
- LSP-based code navigation and refactoring
- Mason for tool installation management

## Detailed Findings

### TypeScript/JavaScript LSP Configuration

The configuration uses two LSP servers for TypeScript development:

#### TypeScript Language Server (`ts_ls`)
- **Location**: `nvim/.config/nvim/init.lua:762-769`
- **Command**: `typescript-language-server --stdio`
- **Filetypes**: `javascript`, `javascriptreact`, `typescript`, `typescriptreact`
- **Root detection**: Searches for `package.json`, `tsconfig.json`, `jsconfig.json`, or `.git`
- **Features**: Type checking, IntelliSense, code navigation, refactoring

#### ESLint Language Server
- **Location**: `nvim/.config/nvim/init.lua:770-802`
- **Command**: `vscode-eslint-language-server --stdio`
- **Configuration**:
  - `validate: 'on'` - Linting enabled
  - `run: 'onType'` - Real-time linting as you type
  - `workingDirectory.mode: 'auto'` - Monorepo support
- **Auto-fix on save**: BufWritePre autocmd triggers `source.fixAll.eslint` code action

### Formatting Configuration (conform.nvim)

Prettier integration is handled through the conform.nvim plugin:

- **Location**: `nvim/.config/nvim/init.lua:859-917`
- **Plugin**: `stevearc/conform.nvim`
- **Formatters by filetype** (lines 904-910):
  ```lua
  javascript = { 'prettier' }
  typescript = { 'prettier' }
  javascriptreact = { 'prettier' }
  typescriptreact = { 'prettier' }
  lua = { 'stylua' }
  ```
- **Format on save**: Automatic with 500ms timeout, LSP fallback if no formatter configured
- **Manual format keybinding**: `<leader>f` - Two-phase process:
  1. Runs Prettier formatter
  2. Waits 100ms, then runs ESLint auto-fix (JS/TS files only)

### Additional Linting (nvim-lint)

The nvim-lint plugin is configured but currently only used for Markdown:

- **Location**: `nvim/lua/kickstart/plugins/lint.lua`
- **Plugin**: `mfussenegger/nvim-lint`
- **Current configuration**: Only `markdownlint` for Markdown files
- **Note**: ESLint is handled via LSP, not nvim-lint

### Tool Installation (Mason)

Mason manages LSP servers and some formatters:

- **Location**: `nvim/.config/nvim/init.lua:811-842`
- **Ensured installations**:
  - All servers from `servers` table (includes `ts_ls`, `eslint`)
  - `stylua` formatter explicitly added
- **Installation path**: `~/.local/share/nvim/mason/bin/`
- **Note**: Prettier must be installed separately (npm/yarn)

### LSP Keymappings

Essential TypeScript development keybindings:

- **Navigation**:
  - `gd` - Go to definition (via Telescope)
  - `gr` - Go to references (via Telescope)
  - `gI` - Go to implementation
  - `<leader>D` - Type definition

- **Symbols**:
  - `<leader>ds` - Document symbols (current file)
  - `<leader>ws` - Workspace symbols (entire project)

- **Code Actions**:
  - `<leader>rn` - Rename symbol
  - `<leader>ca` - Code actions (quick fixes, refactors)
  - `<leader>oi` - Organize imports

- **Formatting**:
  - `<leader>f` - Format buffer + ESLint fix

- **Diagnostics**:
  - `<leader>q` - Open diagnostic quickfix list
  - `<leader>sd` - Search diagnostics (Telescope)

### Auto-completion Configuration

nvim-cmp provides intelligent code completion:

- **Location**: `nvim/.config/nvim/init.lua:955-1032`
- **Sources** (priority order):
  1. `lazydev` - Neovim Lua API
  2. `nvim_lsp` - LSP completions (TypeScript, ESLint)
  3. `luasnip` - Snippets
  4. `path` - File paths
- **Keybindings**:
  - `<C-n>/<C-p>` - Navigate completion menu
  - `<C-y>` - Confirm selection
  - `<C-Space>` - Manually trigger completion

## Code References

- [`nvim/.config/nvim/init.lua:762`](https://github.com/czechue/.dotfiles/blob/3099e108c89541429ae89f11dc87c130f204f505/nvim/.config/nvim/init.lua#L762) - TypeScript Language Server configuration
- [`nvim/.config/nvim/init.lua:770`](https://github.com/czechue/.dotfiles/blob/3099e108c89541429ae89f11dc87c130f204f505/nvim/.config/nvim/init.lua#L770) - ESLint Language Server configuration
- [`nvim/.config/nvim/init.lua:791`](https://github.com/czechue/.dotfiles/blob/3099e108c89541429ae89f11dc87c130f204f505/nvim/.config/nvim/init.lua#L791) - ESLint auto-fix on save implementation
- [`nvim/.config/nvim/init.lua:864`](https://github.com/czechue/.dotfiles/blob/3099e108c89541429ae89f11dc87c130f204f505/nvim/.config/nvim/init.lua#L864) - Manual format + ESLint fix keybinding
- [`nvim/.config/nvim/init.lua:888`](https://github.com/czechue/.dotfiles/blob/3099e108c89541429ae89f11dc87c130f204f505/nvim/.config/nvim/init.lua#L888) - Format on save configuration
- [`nvim/.config/nvim/init.lua:904`](https://github.com/czechue/.dotfiles/blob/3099e108c89541429ae89f11dc87c130f204f505/nvim/.config/nvim/init.lua#L904) - Formatter assignments by filetype
- [`nvim/.config/nvim/init.lua:613`](https://github.com/czechue/.dotfiles/blob/3099e108c89541429ae89f11dc87c130f204f505/nvim/.config/nvim/init.lua#L613) - LSP navigation keymaps
- [`nvim/.config/nvim/init.lua:644`](https://github.com/czechue/.dotfiles/blob/3099e108c89541429ae89f11dc87c130f204f505/nvim/.config/nvim/init.lua#L644) - Organize imports code action
- [`nvim/lua/kickstart/plugins/lint.lua:8`](https://github.com/czechue/.dotfiles/blob/3099e108c89541429ae89f11dc87c130f204f505/nvim/lua/kickstart/plugins/lint.lua#L8) - nvim-lint configuration

## Architecture Insights

### Two-Phase Formatting Pattern
The configuration implements a sophisticated two-phase formatting approach:
1. **Prettier** handles code structure and style formatting
2. **ESLint** handles code quality fixes and rule enforcement
This separation ensures proper formatting order and prevents conflicts.

### Hybrid Linting Strategy
- **ESLint via LSP**: Primary linting for JavaScript/TypeScript with real-time feedback
- **nvim-lint**: Available for other languages (currently only Markdown)
This allows language-specific optimization while maintaining a unified diagnostic display.

### Lazy Loading Optimization
All formatting/linting plugins use event-based lazy loading:
- conform.nvim loads on `BufWritePre`
- nvim-lint loads on `BufReadPre`/`BufNewFile`
- LSP servers load when relevant filetypes are opened
This improves Neovim startup time significantly.

### Monorepo Support
The ESLint configuration includes specific monorepo support:
- Auto-detects package boundaries with `workingDirectory.mode: 'auto'`
- Root detection walks up directory tree to find project markers
- Useful for projects with multiple packages/workspaces

## Recent Configuration Changes

Based on recent commits:

1. **commit 2d5995c**: Added ESLint auto-fix to `<leader>f` keybinding
2. **commit 4173d76**: Added ESLint auto-fix on save functionality
3. **commit ede0352**: Fixed LSP initialization for Neovim 0.11 compatibility
   - Changed from `vim.lsp.config()` to `lspconfig.setup()`
   - Resolved LSP attachment issues

These changes show active improvement of the TypeScript development experience.

## Configuration Patterns

### Pattern 1: LSP-Based Development
The configuration heavily leverages LSP for TypeScript development:
- Language features via ts_ls
- Linting via ESLint LSP
- Code actions for fixes and refactoring
- Unified diagnostic display

### Pattern 2: Tool Installation Management
Mason centralizes tool installation:
- Automatic installation of configured LSP servers
- UI for managing tool versions
- Consistent binary locations

### Pattern 3: Keybinding Consistency
Leader key patterns create memorable shortcuts:
- `<leader>s*` - Search operations
- `<leader>g*` - Git operations
- `<leader>r*` - Refactoring
- `<leader>c*` - Code actions

## Performance Considerations

1. **Real-time linting**: ESLint runs on every keystroke (`run: 'onType'`)
   - Provides immediate feedback
   - May impact performance on large files

2. **Format on save timeout**: 500ms timeout prevents hanging
   - Ensures save operation completes even if formatter fails

3. **Deferred ESLint fix**: 100ms delay after Prettier
   - Prevents race conditions
   - Ensures proper execution order

## Tool Dependencies

### Required External Tools
- **Node.js/npm**: For TypeScript and JavaScript tooling
- **typescript-language-server**: Installed via Mason
- **vscode-eslint-language-server**: Installed via Mason
- **prettier**: Must be installed separately (npm)
- **stylua**: Installed via Mason (for Lua formatting)

### Project Configuration Files
The tools look for these configuration files in projects:
- **ESLint**: `.eslintrc.js`, `.eslintrc.json`, `eslint.config.js`
- **Prettier**: `.prettierrc`, `.prettierrc.json`, `prettier.config.js`
- **TypeScript**: `tsconfig.json`, `jsconfig.json`

## Recommendations for Improvement

1. **Add Prettier to Mason ensure_installed**:
   ```lua
   vim.list_extend(ensure_installed, {
     'stylua',
     'prettier', -- Add this
   })
   ```

2. **Consider prettierd for faster formatting**:
   ```lua
   javascript = { 'prettierd', 'prettier', stop_after_first = true }
   ```
   This would use the faster prettierd daemon if available.

3. **Add TypeScript-specific snippets**:
   - Consider adding `rafamadriz/friendly-snippets` for better TypeScript snippets

4. **Configure inlay hints**:
   - TypeScript supports inlay hints for parameter names and types
   - Currently togglable with `<leader>th` but not enabled by default

## Open Questions

1. Why is Prettier not included in Mason's ensure_installed list?
   - Possibly to use project-local versions instead of global

2. Why is nvim-lint configured but not used for JavaScript/TypeScript?
   - ESLint LSP provides superior integration with auto-fix capabilities

3. Is the double ESLint fix (on save + manual format) intentional?
   - Appears to ensure fixes are always applied, even without manual formatting