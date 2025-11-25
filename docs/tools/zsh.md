# zsh

Shell configuration with vi mode, custom functions, and keybindings.

**Configuration**: `zsh/.zshrc`

## Custom Keybindings

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+f++ | Open tmux-sessionizer | Project Switching |

</div>

## fzf Integration

Built-in fzf keybindings (loaded via `source <(fzf --zsh)`):

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+r++ | Search command history | fzf |
| ++ctrl+t++ | Search files in current directory | fzf |
| ++alt+c++ | Change directory (fuzzy) | fzf |

</div>

## Vi Mode

Vi mode enabled via `zsh-vi-mode` plugin:

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++esc++ | Enter normal mode | Vi Mode |
| ++i++ | Enter insert mode | Vi Mode (from normal) |
| ++v++ | Edit command in editor | Vi Mode (normal) |

</div>

## Custom Functions

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `killport <port>` | Kill process on specified port | Utility Function |
| `y` | yazi wrapper (cd on exit) | File Manager |

</div>

## References

- **Config**: `zsh/.zshrc`
- **Scripts**: `bin/tmux-sessionizer`
