# Git Scripts

Custom git subcommands that extend git via its executable-discovery mechanism: any `git-<name>` executable on `PATH` becomes available as `git <name>` — no aliases or gitconfig changes needed.

**Location**: `bin/` (symlinked into `~/bin`, which is on `PATH`)

## Where git scripts live

Git helper scripts follow the same pattern as the tmux helpers (`tmux-sessionizer`, `tmux-worktreeizer`):

1. The script lives in `~/.dotfiles/bin/git-<name>` (versioned in the repo)
2. It is symlinked into `~/bin`:

    ```bash
    ln -sf ~/.dotfiles/bin/git-<name> ~/bin/git-<name>
    ```

3. Git picks it up automatically as `git <name>`

Third-party scripts are **vendored** (copied into `bin/` with a provenance header noting the upstream repo, commit, and license) rather than installed via Homebrew — this keeps them versioned alongside the rest of the dotfiles and consistent with the repo's manual-symlink philosophy. To update a vendored script, re-copy it from upstream and refresh the header.

## Installed Scripts

### git open

Opens the repo's website (GitHub/GitLab/Bitbucket/etc.) in the default browser.

Vendored from [paulirish/git-open](https://github.com/paulirish/git-open) (MIT).

| Command | Action |
|---------|--------|
| `git open` | Open the page for the current branch on the current remote |
| `git open <remote>` | Open a specific remote, e.g. `git open upstream` |
| `git open <remote> <branch>` | Open a specific branch on a specific remote |
| `git open --issue` | Open the issue page (when on an issue branch like `issues/#123`) |
| `git open --commit` | Open the page for the current commit |
| `git open --print` | Print the URL instead of opening it |
| `git open --suffix <suffix>` | Append an arbitrary path, e.g. `git open --suffix pulls` |

Works with GitHub, GitLab (including self-hosted), Bitbucket, Azure DevOps, Gitea, and more.

## Adding a New Git Script

```bash
# 1. Create (or vendor) the script
$EDITOR ~/.dotfiles/bin/git-myscript
chmod +x ~/.dotfiles/bin/git-myscript

# 2. Symlink it
ln -sf ~/.dotfiles/bin/git-myscript ~/bin/git-myscript

# 3. Use it
git myscript
```

Document it on this page and commit both.
