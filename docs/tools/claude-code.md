# Claude Code

One clean setup for everything. There is no longer a "clean" and a "messy" instance — PAI has been cut out of the global configuration entirely.

**Configuration**: `claude/settings.json` and `claude/CLAUDE.md`, symlinked into `~/.claude/` (the default config dir), plus `claude/system-prompt.md` passed on the command line

## Launchers

| Command | What it does |
|---|---|
| `cl` | self-update, then `claude --dangerously-skip-permissions` |
| `ccl` | alias of `cl`, kept for muscle memory |
| `clr` | `cl --resume` |
| `clsr` | `claude --resume`, with permission prompts |

All of them use the default config dir, so they share one `settings.json`, one history and one login. Defined in `zsh/.zshrc`.

## System prompt

`claude/system-prompt.md` is appended to every session via `--append-system-prompt-file`. It is a vendored third-party prompt — [disler/fixing-smartass-opus-5](https://github.com/disler/fixing-smartass-opus-5), `sr_opus_5_system_prompt.md` — kept verbatim under a provenance header, and it tightens response style: state each fact once, no analogies, no flattery, reference codes (`F1`, `D1`, `R1`, …) when listing three or more items, and hard scope boundaries.

It also defines four aliases you can type as a whole message: `scr` (simplify and compress), `eli` (explain like I'm 18), `foc` (boil down to what matters), `ref` (rewrite with reference codes).

!!! note "One rule conflicts with this repo's git convention"
    The prompt says *never add a co-author to a commit message*. Claude Code otherwise appends a `Co-Authored-By` trailer by default. The prompt wins in sessions launched through `cl`.

Unlike `settings.json`, this is a CLI flag rather than config — a bare `claude` invocation does **not** get it. Add the flag by hand if you launch Claude Code some other way.

## The PAI separation

PAI/LifeOS used to be wired in globally: `~/.claude` was a symlink into `~/personal/pai/.claude`, so every session — whatever `CLAUDE_CONFIG_DIR` said — loaded PAI's `CLAUDE.md` and its six `@`-imported LifeOS identity files.

!!! info "Why `CLAUDE_CONFIG_DIR` was not enough"
    `CLAUDE_CONFIG_DIR` redirects `settings.json`, `agents/`, `commands/`, `skills/`, plugins, credentials and history — but **not** the user-level `CLAUDE.md`. That file is always read from `~/.claude/CLAUDE.md`, in addition to any `CLAUDE.md` in the config dir. `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` does not suppress it either. So as long as `~/.claude` pointed at PAI, every session inherited it.

The cut, made 2026-08-30:

- `~/.claude` is now a real directory holding only the two dotfiles symlinks.
- `~/.claude.json` is a real file (was a symlink into the PAI repo). Rebuilt from PAI's copy with `projects` and `mcpServers` stripped, so the login carries over but PAI's MCP servers and project history do not.
- `~/.env` now points at `~/personal/pai/.claude/.env` directly instead of hopping through `~/.claude`.
- `zsh/.zshrc` no longer sources `~/personal/pai/.claude/zshrc-aliases`. The launchers, `ccusage`/`ccu`, `lifeos` and `discord` are defined here instead, with `PAI_DIR` pointing at the real path.

PAI is now **project-scoped**: running Claude Code inside `~/personal/pai` picks up that repo's `.claude/CLAUDE.md` and `.claude/settings.json` the same way any project's config is picked up. Nowhere else.

!!! warning "PAI's own config still hardcodes `$HOME/.claude`"
    Its `settings.json` has ~44 references to `$HOME/.claude/hooks/…` and some absolute `/Users/michallester/.claude/…` paths, which no longer resolve — session hooks fail with "No such file or directory". They need repointing to `$CLAUDE_PROJECT_DIR/.claude/…`. Note that `settings.json` there is *generated* by `MergeSettings.ts` from `settings.system.json`, so the fix belongs in the source file, not the output.

## What the setup deliberately does not have

No hooks, no plugins, no marketplaces, no MCP servers, no permission allowlist, no agents or commands. Things get added back only when they earn their place — and, once added, committed here so the setup stays reproducible.

The permission allowlist is empty on purpose: `cl` passes `--dangerously-skip-permissions`, which makes an allowlist inert anyway. If that flag is ever dropped, rebuild the list from real usage with `/fewer-permission-prompts` rather than by hand.

Only `.env` files are denied. Deny rules for writes must be written as `Edit(**/.env)` — `Write(...)` rules are ignored for file permission checks, and Claude Code prints a startup warning if you use them.

## Adding something back

```bash
$EDITOR ~/.dotfiles/claude/settings.json   # edit the tracked file, not the symlink
```

Changes take effect on the next session. `/config` and `/permissions` write to the same file through the symlink, so commit after using them.

The tmux status-line integration (`bin/tmux-claude-status`) is not wired up. To restore it, add a `hooks` block with `UserPromptSubmit`, `PreToolUse`, `Stop` and `Notification` entries calling that script — see `docs/tools/tmux.md`.

## Legacy

`~/.claude-clean` is a previous "clean" attempt: ~1000 startups of accumulated state, 174 MB of transcripts, five plugins and a 147-entry permission allowlist. Superseded; delete it once nothing is needed from its `--resume` history. The `claude-clean` and `claude-storefront` aliases in `zsh/.zshrc` still point at it.

Pre-cut symlink state and PAI's original `.claude.json` are backed up under `~/.claude-backups/hard-cut-*/`.
