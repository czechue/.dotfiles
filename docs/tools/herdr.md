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

## Prevent sleep while agents work

[herdr-wakeup](https://github.com/usrivastava92/herdr-wakeup) automatically prevents idle system sleep while any agent in the current Herdr session reports `working`. The display can still sleep. It activates after 5 seconds of work and releases the sleep assertion 30 seconds after the last working agent stops. Agents waiting for input do not keep the Mac awake.

Install the pinned commit below, which includes automatic startup on pane creation, tab creation, and pane focus. The published `v0.1.0` tag predates those startup hooks. Installation requires Rust (`cargo`) and enables the plugin.

```bash
herdr plugin install usrivastava92/herdr-wakeup/plugin --ref 43db0b9f88a4b1bc560593b0ce8f2a7d2a940f04
herdr plugin action invoke start --plugin herdr-wakeup
```

The explicit start activates it immediately for an existing session. Future Herdr activity starts the watcher automatically; no shell startup command or login agent is needed.

Press ++ctrl+b++ then ++a++ to enable sleep prevention, or ++ctrl+b++ then ++shift+a++ to disable it. Both shortcuts appear in ++ctrl+b++ then ++question++ as **Keep awake while agents work: ON/OFF**. The setting changes on the watcher's next evaluation (within 60 seconds, or sooner when a Herdr event arrives).

```bash
herdr plugin action invoke status --plugin herdr-wakeup
herdr plugin action invoke disarm --plugin herdr-wakeup  # turn sleep prevention off
herdr plugin action invoke arm --plugin herdr-wakeup     # turn it back on
herdr plugin action invoke doctor --plugin herdr-wakeup
herdr plugin log list --plugin herdr-wakeup --limit 5     # read action results
```

Plugin actions run asynchronously; read their results with `plugin log list` after they finish. `pmset -g assertions` shows a `wakeup` process holding `PreventUserIdleSystemSleep` while protection is active. Herdr also shows toast notifications when protection activates or releases.

Configuration is stored per session under `~/.config/herdr/plugins/config/herdr-wakeup/sessions/`; `doctor` reports the exact path. Defaults enable both `armed` and `autostart`, with `display` disabled. Use `disarm` for a persistent off switch; `stop` alone can be reversed by the next autostart event. Before uninstalling, stop the watcher in each running Herdr session, then run `herdr plugin uninstall herdr-wakeup`.

This prevents idle sleep, like Codex's setting. It does not override MacBook lid-close sleep.

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
| ++a++ | Keep awake while agents work: ON |
| ++shift+a++ | Keep awake while agents work: OFF |

</div>

## References

- **Config**: `herdr/config.toml`
- **Website**: [herdr.dev](https://herdr.dev)
- **Print defaults**: `herdr --default-config`
- **Reset custom keys**: `herdr config reset-keys`
