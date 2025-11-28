# tmux

Terminal multiplexer with vim-style navigation and custom keybindings.

## Tmux cheet sheet

**https://tmuxcheatsheet.com/**

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+b+w++ | Session and Window Preview | Configuration                  |

</div>


**Configuration**: `tmux/.tmux.conf`
**Prefix Key**: ++ctrl+b++

## Session Management

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+f++ | Open tmux-sessionizer | Project Switching (no prefix) |
| ++ctrl+b+r++ | Reload tmux config | Configuration |

</div>

## Pane Navigation

All commands require prefix (++ctrl+b++) first:

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+b+h++ | Select pane left | Pane Navigation |
| ++ctrl+b+j++ | Select pane down | Pane Navigation |
| ++ctrl+b+k++ | Select pane up | Pane Navigation |
| ++ctrl+b+l++ | Select pane right | Pane Navigation |

</div>

## Window Management

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+b+c++ | Create new window in current directory | Window |
| ++ctrl+b+double-quote++ | Split window vertically in current directory | Window |
| ++ctrl+b++"%"++ | Split window horizontally in current directory | Window |

</div>

## Tools Integration

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+b+shift+g++ | Open lazygit popup | Git |

</div>

## References

- **Config**: `tmux/.tmux.conf`
- **Scripts**: `bin/tmux-sessionizer`
