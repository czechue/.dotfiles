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

## Coding Agent Integration

Helpers for working with terminal coding agents (Claude Code, Droid, etc.).

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+b+s++ | Session list with live Claude Code status (working/waiting/done) and last prompt or reply | Sessions |
| ++ctrl+b+e++ | Capture active pane (last 10k lines) into Neovim in a new window | Transcripts / logs |
| ++ctrl+b+o++ | Send ++ctrl+o++ through to the program in the pane (e.g. expand transcripts in Claude Code) | Passthrough |

</div>

`prefix + e` writes the capture to `/tmp/tmux-capture` and opens it with `nvim`.
`prefix + o` overrides tmux's default `select-next-pane`, which is redundant
with the ++ctrl+b+h++/++j++/++k++/++l++ navigation.

See `bin/tmux-claude-status.md` for the Claude Code status integration.

## References

- **Config**: `tmux/.tmux.conf`
- **Scripts**: `bin/tmux-sessionizer`
