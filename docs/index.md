# Dotfiles Keybindings Documentation

Welcome to the comprehensive keyboard shortcuts documentation for my personal development environment.

## Quick Navigation

<div class="grid cards" markdown>

-   :material-keyboard: __Neovim__

    ---

    Text editor with LSP, Telescope, and custom plugins

    [:octicons-arrow-right-24: View shortcuts](tools/neovim.md)

-   :material-console: __tmux__

    ---

    Terminal multiplexer with vim-style navigation

    [:octicons-arrow-right-24: View shortcuts](tools/tmux.md)

-   :material-window-maximize: __AeroSpace__

    ---

    i3-like window manager for macOS

    [:octicons-arrow-right-24: View shortcuts](tools/aerospace.md)

-   :material-folder: __yazi__

    ---

    Terminal file manager with DuckDB integration

    [:octicons-arrow-right-24: View shortcuts](tools/yazi.md)

-   :material-cursor-default: __Cursor__

    ---

    AI-powered IDE with Vim mode

    [:octicons-arrow-right-24: View shortcuts](tools/cursor.md)

-   :simple-vim: __IdeaVim__

    ---

    IntelliJ IDEA Vim emulation

    [:octicons-arrow-right-24: View shortcuts](tools/ideavim.md)

-   :material-console-line: __zsh__

    ---

    Shell configuration with vi mode

    [:octicons-arrow-right-24: View shortcuts](tools/zsh.md)

-   :material-robot: __Gas Town__

    ---

    Multi-agent orchestrator for Claude Code with Beads

    [:octicons-arrow-right-24: View shortcuts](tools/gas-town.md)

-   :material-keyboard-variant: __Glove80__

    ---

    Split ergonomic keyboard with Engrammer layout

    [:octicons-arrow-right-24: View layout](keyboard/glove80.md)

</div>

## Shared Patterns

All tools follow consistent keybinding patterns:

| Pattern | Keys | Purpose |
|---------|------|---------|
| **Leader Key** | ++space++ | Primary command prefix (Neovim, IdeaVim, Cursor) |
| **Window Navigation** | ++ctrl+h++ ++ctrl+j++ ++ctrl+k++ ++ctrl+l++ | Vim-style directional movement |
| **Search Operations** | ++space+s+"*"++ | Telescope-style search (files, grep, symbols) |
| **LSP Actions** | ++space+g+"*"++ | Go to definition/references/implementation |
| **Refactoring** | ++space+r+"*"++ | Rename, extract, refactor operations |

## Quick Reference

Looking for a specific shortcut? Check the [Quick Reference](quick-reference.md) page for cross-tool comparisons.

## About This Documentation

This site is automatically generated from dotfiles configurations and deployed via GitHub Actions.

- **Repository**: [czechue/.dotfiles](https://github.com/czechue/.dotfiles)
- **Last Updated**: Auto-updated on each push to master
- **Tools**: MkDocs Material, List.js, GitHub Actions
