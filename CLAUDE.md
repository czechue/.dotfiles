# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for managing development tool configurations on macOS. The repository uses a modular structure with separate directories for each tool.

## Key Components

- **aerospace/**: AeroSpace window manager (i3-like for macOS) configuration
- **nvim/**: Neovim configuration based on Kickstart.nvim
- **tmux/**: Terminal multiplexer configuration with vim-style navigation
- **ideavim/**: IntelliJ IDEA Vim emulation configuration
- **cursor/**: Cursor IDE configuration with Vim mode and IntelliJ-style keybindings

## Common Development Tasks

### Setting up configurations
Configurations are manually symlinked from the home directory:
```bash
# Examples of existing symlinks:
ln -s ~/.dotfiles/ideavim/.ideavimrc ~/.ideavimrc
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/aerospace/.config/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
ln -sf ~/.dotfiles/cursor/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
ln -sf ~/.dotfiles/cursor/keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json
```

### Neovim Development
- LSP servers are managed through Mason (`:Mason` command in Neovim)
- Plugin management uses lazy.nvim
- Configuration is modular under `nvim/lua/kickstart/plugins/`

### Testing configurations
- For tmux: `tmux source-file ~/.tmux.conf` or `C-b r` from within tmux
- For AeroSpace: `alt-shift-semicolon` then `r` to reload config
- For Neovim: Restart Neovim or run `:source %` on the current file
- For Cursor: Settings reload automatically, but full restart recommended after config changes

## Architecture Notes

1. **Consistent Keybindings**: All vim configurations (Neovim, IdeaVim) use space as the leader key and share similar mappings for consistency across environments.

2. **Modular Structure**: Each tool has its own directory, making it easy to add/remove tools without affecting others.

3. **Git Workflow**: The repository tracks configuration changes. The `.dotfiles-personal/` and `.dotfiles-fourthwall/` directories suggest a multi-context setup for personal vs work configurations.

4. **No Installation Scripts**: Setup is manual via symlinks. When adding new configurations, remember to create the appropriate symlinks.

## Important Conventions

- Vim-style navigation is used consistently across all tools (hjkl for movement)
- Configuration files may contain Polish comments from the original author
- The repository excludes only `.DS_Store` files via `.gitignore`
- **Vim Configuration Synchronization**: The configurations for Neovim, IdeaVim, and Cursor must be kept as similar as possible to ensure consistent workflow across all editors. When modifying any vim setup, always analyze and update the other configurations accordingly to maintain feature parity. Key shared features:
  - Leader key: `Space`
  - Window navigation: `Ctrl+hjkl`
  - Search/navigation: `Space+s*` prefix
  - LSP actions: `Space+g*` prefix
  - Refactoring: `Space+r*` prefix