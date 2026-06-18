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

## Git Worktrees

Spin up a git worktree in its own tmux session for parallel / agentic work —
each worktree becomes a session that shows up in the ++ctrl+b+s++ Claude picker.
Backed by `bin/tmux-worktreeizer`.

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+b+shift+w++ | Open the worktree launcher (fzf popup) | Git Worktrees |

</div>

The popup lists existing worktrees, local branches, and `origin/*` branches.
Inside the popup these are **fzf** keys, not the tmux prefix:

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++enter++ | Open / check out the highlighted worktree or branch | Worktree picker |
| ++ctrl+n++ | Create a new branch from the typed query (forks from current `HEAD`) | Worktree picker |
| ++ctrl+d++ | Remove the highlighted worktree and kill its session | Worktree picker |

</div>

**How it fits the workflow:**

- Worktrees are created as **siblings** of the repo: `../<repo>-<branch>` (a branch
  like `feature/auth` is slugged to `feature-auth` for the directory name).
- The new session is named like `tmux-sessionizer` (`basename | tr . _`), so it
  appears in the ++ctrl+b+s++ / ++ctrl+b+shift+s++ Claude pickers automatically,
  with the branch shown as a blue `@claude_title` label.
- Works from inside a linked worktree too (it walks up to the main worktree). Run
  it outside any repo and it falls back to fuzzy-picking one.

!!! note "Good to know"
    - **New branches fork from the current `HEAD`** — run ++ctrl+b+shift+w++ from
      your default-branch session for the usual "fresh branch off main" behaviour.
    - ++ctrl+d++ on a **dirty** worktree prompts before force-removing (it discards
      uncommitted/untracked changes — explicit `y` required, never silent); it
      never touches the worktree of the session you're currently in.
    - Long worktree session names can overflow the name column in the
      ++ctrl+b+s++ tree view — see `tmux/TODO.md`.

**Typical flow:**

1. ++ctrl+f++ into a repo session.
2. ++ctrl+b+shift+w++, type a branch name, ++ctrl+n++ → new worktree + session.
3. Work in it / launch your coding agent there.
4. ++ctrl+b+s++ to hop between worktree sessions by their branch labels.
5. ++ctrl+b+shift+w++ → ++ctrl+d++ to tear a worktree down when finished.

## References

- **Config**: `tmux/.tmux.conf`
- **Scripts**: `bin/tmux-sessionizer`, `bin/tmux-worktreeizer`
