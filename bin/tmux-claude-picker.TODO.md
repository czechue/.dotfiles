# tmux-claude-picker — TODO

Replace `choose-tree -Zs` with a custom fzf-based picker so rows align in
real columns and the preview pane shows live Claude output (not just a 60-char
summary).

## Motivation

`choose-tree` prepends an unsuppressable `session_name:` label to every row.
Session names in this setup range from `apps` (4 chars) to
`storefront-apps-home-tab-chatbot-input` (38 chars), so format output starts
at a different X position on every row. The current implementation fixes
within-row alignment via padding inside `@claude_status`, but cross-row
columns will never line up under `choose-tree`. See
`tmux-claude-status.md` § "Known limit".

## Sketch

`bin/tmux-claude-picker` — bash script invoked from a tmux binding via
`display-popup -E`. Pipeline:

1. Enumerate windows via `tmux list-windows -a -F '...'` (same call shape as
   `tmux-claude-refresh-status` — reuse logic).
2. For each row build a fixed-width line: `marker | session | status | summary`
   with column widths computed from the popup width (`-w 90%`).
3. Pipe the lines into `fzf --ansi --preview '...'` inside the popup.
4. On `enter`, parse the selected line back to a session name and
   `tmux switch-client -t "$session"`.

Reuse: `format_elapsed`, `build_status`, and the age-tier classification
from `tmux-claude-refresh-status`. Extract them into a sourceable helper
(`bin/_tmux-claude-lib.sh`) so all three scripts share one source of truth.

## Wins over `choose-tree`

- **True column alignment** — column widths chosen by the picker, not by
  variable-length tree labels.
- **Live preview pane** — `--preview 'tmux capture-pane -p -t {session}:'`
  shows the last N lines of the Claude pane, so you see WHAT Claude said,
  not just the 60-char `@claude_summary`. This is the bigger UX win than
  alignment.
- **Custom keybinds inside fzf** — `enter` switch, `ctrl-k` kill session,
  `ctrl-n` ack notification (clear `@claude_waiting_since`), `ctrl-r` force
  refresh, `tab` multi-select for bulk ops.
- **Sub-second filter** — fzf fuzzy match on `session + status + summary`,
  much faster than tmux's `-f` filter regex.

## Tradeoffs / costs

- Loses tmux-native `prefix + s` muscle memory — keep the binding, just point
  it at the new script. The popup still opens with `prefix + s`.
- Loses tmux's hierarchical tree (sessions → windows → panes). Acceptable —
  the current binding uses `-Zs` (sessions only), so no tree expansion is
  used in practice.
- More code to maintain (~150 lines bash) vs the current ~15-line
  `choose-tree` invocation.
- Preview-pane `capture-pane` calls need to be cheap (popup re-renders on
  every cursor move). Cache or limit to last 50 lines.

## When to do this

Defer until usage shows the alignment gap actually hurts after a week or two
on the current `choose-tree` version. If the color tiers + summary truncation
do the triage job well enough, the custom picker is over-engineered.

## Open questions

- How to wire it into the existing claude lifecycle hooks without breaking
  the option-based status writes? Probably no change needed — picker reads
  the same `@claude_status` / `@claude_summary` options.
- Should the picker show *windows* (one row per claude pane) or *sessions*
  (one row per session, aggregating windows)? Current `-Zs` is per-session;
  if a session has 2 claude windows, only the active window's status shows.
  Per-window would be more accurate but adds rows.
- Preview pane width tradeoff vs row count visible. Probably split 50/50
  with a `--preview-window=right,50%`.
