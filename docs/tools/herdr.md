# Herdr

Terminal workspace manager for AI coding agents — a tmux-like persistent server/client with a sidebar that tracks agent state (working / done / needs attention) across workspaces.

**Configuration**: `herdr/config.toml` (symlinked to `~/.config/herdr/config.toml`)

The tracked config is the full annotated default (`herdr --default-config`, v0.8.2) — every option is present but commented out, so customizations are explicit diffs against upstream defaults. After editing, apply with `herdr server reload-config` (or ++ctrl+b++ then ++shift+r++ from inside).

!!! warning "Prefix conflict with tmux"
    Herdr's default prefix is ++ctrl+b++ — the same as tmux. Run Herdr **directly in the terminal** (instead of tmux), or change `prefix` in `[keys]` before nesting them.

## Launching

```bash
herdr                        # launch or attach to the persistent session
herdr --session <name>       # named session
herdr session attach <name>  # attach to a named session
herdr --remote <ssh-target>  # attach to a remote Herdr server over SSH
herdr status                 # client + server status
herdr server stop            # stop the server
herdr update                 # self-update
```

## Project switcher (herdr-sessionizer)

`bin/herdr-sessionizer` is the Herdr analog of `tmux-sessionizer`: ++ctrl+f++ (direct, no prefix) opens an fzf popup listing project directories (`~`, `~/personal`, `~/fourthwall`, Dropbox). Picking one focuses the workspace with a matching label, creating it first when it doesn't exist. Configured as a `[[keys.command]]` popup in `herdr/config.toml`; the script talks to the server over the socket API (`herdr workspace list/create/focus`).

## Keybindings (defaults)

All actions below require the prefix ++ctrl+b++ first, unless noted.

### Workspaces

<div class="shortcuts-table" markdown>

| Shortcut | Action |
|----------|--------|
| ++w++ | Workspace picker |
| ++g++ | Goto |
| ++shift+n++ | New workspace |
| ++shift+w++ | Rename workspace |
| ++shift+d++ | Close workspace |
| ++shift+g++ | New git worktree |

</div>

### Tabs

<div class="shortcuts-table" markdown>

| Shortcut | Action |
|----------|--------|
| ++c++ | New tab |
| ++1++ … ++9++ | Switch to tab 1–9 |
| ++p++ / ++n++ | Previous / next tab |
| ++shift+t++ | Rename tab |
| ++shift+x++ | Close tab |

</div>

### Panes

<div class="shortcuts-table" markdown>

| Shortcut | Action |
|----------|--------|
| ++v++ | Split vertical |
| ++minus++ | Split horizontal |
| ++h++ / ++j++ / ++k++ / ++l++ | Focus pane left / down / up / right |
| ++tab++ / ++shift+tab++ | Cycle panes forward / back |
| ++z++ | Zoom (fullscreen) pane |
| ++r++ | Resize mode |
| ++x++ | Close pane |
| ++shift+p++ | Rename pane |
| ++e++ | Edit scrollback in editor |

</div>

### Session & UI

<div class="shortcuts-table" markdown>

| Shortcut | Action |
|----------|--------|
| ++question++ | Help |
| ++s++ | Settings |
| ++q++ | Detach (session keeps running) |
| ++b++ | Toggle sidebar |
| ++o++ | Open notification target |
| ++shift+r++ | Reload config |

</div>

## References

- **Config**: `herdr/config.toml`
- **Website**: [herdr.dev](https://herdr.dev)
- **Print defaults**: `herdr --default-config`
- **Reset custom keys**: `herdr config reset-keys`
