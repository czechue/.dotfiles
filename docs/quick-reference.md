# Quick Reference

Unified view of keyboard shortcuts across all tools with cross-tool comparisons.

## Universal Patterns

### Window Navigation (Ctrl+HJKL)

Available in: Neovim, tmux (with prefix), AeroSpace (Ctrl+Alt+HJKL), Cursor, IdeaVim

<div class="shortcuts-table" markdown>

| Tool | Left | Down | Up | Right | Notes |
|------|------|------|----|----|-------|
| **Neovim** | ++ctrl+h++ | ++ctrl+j++ | ++ctrl+k++ | ++ctrl+l++ | Direct navigation |
| **tmux** | ++ctrl+b+h++ | ++ctrl+b+j++ | ++ctrl+b+k++ | ++ctrl+b+l++ | Requires prefix |
| **AeroSpace** | ++ctrl+alt+h++ | ++ctrl+alt+j++ | ++ctrl+alt+k++ | ++ctrl+alt+l++ | System-wide |
| **Cursor** | ++ctrl+h++ | ++ctrl+j++ | ++ctrl+k++ | ++ctrl+l++ | Vim mode |
| **IdeaVim** | ++ctrl+h++ | ++ctrl+j++ | ++ctrl+k++ | ++ctrl+l++ | Vim emulation |

</div>

### Search Operations (Leader+S+*)

Available in: Neovim, Cursor, IdeaVim

<div class="shortcuts-table" markdown>

| Action | Neovim | Cursor | IdeaVim |
|--------|--------|--------|---------|
| **Find Files** | ++space+s+f++ | ++space+s+f++ | ++space+s+f++ |
| **Grep/Search** | ++space+s+g++ | ++space+s+g++ | ++space+s+g++ |
| **Symbols** | ++space+s+h++ | ++space+s+s++ | ++space+s+s++ |
| **Recent Files** | ++space+s+r++ | ++space+s+r++ | ++space+s+r++ |

</div>

### LSP Actions (Leader+G+*)

Available in: Neovim, Cursor, IdeaVim

<div class="shortcuts-table" markdown>

| Action | Neovim | Cursor | IdeaVim |
|--------|--------|--------|---------|
| **Go to Definition** | ++g+d++ | ++space+g+d++ | ++space+g+d++ |
| **Go to References** | ++g+r++ | - | - |
| **Go to Implementation** | ++g+shift+i++ | ++space+g+i++ | ++space+g+i++ |
| **Rename** | ++space+r+n++ | ++space+r+n++ | ++space+r+n++ |
| **Code Action** | ++space+c+a++ | ++space+c+a++ | ++space+c+a++ |

</div>

## Tool-Specific Essentials

### Project Switching

<div class="shortcuts-table" markdown>

| Tool | Shortcut | Action |
|------|----------|--------|
| **Neovim** | ++ctrl+f++ | tmux-sessionizer |
| **tmux** | ++ctrl+f++ | tmux-sessionizer (no prefix) |
| **zsh** | ++ctrl+f++ | tmux-sessionizer |
| **yazi** | ++z++ | fzf directory jump |
| **yazi** | ++shift+z++ | zoxide directory jump |

</div>

### File Management

<div class="shortcuts-table" markdown>

| Tool | Open | Copy | Paste | Delete | Rename |
|------|------|------|-------|--------|--------|
| **yazi** | ++o++ | ++y++ | ++p++ | ++d++ | ++r++ |
| **Neovim** | ++space+s+f++ | - | - | - | ++space+r+n++ |

</div>

### Git Operations

<div class="shortcuts-table" markdown>

| Tool | Shortcut | Action |
|------|----------|--------|
| **Neovim** | ++space+g+g++ | LazyGit |
| **tmux** | ++ctrl+b+shift+g++ | LazyGit popup |
| **Neovim** | ++space+g+w+s++ | Git worktree switch |
| **Neovim** | ++space+g+w+c++ | Git worktree create |

</div>

## Mode-Specific Shortcuts

### AeroSpace Modes

<div class="shortcuts-table" markdown>

| Mode | Enter | Exit | Purpose |
|------|-------|------|---------|
| **Resize** | ++alt+r++ | ++esc++ | Resize windows |
| **Service** | ++alt+shift+semicolon++ | ++esc++ | Reload config |

</div>

### Vim Modes (Neovim, Cursor, IdeaVim)

<div class="shortcuts-table" markdown>

| Mode | Enter | Purpose |
|------|-------|---------|
| **Normal** | ++esc++ | Command mode |
| **Insert** | ++i++ | Text editing |
| **Visual** | ++v++ | Selection |
| **Visual Line** | ++shift+v++ | Line selection |

</div>

## All Shortcuts Search

Use the search box below to find shortcuts across all tools:

<div class="shortcuts-table" markdown>

| Shortcut | Action | Tool | Context |
|----------|--------|------|---------|
| ++ctrl+h++ | Navigate left | Neovim | Window Navigation |
| ++ctrl+h++ | Navigate left | Cursor | Window Navigation |
| ++ctrl+h++ | Navigate left | IdeaVim | Window Navigation |
| ++ctrl+b+h++ | Select pane left | tmux | Pane Navigation |
| ++ctrl+alt+h++ | Focus left | AeroSpace | Window Focus |
| ++h++ | Parent directory | yazi | Navigation |
| ++space+s+f++ | Search files | Neovim | Telescope |
| ++space+s+f++ | Quick open | Cursor | Search |
| ++space+s+f++ | Go to file | IdeaVim | Search |
| ++space+g+g++ | LazyGit | Neovim | Git |
| ++ctrl+b+shift+g++ | LazyGit popup | tmux | Git |
| ++ctrl+f++ | tmux-sessionizer | Multiple | Project Switching |
| ++alt+1++ through ++alt+9++ | Switch workspace | AeroSpace | Workspace |
| ++1++ through ++9++ | Switch tab | yazi | Tabs |
| ++space+a++ | Add to Harpoon | Neovim | File Management |
| ++space+h++ | Harpoon menu | Neovim | File Management |
| ++g+d++ | Go to definition | Neovim | LSP |
| ++space+g+d++ | Go to definition | Cursor/IdeaVim | LSP |
| ++space+r+n++ | Rename | Multiple | LSP |
| ++space+c+a++ | Code action | Multiple | LSP |

</div>

## Tips

- **Leader Key**: Most Vim-style tools use ++space++ as the leader
- **Prefix Key**: tmux uses ++ctrl+b++ as the prefix for all commands
- **System-Wide**: AeroSpace keybindings work across all applications
- **Context-Aware**: Some shortcuts behave differently in different modes

## See Also

- [Neovim](tools/neovim.md) - Full Neovim shortcuts
- [tmux](tools/tmux.md) - Full tmux shortcuts
- [AeroSpace](tools/aerospace.md) - Full AeroSpace shortcuts
- [yazi](tools/yazi.md) - Full yazi shortcuts
- [Cursor](tools/cursor.md) - Full Cursor shortcuts
- [IdeaVim](tools/ideavim.md) - Full IdeaVim shortcuts
- [zsh](tools/zsh.md) - Full zsh shortcuts
