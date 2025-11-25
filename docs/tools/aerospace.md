# AeroSpace

i3-like tiling window manager for macOS with multiple modes (main, service, resize).

**Configuration**: `aerospace/.config/aerospace/aerospace.toml`

## Layout Management

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++alt+slash++ | Toggle layout (tiles horizontal/vertical) | Layout |
| ++alt+comma++ | Toggle accordion layout | Layout |

</div>

## Focus Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+alt+h++ | Focus window left | Window Focus |
| ++ctrl+alt+j++ | Focus window down | Window Focus |
| ++ctrl+alt+k++ | Focus window up | Window Focus |
| ++ctrl+alt+l++ | Focus window right | Window Focus |

</div>

## Move Windows

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+alt+shift+h++ | Move window left | Window Movement |
| ++ctrl+alt+shift+j++ | Move window down | Window Movement |
| ++ctrl+alt+shift+k++ | Move window up | Window Movement |
| ++ctrl+alt+shift+l++ | Move window right | Window Movement |

</div>

## Workspace Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++alt+1++ | Switch to workspace 1 | Workspace |
| ++alt+2++ | Switch to workspace 2 | Workspace |
| ++alt+3++ | Switch to workspace 3 | Workspace |
| ++alt+4++ | Switch to workspace 4 | Workspace |
| ++alt+5++ | Switch to workspace 5 | Workspace |
| ++alt+6++ | Switch to workspace 6 | Workspace |
| ++alt+7++ | Switch to workspace 7 | Workspace |
| ++alt+8++ | Switch to workspace 8 | Workspace |
| ++alt+9++ | Switch to workspace 9 | Workspace |

</div>

## Move to Workspace

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++alt+shift+1++ | Move window to workspace 1 | Window Movement |
| ++alt+shift+2++ | Move window to workspace 2 | Window Movement |
| ++alt+shift+3++ | Move window to workspace 3 | Window Movement |
| ++alt+shift+4++ | Move window to workspace 4 | Window Movement |
| ++alt+shift+5++ | Move window to workspace 5 | Window Movement |
| ++alt+shift+6++ | Move window to workspace 6 | Window Movement |
| ++alt+shift+7++ | Move window to workspace 7 | Window Movement |
| ++alt+shift+8++ | Move window to workspace 8 | Window Movement |
| ++alt+shift+9++ | Move window to workspace 9 | Window Movement |

</div>

## Modes

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++alt+r++ | Enter resize mode | Mode Switch |
| ++alt+shift+semicolon++ | Enter service mode | Mode Switch |

</div>

### Resize Mode

After pressing ++alt+r++:

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++h++ | Decrease width | Resize |
| ++j++ | Increase height | Resize |
| ++k++ | Decrease height | Resize |
| ++l++ | Increase width | Resize |
| ++esc++ | Exit resize mode | Mode |

</div>

### Service Mode

After pressing ++alt+shift+semicolon++:

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++r++ | Reload config | Service |
| ++esc++ | Exit service mode | Mode |

</div>

## References

- **Config**: `aerospace/.config/aerospace/aerospace.toml`
- **Documentation**: `aerospace/CLAUDE.md`
