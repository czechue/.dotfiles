# Cursor

AI-powered IDE based on VS Code with Vim mode and custom keybindings.

**Configuration**: `cursor/keybindings.json`, `cursor/settings.json`

## AI Features

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++cmd+i++ | Open composer mode | AI |
| ++cmd+k++ | Inline AI edit | AI |
| ++cmd+shift+l++ | Open AI chat | AI |

</div>

## Editor

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+e++ | Toggle explorer sidebar | Editor |
| ++shift+space++ | Trigger suggestions | Editor |
| ++cmd+1++ | Toggle sidebar visibility | Editor |
| ++cmd+right++ | Accept inline suggestion word | Editor |

</div>

## Vim Mode - Window Navigation

Leader key: ++space++

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+h++ | Navigate to left editor group | Window Navigation |
| ++ctrl+j++ | Navigate to lower editor group | Window Navigation |
| ++ctrl+k++ | Navigate to upper editor group | Window Navigation |
| ++ctrl+l++ | Navigate to right editor group | Window Navigation |

</div>

## Vim Mode - Window Management

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+w+v++ | Split editor vertically | Window |
| ++space+w+h++ | Split editor horizontally | Window |
| ++space+w+w++ | Close editor | Window |
| ++space+w+a++ | Close all editors | Window |

</div>

## Vim Mode - Search

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+s+f++ | Quick open (find files) | Search |
| ++space+s+g++ | Find in files | Search |
| ++space+s+s++ | Go to symbol | Search |
| ++space+s+a++ | Show all commands | Search |
| ++space+s+r++ | Show recent files | Search |

</div>

## Vim Mode - LSP

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+g+d++ | Go to definition | LSP |
| ++space+g+y++ | Go to type definition | LSP |
| ++space+g+i++ | Go to implementation | LSP |
| ++space+r+n++ | Rename symbol | LSP |

</div>

## Vim Mode - Code Actions

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+c+a++ | Show code actions | Code Actions |
| ++space+r+m++ | Extract to method | Refactoring |
| ++space+r+v++ | Extract to variable | Refactoring |

</div>

## Vim Mode - Multiple Cursors

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+g++ | Add next occurrence | Multiple Cursors |
| ++space+ctrl+g++ | Add all occurrences | Multiple Cursors |

</div>

## Vim Mode - Visual Mode

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++shift+j++ | Move line down | Visual Mode |
| ++shift+k++ | Move line up | Visual Mode |

</div>

## References

- **Keybindings**: `cursor/keybindings.json`
- **Vim Settings**: `cursor/settings.json`
- **Documentation**: `cursor/README.md`
