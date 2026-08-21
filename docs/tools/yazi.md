# yazi

Terminal file manager with vim-style navigation and DuckDB plugin for CSV preview.

**Configuration**: `yazi/keymap.toml`

## Launching yazi

### From the terminal (tmux)

Use the `y` wrapper function (defined in `zsh/.zshrc`) instead of calling `yazi` directly:

```bash
y            # open yazi in the current directory
y ~/projects # open yazi in a specific directory
```

The wrapper passes `--cwd-file` to yazi, so when you quit (++q++) the shell **cd-s into the directory you navigated to**. Quit with ++shift+q++ to exit without changing the shell's directory. It works in any terminal pane, including tmux — no dedicated tmux keybinding is needed.

Pressing ++enter++ or ++o++ on a text file opens it **in nvim** (via the `edit` opener in `yazi/yazi.toml`, `block = true`) — quit nvim to return to yazi. ++shift+enter++ / ++shift+o++ shows an interactive picker (nvim / Open / Reveal in Finder) instead.

### From Neovim

The [yazi.nvim](https://github.com/mikavilpas/yazi.nvim) plugin (configured in `nvim/.config/nvim/lua/custom/plugins/init.lua`) opens yazi in a floating window:

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+e++ | Open yazi at the current file | Neovim |
| ++space+shift+e++ | Open yazi in the working directory | Neovim |

</div>

Selecting a file in yazi opens it in the current Neovim instance. Directories are still handled by Neo-tree (`open_for_directories = false`).

## Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++k++ | Previous file | Navigation |
| ++j++ | Next file | Navigation |
| ++h++ | Parent directory | Navigation |
| ++l++ | Enter directory | Navigation |
| ++shift+h++ | Back in history | Navigation |
| ++shift+l++ | Forward in history | Navigation |
| ++g+g++ | Go to top | Navigation |
| ++shift+g++ | Go to bottom | Navigation |

</div>

## File Operations

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++o++ | Open selected files | File Operations |
| ++y++ | Yank (copy) files | File Operations |
| ++x++ | Cut files | File Operations |
| ++p++ | Paste files | File Operations |
| ++shift+p++ | Paste files (overwrite) | File Operations |
| ++shift+y++ | Cancel yank status | File Operations |
| ++shift+x++ | Cancel yank status | File Operations |
| ++d++ | Trash selected files | File Operations |
| ++a++ | Create file | File Operations |
| ++r++ | Rename file | File Operations |

</div>

## Search & Filter

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++s++ | Search files by name (fd) | Search |
| ++shift+s++ | Search files by content (ripgrep) | Search |
| ++z++ | Jump to directory (fzf) | Search |
| ++shift+z++ | Jump to directory (zoxide) | Search |
| ++f++ | Filter files | Filter |
| ++slash++ | Find next file | Find |

</div>

## Copy Operations

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++c+c++ | Copy file path | Clipboard |
| ++c+d++ | Copy directory path | Clipboard |
| ++c+f++ | Copy filename | Clipboard |

</div>

## Sorting

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++comma+m++ | Sort by modified time | Sorting |
| ++comma+shift+m++ | Sort by modified time (reverse) | Sorting |
| ++comma+n++ | Sort by natural order | Sorting |

</div>

## Tabs

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++t++ | Create new tab | Tabs |
| ++1++ | Switch to tab 1 | Tabs |
| ++2++ | Switch to tab 2 | Tabs |
| ++3++ | Switch to tab 3 | Tabs |
| ++4++ | Switch to tab 4 | Tabs |
| ++5++ | Switch to tab 5 | Tabs |
| ++6++ | Switch to tab 6 | Tabs |
| ++7++ | Switch to tab 7 | Tabs |
| ++8++ | Switch to tab 8 | Tabs |
| ++9++ | Switch to tab 9 | Tabs |

</div>

## References

- **Config**: `yazi/keymap.toml`
- **DuckDB Plugin**: `yazi/plugins/duckdb.yazi/`
