# IdeaVim

Vim emulation plugin for IntelliJ IDEA with custom keybindings matching Neovim patterns.

**Configuration**: `ideavim/.ideavimrc`
**Leader Key**: ++space++

> **📚 Complete Documentation**: This page covers IdeaVim (Vim mode) shortcuts only. For full IntelliJ IDEA setup:
> - 🎓 **[Mastery Path](./intellij-mastery-path.md)** - 6-week program to achieve fluency (START HERE!)
> - 📚 **[Complete Keybindings](./intellij-keybindings.md)** - Full reference with TypeScript focus
> - ⚡ **[Quick Reference](./intellij-quick-ref.md)** - Top 30 essential shortcuts (printable)
> - 🔧 **[Improvements](./intellij-improvements.md)** - Recent optimizations & three-layer system

## Window Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+h++ | Move to left window | Window Navigation |
| ++ctrl+j++ | Move to lower window | Window Navigation |
| ++ctrl+k++ | Move to upper window | Window Navigation |
| ++ctrl+l++ | Move to right window | Window Navigation |

</div>

## Window Management

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+w+v++ | Split vertically | Window |
| ++space+w+h++ | Split horizontally | Window |
| ++space+w+w++ | Unsplit (close split) | Window |
| ++space+w+a++ | Unsplit all | Window |

</div>

## Search/Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+s+f++ | Go to file | Search |
| ++space+s+g++ | Find in path | Search |
| ++space+s+s++ | Go to symbol | Search |
| ++space+s+a++ | Go to action | Search |
| ++space+s+d++ | Show error description | Search |
| ++space+s+r++ | Recent files | Search |

</div>

## LSP/Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+g+d++ | Go to declaration | LSP |
| ++space+g+y++ | Go to type declaration | LSP |
| ++space+g+i++ | Go to implementation | LSP |
| ++space+g+t++ | Go to test | LSP |
| ++space+r+n++ | Rename element | LSP |

</div>

## Code Actions

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+c+a++ | Show intention actions (code actions) | Code Actions |
| ++space+s+w++ | Surround with | Code Actions |
| ++shift+space++ | Generate menu | Code Actions |
| ++space+r+m++ | Extract method | Refactoring |
| ++space+r+v++ | Introduce variable | Refactoring |
| ++space+r+f++ | Introduce field | Refactoring |

</div>

## Multiple Cursors

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+g++ | Select next occurrence | Multiple Cursors |
| ++space+ctrl+g++ | Select all occurrences | Multiple Cursors |
| ++alt+j++ | Add selection on next occurrence | Multiple Cursors |
| ++alt+shift+j++ | Unselect occurrence | Multiple Cursors |

</div>

## File Operations

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+q+q++ | Close content | File |
| ++space+q+a++ | Close all editors | File |

</div>

## References

- **Config**: `ideavim/.ideavimrc`
- **Plugins**: EasyMotion, Surround, Multiple Cursors, Commentary, Which-Key
- **Complete Guide**: [IntelliJ Keybindings (TypeScript-Focused)](./intellij-keybindings.md)
- **Quick Ref**: [30 Essential Shortcuts](./intellij-quick-ref.md)
