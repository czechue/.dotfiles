# tmux — open items

## Fixed-width folder column in `prefix s` (choose-tree)

### Problem

In `prefix s` (and `prefix S`), long session names like
`storefront-apps-product-catalog-omni` push the subsequent columns
(claude title, status, summary) far to the right, breaking column
alignment across rows. The fzf picker (`prefix C-s`) already solves
this with leading-ellipsis truncation (`…catalog-omni`), but
choose-tree does not.

### Why it's not configurable

tmux's choose-tree renders each row as:

```c
xasprintf(&text, "%-*s%s%s%s%s", keylen, key, start, mti->name, tag, ": ");
```

— in `mode-tree.c:709`. `mti->name` is `xstrdup(item->session->name)`,
i.e. the literal session name pulled directly from the session struct.
The `-F` format we pass to choose-tree is appended AFTER this auto-prefix
and cannot replace it.

We already pad the gap *after* the auto-prefix with spaces (via
`#{p-:}` in `.tmux.conf`) so that short names line up to ~24 cells,
but long names overflow that budget and there's no way to truncate
them from configuration.

### The only path forward: rename the session itself

Because the auto-prefix reads `session->name` directly, the only lever
is the session name itself. This requires three coordinated pieces:

1. **`tmux-shorten-session-names` script.** Iterates sessions, renames
   any with `len > 22` to leading-ellipsis form. Only touches
   "auto-named" sessions where `name == basename(session_path) | tr . _`
   so manually-renamed sessions stay untouched. Bash 3.2 compatible
   (no `declare -A`) so it works inside tmux popups on macOS where
   `env bash` may resolve to `/bin/bash`.

2. **Wire into `prefix s` / `prefix S`** to run before choose-tree
   (same pattern as `tmux-claude-refresh-status` today).

3. **Update `tmux-sessionizer` to look up by `session_path`, not by
   session name.** Otherwise: sessionizer opens a known directory,
   checks `has_session "$dirname"`, doesn't find one (it was renamed),
   creates a duplicate. Sessionizer should also create new sessions
   with the shortened name from the start so the shortener has
   nothing to do on the first `prefix s`.

### Consequences to accept before doing this

- **Sessions rename themselves on `prefix s`.** Predictable
  (deterministic algorithm) but a surprising side-effect to remember.
- **Heuristic for "auto-named" can drift.** If sessionizer ever
  changes its naming convention, the shortener will stop touching
  sessions it should still touch — needs to be kept in sync.
- **Suffix collisions** between two different paths that share a
  trailing segment (`/a/foo/storefront-apps`, `/b/bar/storefront-apps`)
  would shorten to the same display name. Sessionizer's collision
  handling falls back to the full name in that case; rare in practice.
- **`tmux-sessionizer` becomes path-centric.** Name no longer is the
  primary key. Workflow stays the same from the user's side; only
  the lookup mechanism changes.

### Cheaper alternatives we already discussed

- **Rebind `prefix s` to the fzf picker.** Zero work, gets the exact
  column layout the user wants. Loses choose-tree's native shortcuts
  (number keys, in-mode search via `C-s`) and tree expansion to show
  windows. Considered but rejected by user — they want this in
  choose-tree.
- **Manual `prefix T` to set `@claude_title`.** Already works for
  adding a custom inline label, but doesn't shrink the folder column.

### Decision pending

Three options were presented to the user (2026-05-28):
1. Do it: shortener + sessionizer update + auto-bind to `prefix s`.
2. Do it but no auto-bind — script run manually.
3. Drop it, rebind `prefix s` to fzf picker instead.

The user paused to ask for this documentation file before deciding.
