# Neovim

Neovim configuration based on Kickstart.nvim with lazy.nvim plugin manager, LSP integration, Telescope fuzzy finder, and custom plugins.

## Cheet Sheet of all Vim commands

**https://vim.rtorr.com/**

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

## Neo-tree (File Explorer)

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+e++ | Toggle Neo-tree | File Explorer |

</div>

### Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++question++ | Show help | Neo-tree |
| ++less++ | Switch to previous source | Neo-tree |
| ++greater++ | Switch to next source | Neo-tree |
| ++backspace++ | Navigate up one directory level | Neo-tree |
| ++period++ | Set current folder as root | Neo-tree |
| ++space++ | Toggle node (expand/collapse) | Neo-tree |
| ++enter++ | Open file/folder | Neo-tree |
| ++shift+c++ | Close node | Neo-tree |
| ++z++ | Close all nodes | Neo-tree |
| ++shift+p++ | Toggle preview mode | Neo-tree |
| ++l++ | Focus preview window | Neo-tree |
| ++esc++ | Exit preview mode | Neo-tree |

</div>

### Opening Files

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++shift+s++ | Open in horizontal split | Neo-tree |
| ++s++ | Open in vertical split | Neo-tree |
| ++t++ | Open in new tab | Neo-tree |
| ++w++ | Open with window picker | Neo-tree |

</div>

### File Operations

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++a++ | Add file or directory (end with / for directory) | Neo-tree |
| ++shift+a++ | Add directory | Neo-tree |
| ++d++ | Delete file or directory | Neo-tree |
| ++r++ | Rename file or directory | Neo-tree |
| ++b++ | Rename basename (without extension) | Neo-tree |
| ++c++ | Copy file or directory | Neo-tree |
| ++m++ | Move file or directory | Neo-tree |
| ++i++ | Show file details | Neo-tree |

</div>

### Clipboard Operations

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++y++ | Copy to clipboard | Neo-tree |
| ++x++ | Cut to clipboard | Neo-tree |
| ++p++ | Paste from clipboard | Neo-tree |
| ++ctrl+r++ | Clear clipboard | Neo-tree |

</div>

### View & Filtering

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++shift+h++ | Toggle hidden files | Neo-tree |
| ++shift+r++ | Refresh tree | Neo-tree |
| ++o++ | Sort by... (show menu) | Neo-tree |
| ++o+c++ | Sort by created date | Neo-tree |
| ++o+d++ | Sort by diagnostics | Neo-tree |
| ++o+g++ | Sort by git status | Neo-tree |
| ++o+m++ | Sort by modified date | Neo-tree |
| ++o+n++ | Sort by name | Neo-tree |
| ++o+s++ | Sort by size | Neo-tree |
| ++o+t++ | Sort by type | Neo-tree |
| ++slash++ | Fuzzy finder (filter files) | Neo-tree |
| ++shift+d++ | Fuzzy finder (directories only) | Neo-tree |
| ++hash++ | Fuzzy sorter | Neo-tree |
| ++f++ | Filter on submit | Neo-tree |
| ++ctrl+x++ | Clear filter | Neo-tree |

</div>

### Git Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++bracket-left+g++ | Jump to previous git modified file | Neo-tree |
| ++bracket-right+g++ | Jump to next git modified file | Neo-tree |

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
