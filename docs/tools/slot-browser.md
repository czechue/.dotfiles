# Slot browser

One Chrome window per Herdr slot. AeroSpace workspace 3 always shows the
browser of the slot you are working in, and a slot's Claude agent opens its
`claude-in-chrome` tabs in that same window.

**Location**: `bin/slot-browser` (symlinked to `~/.local/bin/slot-browser`),
`claude/slot-browser-hooks.json`, `exec-on-workspace-change` in
`aerospace/.config/aerospace/aerospace.toml`

## The idea

Slots are Herdr workspaces labelled `slot-N ...`, each on its own git worktree
with its own gateway port (`8050 + N`). Every slot owns an ordinary Chrome
window in the **company profile** (`Profile 7`, "fourthwall.com") that carries
the window name `slot-N` (Chrome: *Window → Name Window…*).

Because all slot windows live in one profile, logins, cookies, 1Password and
the Claude extension are shared: nothing to sign into per slot. Chrome shows
the name in the window title, which is how the script finds the windows:

```
5747|3|slot-1 - Google Chrome – Michał (fourthwall.com)
5759|S|slot-2 – błąd sieci - Google Chrome – Michał (fourthwall.com)
```

Chrome appends page status after the name (`– błąd sieci`, `– należy do grupy …`),
so the match is `slot-N` followed by a space. Unnamed Chrome windows are never
touched.

## Workspace 3 follows the focused slot

```
alt-3 ──► AeroSpace runs `slot-browser sync`
           │  AEROSPACE_FOCUSED_WORKSPACE == 3 ?
           ▼
        herdr workspace list → focused workspace "slot-5 AI-1029" → slot 5
           │
           ├─ window "slot-5"         → move to workspace 3
           ├─ windows "slot-1..8"     → park on hidden workspace S
           └─ no "slot-5" window yet  → open one in Profile 7 at
                                        http://localhost:8055/make-product/,
                                        name it "slot-5", move it to 3
```

The callback fires on every workspace change and exits at once unless the new
workspace is 3. When the focused Herdr workspace is not a slot, workspace 3 is
left as it was. Workspace `S` has no key binding, so parked windows stay out of
sight.

New windows are opened through the Chrome binary
(`Google Chrome --profile-directory="Profile 7" --new-window URL`), which hands
the request to the running Chrome. AppleScript `make new window` is not used: it
opens in whichever profile was used last.

## Agents open their tabs in their slot's window

`claude-in-chrome` creates a session's tab group in **Chrome's last focused
window** (`chrome.windows.getLastFocused()` in the extension). It knows nothing
about slots, so a slot-5 agent ended up in the slot-1 window because that was
the last one you clicked.

What does not help:

- AppleScript `set index of window … to 1` reorders windows but does not change
  Chrome's last focused window.
- Moving the agent's tab to another window afterwards drops it out of its tab
  group, and the extension then reports the session's group as gone.

What works is focusing the slot's window for a moment **before** the group is
created. Two Claude Code hooks do that:

| Hook | Runs | Does |
|------|------|------|
| `slot-browser agent-hook` | `PreToolUse` on `tabs_context_mcp` (with `createIfEmpty: true`) and `tabs_create_mcp` | Maps the session's `cwd` to a slot through the Herdr worktree paths, focuses window `slot-N` (or creates it), then gives focus back |
| `slot-browser agent-hook-post` | `PostToolUse` on the same tools | Gives focus back only now when it was on another Chrome window, because giving it back earlier would make that window the last focused one again |

Each session triggers the hook once: a marker in `$TMPDIR/slot-browser/<session_id>`
records that it ran. Sessions outside slot worktrees are a no-op. The focus round
trip takes about 0.4 s, so you may see the slot window flash, possibly from
workspace S.

### Where the hooks live

They are personal, so they go into each slot worktree's
`.claude/settings.local.json`, which the global `~/.gitignore` ignores. They are
not in `~/.claude/settings.json`. A session reads the settings of its own
worktree, so the primary checkout's local settings would not reach the slots.

The template is `claude/slot-browser-hooks.json`. Install or refresh it in every
slot with:

```bash
slot-browser install-hooks
```

It merges into existing files: other hooks and permissions stay, and earlier
`slot-browser` entries are replaced, so running it again changes nothing. Run it
after adding a slot. Restart running Claude Code sessions to load new hooks.

## Commands

| Command | Action |
|---------|--------|
| `slot-browser sync` | AeroSpace callback (see above) |
| `slot-browser open` | Show the focused slot's window on workspace 3 |
| `slot-browser open N` | Focus Herdr workspace `slot-N`, then show its window on workspace 3 |
| `slot-browser agent-hook` | Claude Code `PreToolUse` hook (reads hook JSON on stdin) |
| `slot-browser agent-hook-post` | Claude Code `PostToolUse` hook |
| `slot-browser install-hooks` | Merge the hook template into every slot's `.claude/settings.local.json` |

Overrides: `SLOT_BROWSER_WORKSPACE` (default `3`), `SLOT_BROWSER_PARK_WORKSPACE`
(`S`), `SLOT_BROWSER_PROFILE` (`Profile 7`).

## Setup

```bash
ln -sf ~/.dotfiles/bin/slot-browser ~/.local/bin/slot-browser
aerospace reload-config          # picks up exec-on-workspace-change
slot-browser install-hooks       # Claude hooks into every slot worktree
```

Needs `herdr`, `jq` and `aerospace` on the paths the script prepends
(`~/.local/bin`, `/opt/homebrew/bin`, `/usr/local/bin`). Outside Herdr it talks to
the server through `~/.config/herdr/herdr.sock`.

To find a profile directory name:

```bash
jq -r '.profile.info_cache | to_entries[] | "\(.key)\t\(.value.name)\t\(.value.user_name)"' \
  ~/Library/Application\ Support/Google/Chrome/Local\ State
```

## Limits and troubleshooting

- **Chrome restart**: whether window names survive session restore is untested.
  If they do not, `sync` opens fresh windows; to keep an old one, name it
  `slot-N` again from the Window menu.
- **`cmd-N` from a slot window** opens an unnamed window, which stays on
  workspace 3 when you switch slots. Use tabs inside the slot window.
- **Agent group in the wrong window**: the hook steers only the first group of a
  session. If an agent closes all its tabs and creates a new group, it lands in
  the last focused window. Close the stray tab; delete
  `$TMPDIR/slot-browser/<session_id>` to re-arm the hook for that session.
- **localhost cookies ignore the port**: slots on `:8051` and `:8052` share
  cookies of the same name. localStorage is per port.
- **Nothing happens on `alt-3`**: run `AEROSPACE_FOCUSED_WORKSPACE=3 slot-browser sync`
  in a terminal to see errors (the callback discards output), and check
  `herdr workspace list` reports a focused `slot-` workspace.
