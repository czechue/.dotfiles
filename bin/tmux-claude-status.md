# tmux-claude-status

Live Claude Code status (working / waiting / done), elapsed time, last
prompt/reply, and an optional manual title shown next to each tmux session
in two interchangeable views:

- **`prefix s`** — built-in `choose-tree`. Zero extra deps, scans fast. Also
  `prefix S` to filter to sessions where Claude is waiting on you.
- **`prefix C-s`** — fzf-based picker (`bin/tmux-claude-picker`) in a popup
  with true column alignment and a live preview pane showing the session's
  claude output. Requires `fzf` on PATH.

Both views read the same per-session state, populated by Claude Code
lifecycle hooks. A separate binding (`prefix T`) lets you stamp each session
with a manual title that both views surface — as an inline blue label in
choose-tree, and as its own column in the fzf picker.

## Files

- `bin/tmux-claude-status` — invoked from Claude Code lifecycle hooks; writes
  per-window/per-session tmux user options.
- `bin/tmux-claude-refresh-status` — recomputes elapsed timers and age-based
  color tiers; clears zombie waiting entries (≥48h). Called synchronously by
  both pickers right before they open.
- `bin/tmux-claude-picker` — fzf-driven session picker. Reads the source-of-
  truth options (`@claude_started_at`, `@claude_waiting_since`,
  `@claude_summary`, `@claude_title`) and renders rows in ANSI directly, so
  it doesn't depend on the tmux-format `@claude_status` string.
- `tmux/.tmux.conf` — binds `s` / `S` (choose-tree), `C-s` (fzf picker), and
  `T` (set manual session title).

## Tmux user options

Hook-driven options written by `tmux-claude-status` on **both** the window
the claude pane lives in *and* its session:

| Option                   | When set                                     | Cleared on   |
|--------------------------|----------------------------------------------|--------------|
| `@claude_status`         | every event — formatted icon + elapsed time (tmux-format syntax, used only by `choose-tree`) | never (overwritten on next event) |
| `@claude_summary`        | UserPromptSubmit (prompt) / Stop / Notification (last assistant text) | overwritten on next event |
| `@claude_started_at`     | UserPromptSubmit (unix ts)                   | Stop, Notification |
| `@claude_waiting_since`  | Notification (unix ts)                       | UserPromptSubmit, Stop |

User-driven option set via `prefix T`:

| Option           | When set                | Cleared on        |
|------------------|-------------------------|-------------------|
| `@claude_title`  | `prefix T` → enter text | `prefix T` → empty input |

`@claude_summary` is sanitized: newlines/tabs collapsed, `#` doubled (tmux
format escape), truncated to 80 chars. `@claude_title` is stored verbatim.

## Lifecycle hooks

`tmux-claude-status` is invoked by Claude Code with one of these events; it
reads the JSON payload from stdin.

| Event              | Status icon          | Side effect                          |
|--------------------|----------------------|--------------------------------------|
| `UserPromptSubmit` | `⚡ working (00:00)` (yellow) | stamps `started_at`, stores prompt |
| `PreToolUse`       | `⚡ working (MM:SS)` (yellow) | recomputes elapsed off `started_at` |
| `Notification`     | `⏸ waiting! (00:00)` (red,bold,reverse) | clears `started_at`, stamps `waiting_since`, stores last assistant text |
| `Stop`             | `✅ done (MM:SS)` (green,bold) | clears both timers, stores last assistant text |

Each status string is right-padded to ~22 visible cells (after `#[default]`)
so rows align inside `choose-tree`.

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

### Age-based color tiers for waiting

The refresh script re-styles waiting entries by how long they've been waiting,
so the eye triages them pre-attentively without reading the timer:

| Age          | Style              | Label       | Meaning                          |
|--------------|--------------------|-------------|----------------------------------|
| `< 5 min`    | red,bold,reverse   | `waiting!`  | fresh — needs you now            |
| `< 1 h`      | red,bold           | `waiting!`  | recent — still active            |
| `< 24 h`     | yellow             | `waiting`   | stale — probably drifted         |
| `24h–48h`    | colour240 (dim)    | `waiting`   | dying — likely forgotten         |
| `≥ 48 h`     | (entry cleared)    | —           | zombie — hooks never fired Stop  |

Zombies are wiped via `tmux set-option ""` on both window and session levels
(plus `@claude_waiting_since` and `@claude_summary`) so they reduce to a
single `·` row in the picker — no stale 297h waits cluttering triage.

### Why it iterates windows, not sessions

Tmux resolves user options in session-format context (`choose-tree -s`,
`list-sessions -F`) by walking through the session's *active window* first.
A stale window-level value will therefore mask a freshly-written session-level
value. `tmux-claude-status` writes to both levels; the refresh script must do
the same, otherwise the status reverts to whatever the last hook wrote at the
window level (e.g. `(00:00)` from `Notification`).

## choose-tree view (`prefix s` / `prefix S`)

`prefix s` opens the full session list; `prefix S` opens the same list
filtered to sessions where Claude is waiting on input:

```
bind s run-shell "~/.dotfiles/bin/tmux-claude-refresh-status" \; \
    choose-tree -Zs -O time \
        -F "#{?@claude_title,#[fg=blue]#{@claude_title}#[default]  ,}#{?session_attached,#[fg=cyan]●#[default],·} #{@claude_status}#{?@claude_summary,  #{=60:@claude_summary},}"

bind S run-shell "~/.dotfiles/bin/tmux-claude-refresh-status" \; \
    choose-tree -Zs -O time \
        -f "#{m:*waiting*,#{@claude_status}}" \
        -F "#{?@claude_title,#[fg=blue]#{@claude_title}#[default]  ,}#{?session_attached,#[fg=cyan]●#[default],·} #{@claude_status}#{?@claude_summary,  #{=60:@claude_summary},}"
```

Row layout (after tmux's `session-name:` tree label, which `-F` can't replace):

```
Auth refactor  ●  ⏸ waiting! (01:23)        last prompt or reply truncated to 60 chars
└─────┬─────┘ └┬┘ └────────┬────────┘└─┬┘   └────────────────────┬────────────────────┘
      │        │           │           │                          │
      │        │           │           padding (variable)         summary
      │        │           status (22 cells visible)
      │        attached marker (● cyan / · dim)
      manual title (blue, conditional — omitted entirely if @claude_title is empty)
```

- `@claude_title` is rendered in blue and only takes space when set; sessions
  without a title start straight at the marker. Variable width across rows —
  same fundamental cross-row alignment limit as choose-tree itself.
- `●` (cyan) marks the attached session, `·` marks detached.
- `-O time` sorts by last activity → freshly active sessions float to the top.
- `-f "#{m:*waiting*,#{@claude_status}}"` (only on `bind S`) filters to rows
  whose `@claude_status` matches `*waiting*`.
- Elapsed format: `MM:SS` under an hour, `Xh Ym` beyond.

### Known limit: cross-row column alignment

`choose-tree` prepends `session_name:` to every row and there is no flag to
suppress it. Session names of different lengths therefore start the format
output at different X positions, so columns don't line up across rows. The
status block itself is fixed-width (22 cells) and color-coded so within-row
scanning works fine — but for true grid alignment use the fzf picker below.

## fzf picker (`prefix C-s`)

`bin/tmux-claude-picker` is an alternative session switcher that opens in a
`display-popup` with a fully-controlled row layout and a live preview pane:

```
bind C-s display-popup -E -w 90% -h 80% '~/.dotfiles/bin/tmux-claude-picker'
```

Why have both? choose-tree wins on zero-deps and tmux-native integration;
the picker wins on visual structure. Both are wired and the picker is
additive — falling back to `prefix s` always works.

### Row layout

```
            .dotfiles  Auth refactor    ●  ⚡ working (01:23)   Działa. Wyciąg...
      storefront-apps  Disputes copy    ·  ⏸ waiting! (33:15)   Yes — `git worktree...`
storefront-apps-home-…                  ·  ⏸ waiting (40h 20m)  /1_research-codebase...
                 omni  Public chat MVP  ·  ⏸ waiting! (14:59)   ## How public conversations...
└──────┬──────┘ └────────┬────────┘ ┬   └─────────┬─────────┘  └─────────┬──────────┘
       │                 │          │             │                       │
       │                 │          │             │                       summary (cut to 80ch)
       │                 │          │             status (ANSI, 22 cells)
       │                 │          attached marker (● cyan / · dim)
       │                 manual title column (only shown if any session has @claude_title)
       session name (right-aligned, padded to max width across rows, cap 50ch)
```

- Sessions sorted by `session_activity` (most recent first).
- Title column is dynamic: if no session has a title, the column disappears
  entirely (no dead whitespace).
- Names longer than 50ch get an ellipsis (`…`).
- Color tiers are the same as choose-tree, just emitted as ANSI escape
  sequences instead of tmux format markers.

### Preview pane

`tmux capture-pane -e -p -t {window_id} -S -200` shows the last 200 lines of
the session's claude window. If the session has multiple windows, the picker
picks the one with `@claude_started_at` or `@claude_waiting_since` set
(falling back to the active window if no claude state is present).

### Keys

| Key       | Action                       |
|-----------|------------------------------|
| `enter`   | `switch-client` to selection |
| `esc`     | cancel; no switch            |
| any text  | fzf fuzzy filter             |

### Why ANSI instead of tmux format strings

`fzf --ansi` honors raw escape sequences. `@claude_status` is written in
tmux format syntax (`#[fg=red,bold]…#[default]`) so `choose-tree` can
render it; that syntax means nothing to fzf. Rather than translating one to
the other, the picker re-derives the styled string from the source-of-truth
timestamps (`@claude_started_at`, `@claude_waiting_since`) using the same
tier thresholds as `tmux-claude-refresh-status`. This keeps the picker
independent of any later tweaks to the choose-tree format.

## Session titles (`prefix T`)

A manual label attached to each session, surfaced by both views:

- **choose-tree** (`prefix s` / `prefix S`): inline blue label right after
  the session name (variable width, omitted if no title is set).
- **fzf picker** (`prefix C-s`): its own column between the session name and
  the marker; the column collapses entirely if no session has a title yet.

Useful when several sessions share a directory pattern and you want to
remember what each is for ("Auth refactor", "Disputes copy", "MVP demo").

```
bind T command-prompt -I "#{@claude_title}" -p "Session title: " \
    { set-option @claude_title "%%" }
```

`set-option` without `-t` defaults to the current session — exactly what
`prefix T` always operates on. (Don't try `-t '#{session_name}'`:
`command-prompt`'s template is not format-expanded, so tmux takes the
literal string as a target and errors with "No such session #{session_name}".)

Flow:

1. From inside any session, hit `prefix T`.
2. The tmux command prompt opens in the status bar, **pre-filled with the
   current title** (so it's edit, not retype).
3. Type the new title and press enter; empty input clears it.

Persistence: `@claude_title` is a tmux user option — it lives for the
lifetime of the tmux server. Restarting tmux loses titles. If this becomes
painful, add write-through to `~/.local/share/tmux-claude/titles` on set
plus a load script on session-created hook. Deferred until needed.

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
- **`prefix C-s` does nothing / popup flashes and closes**: `fzf` not on
  tmux server's PATH. Confirm with
  `tmux display-popup -E "command -v fzf || echo missing"`. Either install
  fzf where the tmux server sees it (`brew install fzf`) or restart the
  tmux server after updating PATH (`tmux kill-server` then reopen).
- **Title column not showing in picker**: at least one session needs
  `@claude_title` set for the column to render. `tmux show-option -v -t
  <session> @claude_title` to inspect a single session.
- **Preview pane is wrong window**: the picker picks whichever window has
  claude state set; if a session has no claude state it falls back to the
  active window. Send any prompt to claude in the desired pane (which fires
  `UserPromptSubmit` → stamps `@claude_started_at`) and the picker will
  target that window on the next open.
