# tmux-claude-status

Shows live Claude Code status (working / waiting / done) and last prompt or
reply next to each session in `prefix + s` (`choose-tree`). Built from two
scripts plus a tmux binding.

## Files

- `bin/tmux-claude-status` — invoked from Claude Code lifecycle hooks; writes
  per-window/per-session tmux user options.
- `bin/tmux-claude-refresh-status` — recomputes elapsed timers; called by the
  `prefix + s` binding right before `choose-tree` opens.
- `tmux/.tmux.conf` — the `bind s` line wires the two together.

## Tmux user options written

All set on **both** the window the claude pane lives in *and* its session:

| Option                   | When set                                     | Cleared on   |
|--------------------------|----------------------------------------------|--------------|
| `@claude_status`         | every event — formatted icon + elapsed time  | never (overwritten on next event) |
| `@claude_summary`        | UserPromptSubmit (prompt) / Stop / Notification (last assistant text) | overwritten on next event |
| `@claude_started_at`     | UserPromptSubmit (unix ts)                   | Stop, Notification |
| `@claude_waiting_since`  | Notification (unix ts)                       | UserPromptSubmit, Stop |

`@claude_summary` is sanitized: newlines/tabs collapsed, `#` doubled (tmux
format escape), truncated to 80 chars.

## Lifecycle hooks

`tmux-claude-status` is invoked by Claude Code with one of these events; it
reads the JSON payload from stdin.

| Event              | Status icon          | Side effect                          |
|--------------------|----------------------|--------------------------------------|
| `UserPromptSubmit` | `⚡ working (00:00)` | stamps `started_at`, stores prompt   |
| `PreToolUse`       | `⚡ working (MM:SS)` | recomputes elapsed off `started_at`  |
| `Notification`     | `⏸ waiting! (00:00)` | clears `started_at`, stamps `waiting_since`, stores last assistant text |
| `Stop`             | `✅ done (MM:SS)`    | clears both timers, stores last assistant text |

It bails early if `$TMUX` / `$TMUX_PANE` aren't set (script ran outside tmux).

## Why a refresh script exists

Tmux format strings have no "current time" variable. The status is recomputed
only when an event fires, so a long-running "working" or "waiting" indicator
would otherwise stay frozen at whatever value the last event wrote (typically
`00:00` for `Notification`).

`tmux-claude-refresh-status` walks every window with a non-empty
`@claude_started_at` or `@claude_waiting_since`, computes `now - ts`, and
overwrites `@claude_status` with the freshly formatted timer. The
`prefix + s` binding runs it synchronously via `run-shell` *before*
`choose-tree`, so the tree opens with current values.

### Why it iterates windows, not sessions

Tmux resolves user options in session-format context (`choose-tree -s`,
`list-sessions -F`) by walking through the session's *active window* first.
A stale window-level value will therefore mask a freshly-written session-level
value. `tmux-claude-status` writes to both levels; the refresh script must do
the same, otherwise the status reverts to whatever the last hook wrote at the
window level (e.g. `(00:00)` from `Notification`).

## Display format

`prefix + s` opens:

```
bind s run-shell "~/.dotfiles/bin/tmux-claude-refresh-status" \; \
    choose-tree -Zs -F "#{?session_attached,*,} #{session_name}  #{@claude_status}#{?@claude_summary, — #{@claude_summary},}"
```

Each row: `* session_name  ⚡ working (01:23) — last prompt or reply`.

Elapsed format: `MM:SS` under an hour, `Xh Ym` beyond.

## Adding the hooks (Claude Code side)

The script is wired in via `~/.claude/settings.json` hooks for the four
lifecycle events listed above. Each hook invokes
`~/.dotfiles/bin/tmux-claude-status <EventName>` and pipes the JSON payload
on stdin.

## Troubleshooting

- **Status stuck at `(00:00)`**: ensure both window and session levels are
  written; `tmux show-options -wv -t <session>:<win> @claude_status` and
  `tmux show-options -v -t <session> @claude_status` should match after a
  refresh. If only session is fresh, the refresh script is iterating sessions
  instead of windows — see "Why it iterates windows" above.
- **Status missing entirely**: confirm `$TMUX` is set in the environment
  Claude Code runs in (the script exits silently otherwise) and that the
  hooks are wired in `~/.claude/settings.json`.
- **Wrong session/window targeted**: `tmux display-message -p -t "$TMUX_PANE"`
  resolves the pane's session and window — verify the claude pane is the
  active one when the hook fires.
