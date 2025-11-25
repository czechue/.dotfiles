# Neovim

Neovim configuration based on Kickstart.nvim with lazy.nvim plugin manager, LSP integration, Telescope fuzzy finder, and custom plugins.

**Configuration**: `nvim/.config/nvim/init.lua`

## Core Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+h++ | Move focus to left window | Window Navigation |
| ++ctrl+j++ | Move focus to lower window | Window Navigation |
| ++ctrl+k++ | Move focus to upper window | Window Navigation |
| ++ctrl+l++ | Move focus to right window | Window Navigation |
| ++shift+j++ | Move line down | Visual Mode |
| ++shift+k++ | Move line up | Visual Mode |
| ++esc++ | Clear search highlighting | Normal Mode |

</div>

## Telescope (Search)

Leader key: ++space++

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+s+f++ | Search files | Fuzzy Finder |
| ++space+s+g++ | Live grep | Fuzzy Finder |
| ++space+s+h++ | Search help tags | Fuzzy Finder |
| ++space+s+d++ | Search diagnostics | Fuzzy Finder |
| ++space+s+r++ | Resume last search | Fuzzy Finder |
| ++space+s+n++ | Search Neovim files | Fuzzy Finder |
| ++space+s+w++ | Search current word | Fuzzy Finder |
| ++space+slash++ | Search in current buffer | Fuzzy Finder |

</div>

## LSP (Language Server)

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++g+d++ | Go to definition | LSP |
| ++g+r++ | Go to references | LSP |
| ++g+shift+i++ | Go to implementation | LSP |
| ++g+shift+d++ | Go to type definition | LSP |
| ++space+r+n++ | Rename symbol | LSP |
| ++space+c+a++ | Code action | LSP |
| ++space+o+i++ | Organize imports | LSP |
| ++shift+k++ | Hover documentation | LSP |

</div>

## Custom Plugins

### LazyGit

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+g+g++ | Open LazyGit | Git |

</div>

### Harpoon

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+a++ | Add file to Harpoon | File Management |
| ++space+h++ | Open Harpoon menu | File Management |
| ++space+1++ | Navigate to Harpoon file 1 | File Management |
| ++space+2++ | Navigate to Harpoon file 2 | File Management |
| ++space+3++ | Navigate to Harpoon file 3 | File Management |
| ++space+4++ | Navigate to Harpoon file 4 | File Management |
| ++space+5++ | Navigate to Harpoon file 5 | File Management |

</div>

### Git Worktree

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+g+w+s++ | Switch git worktree | Git |
| ++space+g+w+c++ | Create git worktree | Git |

</div>

## Theme Switching

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+t+l++ | Switch to light theme | Theme |
| ++space+t+d++ | Switch to dark theme | Theme |
| ++space+t+a++ | Show all themes | Theme |
| ++space+t+c++ | Toggle Codeium AI completion | AI |

</div>

## System

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+f++ | Open tmux-sessionizer | Project Switching |

</div>

## References

- **Config**: `nvim/.config/nvim/init.lua`
- **Custom Plugins**: `nvim/.config/nvim/lua/custom/plugins/`
- **Documentation**: `nvim/.config/nvim/README.md`
