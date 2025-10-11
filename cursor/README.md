# Cursor Configuration

Configuration files for Cursor IDE with Vim mode and IntelliJ-style keybindings.

## Files

- `settings.json` - Main Cursor settings including Vim configuration
- `keybindings.json` - Custom keyboard shortcuts

## Setup

To use these configurations, symlink them to Cursor's User directory:

```bash
# Backup existing configs (optional)
mv ~/Library/Application\ Support/Cursor/User/settings.json ~/Library/Application\ Support/Cursor/User/settings.json.backup
mv ~/Library/Application\ Support/Cursor/User/keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json.backup

# Create symlinks
ln -sf ~/.dotfiles/cursor/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
ln -sf ~/.dotfiles/cursor/keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json
```

## Requirements

- **Vim extension** (`vscodevim.vim`) must be installed in Cursor
  - Install via: `Cmd+Shift+X` → search "Vim" → Install

## Key Features

### Vim Configuration
- Leader key: `Space`
- Clipboard integration
- Scrolloff: 10 lines
- Vim-surround enabled
- Multiple cursors support

### Window Navigation (Vim-style)
- `Ctrl+h/j/k/l` - Navigate between splits
- `Ctrl+E` - Toggle file explorer
- `Space+w+v` - Split vertically
- `Space+w+h` - Split horizontally

### Search & Navigation (Telescope-style)
- `Space+s+f` - Find files
- `Space+s+g` - Find in files (grep)
- `Space+s+s` - Go to symbol
- `Space+s+a` - Command palette
- `Space+s+r` - Recent files

### LSP Features
- `Space+g+d` - Go to definition
- `Space+g+y` - Go to type definition
- `Space+g+i` - Go to implementation
- `Space+r+n` - Rename symbol

### Code Actions
- `Space+c+a` - Code actions (quick fix)
- `Space+Space` - Format document
- `Space+o+i` - Organize imports

### AI Suggestions (Cursor-specific)
- `Tab` - Accept full suggestion
- `Cmd+→` - Accept next word
- `Cmd+Shift+→` - Accept next line
- `Esc` - Reject suggestion

### IntelliJ-style Shortcuts
- `Cmd+1` - Toggle sidebar (like IntelliJ)
- `Cmd+Shift+R` - Replace in files
- `Shift+Space` - Show suggestions (normal mode)

### Multiple Cursors
- `Ctrl+G` - Add next occurrence
- `Space+Ctrl+G` - Select all occurrences
- `Cmd+Shift+L` - Select all highlights

### Other
- `Shift+J/K` (visual mode) - Move lines up/down
- `Space+e+n/p` - Next/previous error

## Notes

- Partial accepts must be enabled in Cursor Settings
- `Option+→/←` reserved for macOS word navigation
- Compatible with AeroSpace window manager (no key conflicts)
