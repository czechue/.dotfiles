# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for managing development tool configurations on macOS. The repository uses a modular structure with separate directories for each tool and supports multi-context workflows (personal and work configurations).

## Key Components

- **aerospace/**: AeroSpace window manager (i3-like for macOS) configuration
- **nvim/**: Neovim configuration based on Kickstart.nvim with lazy.nvim plugin manager
- **tmux/**: Terminal multiplexer with vim-style navigation and custom keybindings
- **herdr/**: Herdr terminal workspace manager for AI coding agents (tracked config is the annotated `herdr --default-config` output; note: default prefix `C-b` clashes with tmux)
- **yazi/**: Terminal file manager with DuckDB plugin for CSV/data file preview
- **zsh/**: Zsh shell with zoxide and yazi wrapper
- **ideavim/**: IntelliJ IDEA Vim emulation
- **cursor/**: Cursor IDE with Vim mode and IntelliJ-style keybindings
- **ghostty/**: Ghostty terminal emulator configuration (Catppuccin Mocha, tmux-only multiplexing)
- **bin/**: Utility scripts — `tmux-sessionizer` (project switching with fzf, `C-f`), `herdr-sessionizer` (same picker for Herdr workspaces, `C-f` inside Herdr), `tmux-worktreeizer` (git worktree launcher, `prefix W`: creates a sibling `../<repo>-<branch>` worktree and opens a tmux session in it, integrated with the claude session pickers), and git subcommands (`git-<name>` scripts auto-discovered by git via PATH; third-party ones like `git-open` are vendored with a provenance header — see `docs/tools/git.md`)
- **claude/**: Claude Code configuration — `settings.json` and global `CLAUDE.md` symlinked into `~/.claude`, plus `system-prompt.md` passed on the command line
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
ln -sf ~/.dotfiles/herdr/config.toml ~/.config/herdr/config.toml  # file only — ~/.config/herdr/ also holds sockets/logs
ln -sf ~/.dotfiles/bin/herdr-sessionizer ~/.local/bin/herdr-sessionizer
ln -sf ~/.dotfiles/claude/settings.json ~/.claude/settings.json  # Claude Code (~/.claude must be a real dir, not a symlink)
ln -sf ~/.dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/.dotfiles/bin/git-open ~/bin/git-open
ln -sf ~/.dotfiles/bin/git-recent ~/bin/git-recent
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

# Herdr
herdr server reload-config  # or prefix + Shift-R from within Herdr

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

## Claude Code

One clean setup, tracked in `claude/` and symlinked into `~/.claude` (the default config dir). Full details in `docs/tools/claude-code.md`.

### Launchers

Defined in `zsh/.zshrc`. All use the default config dir, so they share one `settings.json`, one history and one login.

```bash
cl        # self-update, then claude --dangerously-skip-permissions
ccl       # alias of cl
clr       # cl --resume
clsr      # claude --resume, with permission prompts
ccusage   # usage reporting (alias: ccu)
```

`cl`, `clr` and `clsr` all pass `--append-system-prompt-file claude/system-prompt.md` — a vendored communication-style prompt from `disler/fixing-smartass-opus-5`. It is a CLI flag, not config, so a bare `claude` does not get it.

### Global config must stay in this repo

`~/.claude` and `~/.claude.json` are real files and directories, not symlinks elsewhere. Keep them that way. `CLAUDE_CONFIG_DIR` does not redirect the user-level `CLAUDE.md` — it is always read from `~/.claude/CLAUDE.md` — so pointing `~/.claude` at another AI-config repo leaks that repo's instructions into every session, in every project, with no way to opt out.

External agent configs belong in their own repository, where they load as project config when Claude Code runs inside it.

### MCP servers

None configured. MCP servers live under `mcpServers` in `~/.claude.json`; `claude --disable-mcp` turns them off for one run.

## Development Guidelines

- Follow existing patterns within each tool's configuration
- Maintain vim-style navigation consistency across all tools
- When adding keybindings, check for conflicts with AeroSpace window manager
- Configuration files may contain Polish comments from original author
- Use conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`, `chore:`