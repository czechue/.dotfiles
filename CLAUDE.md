# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for managing development tool configurations on macOS. The repository uses a modular structure with separate directories for each tool and supports multi-context workflows (personal and work configurations).

## Key Components

- **aerospace/**: AeroSpace window manager (i3-like for macOS) configuration
- **nvim/**: Neovim configuration based on Kickstart.nvim with lazy.nvim plugin manager
- **tmux/**: Terminal multiplexer with vim-style navigation and custom keybindings
- **yazi/**: Terminal file manager with DuckDB plugin for CSV/data file preview
- **zsh/**: Zsh shell with zoxide and yazi wrapper
- **ideavim/**: IntelliJ IDEA Vim emulation
- **cursor/**: Cursor IDE with Vim mode and IntelliJ-style keybindings
- **claude/**: Claude Code CLI global configuration (CLAUDE.md, settings.json, MCP servers)
- **bin/**: Utility scripts (`tmux-sessionizer` for project switching with fzf)
- **.dotfiles-personal/**: Personal context git configuration
- **.dotfiles-fourthwall/**: Work context git configuration

## Configuration Management

### Initial Setup

All configurations use **manual symlinks** (no install scripts). When adding new configurations:

```bash
# General pattern:
ln -sf ~/.dotfiles/<tool>/config-file ~/.config/<tool>/config-file

# Existing symlinks:
ln -s ~/.dotfiles/ideavim/.ideavimrc ~/.ideavimrc
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/.dotfiles/aerospace/.config/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
ln -sf ~/.dotfiles/yazi ~/.config/yazi
ln -sf ~/.dotfiles/cursor/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
ln -sf ~/.dotfiles/cursor/keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json
```

### Claude Code Configuration

Claude Code uses a special sync workflow for MCP servers:

```bash
# Initial setup:
ln -sf ~/.dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/.dotfiles/claude/settings.json ~/.claude/settings.json

# After editing claude/mcp-servers.json:
~/.dotfiles/claude/sync-mcp.sh
# Restart Claude Code to load new MCP servers
```

**Why sync script?** The `~/.claude.json` file contains both MCP config AND runtime state (history, cache). We can't symlink the entire file without causing git conflicts. The sync script merges MCP servers from dotfiles into `~/.claude.json` while preserving runtime state. See `claude/README.md` for details.

### Reloading Configurations

```bash
# tmux
tmux source-file ~/.tmux.conf  # or C-b r from within tmux

# AeroSpace
# alt-shift-semicolon then r

# Neovim
# Restart Neovim or :source % on current file

# yazi
# Restart yazi

# zsh
source ~/.zshrc  # or open new terminal

# Cursor
# Settings reload automatically, full restart recommended

# Claude Code
# Restart CLI after config changes
```

## Architecture Patterns

### Vim Configuration Synchronization

**CRITICAL**: Neovim, IdeaVim, and Cursor configurations must be kept **as similar as possible** for consistent workflow. When modifying any vim setup, analyze and update the others to maintain feature parity.

**Shared keybindings:**
- Leader key: `Space`
- Window navigation: `Ctrl+hjkl`
- Search/navigation: `Space+s*` prefix (telescope-style)
- LSP actions: `Space+g*` prefix (go to definition, etc.)
- Refactoring: `Space+r*` prefix
- Code actions: `Space+c*` prefix

### Multi-Context Git Workflow

The repository supports personal vs work contexts via `.dotfiles-personal/` and `.dotfiles-fourthwall/` directories containing separate git configurations. This allows context-specific email addresses and commit settings.

### Modular Tool Structure

Each tool has its own directory. Adding/removing tools doesn't affect others. No monolithic installation scripts - maintain explicit symlinks for clarity and control.

### MCP Server Configuration

Configured servers: `context7`, `mcp-sequentialthinking-tools`, `mcp-omnisearch` (Tavily, Brave, Perplexity, Jina AI, Firecrawl). API keys in `claude/mcp-servers.json` are gitignored. Use `mcp-servers.json.template` for tracking structure.

## Neovim-Specific Details

- **Plugin manager**: lazy.nvim with automatic bootstrapping
- **LSP**: nvim-lspconfig with Mason for server management (`:Mason`)
- **Fuzzy finding**: Telescope for files, grep, LSP symbols
- **Syntax highlighting**: Tree-sitter with auto parser installation
- **Completion**: nvim-cmp with LuaSnip
- **Configuration structure**: Single-file `init.lua` with modular plugins in `lua/kickstart/plugins/` and `lua/custom/plugins/`
- **Required dependencies**: git, make, unzip, C compiler, ripgrep, clipboard tool, Nerd Font (optional)

## Development Guidelines

- Follow existing patterns within each tool's configuration
- Maintain vim-style navigation consistency across all tools
- When adding keybindings, check for conflicts with AeroSpace window manager
- Configuration files may contain Polish comments from original author
- Use conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`, `chore:`