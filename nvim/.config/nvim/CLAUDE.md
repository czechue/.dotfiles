# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Codebase Overview

This is a Neovim configuration based on Kickstart.nvim - a minimal, single-file configuration designed as a starting point for personal customization. The configuration uses Lua and the lazy.nvim plugin manager.

## Architecture

The configuration follows a single-file philosophy with modular extensions:

- **`init.lua`**: Main configuration file containing all core settings, keymaps, and plugin configurations
- **`lua/kickstart/plugins/`**: Optional modular plugin configurations that can be imported
- **`lua/custom/plugins/`**: User's custom plugin directory for personal additions

Key architectural decisions:
- Uses lazy.nvim for plugin management with automatic bootstrapping
- LSP support via nvim-lspconfig with Mason for automatic server installation
- Telescope for fuzzy finding across files, grep, and LSP symbols
- Tree-sitter for syntax highlighting with automatic parser installation
- nvim-cmp for autocompletion with LuaSnip for snippets

## Common Commands

### Plugin Management
- `:Lazy` - Open lazy.nvim UI to manage plugins
- `:Lazy sync` - Update all plugins
- `:Mason` - Manage LSP servers, formatters, and linters

### Development Commands
- `:checkhealth` - Verify Neovim setup and dependencies
- `<leader>f` - Format current buffer (if formatter available)
- `:Telescope` - Access fuzzy finder commands

### Key Mappings Reference
- Leader key: `<space>`
- `<leader>sh` - Search help
- `<leader>sf` - Search files
- `<leader>sg` - Search by grep
- `<leader>sd` - Search diagnostics
- `Ctrl+e` - Toggle Neo-tree file explorer

## External Dependencies

Required for full functionality:
- `git`, `make`, `unzip`, C Compiler (`gcc`)
- `ripgrep` - For grep searching
- Clipboard tool (xclip/xsel/win32yank)
- Nerd Font (optional but recommended)
- Language-specific tools (npm for TypeScript, go for Golang, etc.)

## Code Style

The repository uses:
- Stylua for Lua formatting (160 column width, 2 space indentation)
- Format configuration in `.stylua.toml`

## Working with this Configuration

When modifying:
1. Core changes should go in `init.lua` unless creating a reusable module
2. New plugins can be added to `lua/custom/plugins/init.lua`
3. Follow the existing pattern of extensive documentation comments
4. Use `vim.keymap.set()` for keymaps and `vim.opt` for options
5. Maintain the educational nature with clear comments explaining functionality