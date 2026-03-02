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
- **ghostty/**: Ghostty terminal emulator configuration (Catppuccin Mocha, tmux-only multiplexing)
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
ln -sf ~/.dotfiles/ghostty/config ~/.config/ghostty/config
```

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

# Ghostty
# Restart Ghostty (config reloads on restart)
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

## Neovim-Specific Details

- **Plugin manager**: lazy.nvim with automatic bootstrapping
- **LSP**: nvim-lspconfig with Mason for server management (`:Mason`)
- **Fuzzy finding**: Telescope for files, grep, LSP symbols
- **Syntax highlighting**: Tree-sitter with auto parser installation
- **Completion**: nvim-cmp with LuaSnip
- **Configuration structure**: Single-file `init.lua` with modular plugins in `lua/kickstart/plugins/` and `lua/custom/plugins/`
- **Required dependencies**: git, make, unzip, C compiler, ripgrep, clipboard tool, Nerd Font (optional)

## Claude Code & PAI Integration

This dotfiles repository is integrated with Claude Code and PAI (Personal AI Infrastructure) for AI-assisted development workflows.

### Claude Code Aliases

Defined in `~/.claude/zshrc-aliases` (sourced from `.zshrc`):

```bash
# Launch Claude Code with latest version, skip permissions
alias cl="bun install -g @anthropic-ai/claude-code; claude --dangerously-skip-permissions"

# Launch Claude Code with resume, skip permissions
alias clr="bun install -g @anthropic-ai/claude-code; claude --dangerously-skip-permissions --resume"

# Launch Claude Code with resume (with permissions prompt)
alias clsr="bun install -g @anthropic-ai/claude-code; claude --resume"

# Claude Code usage reporting
alias ccusage="bunx ccusage"
alias ccu="bunx ccusage"
```

### MCP Server Configuration

Claude Code is configured with MCP servers in `~/.claude.json`:

- **context7**: Documentation lookup for libraries (via Upstash)
- **mcp-sequentialthinking-tools**: Extended thinking/reasoning capabilities
- **mcp-omnisearch**: Multi-source web search (Tavily, Brave, Perplexity, Jina AI, Firecrawl)

**To disable MCP servers temporarily:**
```bash
# Option 1: Use --disable-mcp flag
claude --disable-mcp

# Option 2: Rename mcpServers key in ~/.claude.json
# Change "mcpServers" to "mcpServersDisabled"
```

### PAI Directory Structure

- **PAI_DIR**: `~/.claude` → symlinked to `~/personal/Personal_AI_Infrastructure/.claude`
- Contains skills, tools, configuration, and session history
- Auto-loads CORE skill at session start with identity, preferences, and workflows
- Uses startup hook for automatic context loading

### Integration Points

- **Zsh**: Sources PAI aliases via `~/.claude/zshrc-aliases`
- **Git**: Multi-context workflow (personal vs work) managed via separate git configs
- **Package managers**: Prefers bun for JS/TS, uv for Python (per PAI conventions)
- **Session history**: Automatically captured in `${PAI_DIR}/History/`

## Development Guidelines

- Follow existing patterns within each tool's configuration
- Maintain vim-style navigation consistency across all tools
- When adding keybindings, check for conflicts with AeroSpace window manager
- Configuration files may contain Polish comments from original author
- Use conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`, `chore:`
- When working with Claude Code, reference PAI CORE skill for standards and workflows