# Symbol Layer - Glove80

Detailed reference for the Symbol layer, optimized for programming and text editing.

![Symbol Layer](symbol.svg)

---

## Layer Overview

The Symbol layer provides quick access to all programming symbols without requiring Shift modifiers. It's designed to keep your hands in the home position while typing code.

**Activation**: Hold the Symbol key on the right thumb cluster (Space key position on base layer).

---

## Left Hand Layout

### Top Row (Number Row Position)
<div class="shortcuts-table" markdown>

| Position | Key | Description |
|----------|-----|-------------|
| Grave | `` ` `` | Backtick for markdown, command substitution |
| Comma | `,` | Comma (direct access) |
| Left Paren | `(` | Opening parenthesis |
| Right Paren | `)` | Closing parenthesis |
| Semi | `;` | Semicolon |
| Dot | `.` | Period/dot |

</div>

### Home Row 1 (Q-T Position)
<div class="shortcuts-table" markdown>

| Position | Key | Description |
|----------|-----|-------------|
| Exclaim | `!` | Exclamation mark, logical NOT |
| Left Bracket | `[` | Opening square bracket, arrays |
| Left Brace | `{` | Opening curly brace, blocks |
| Right Brace | `}` | Closing curly brace |
| Right Bracket | `]` | Closing square bracket |
| Question | `?` | Question mark, ternary operator |

</div>

### Home Row 2 (A-G Position)
<div class="shortcuts-table" markdown>

| Position | Key | Description |
|----------|-----|-------------|
| Hash | `#` | Hash/pound, comments, preprocessor |
| Caret | `^` | Caret, XOR operator, regex start |
| Equal | `=` | Assignment operator |
| Underscore | `_` | Underscore, variable names |
| Dollar | `$` | Dollar sign, variables, jQuery |
| Asterisk | `*` | Asterisk, multiply, pointers |

</div>

### Bottom Row (Z-B Position)
<div class="shortcuts-table" markdown>

| Position | Key | Description |
|----------|-----|-------------|
| Tilde | `~` | Tilde, home directory, bitwise NOT |
| Less Than | `<` | Less than, HTML tags, redirects |
| Pipe | `\|` | Pipe, OR operator, shell pipes |
| Minus | `-` | Minus/hyphen, subtract |
| Greater Than | `>` | Greater than, arrows, redirects |
| Forward Slash | `/` | Forward slash, divide, paths |

</div>

### Thumb Cluster (Left)
<div class="shortcuts-table" markdown>

| Position | Key | Description |
|----------|-----|-------------|
| Transparent | `▽` | Pass through to base layer |
| Ampersand | `&` | Ampersand, AND operator, references |
| Single Quote | `'` | Single quote, strings, char literals |
| Double Quote | `"` | Double quote, strings |
| Plus | `+` | Plus, add, concatenate |

</div>

---

## Right Hand Layout

### Top Row (Number Row Position)
<div class="shortcuts-table" markdown>

| Position | Key | Description |
|----------|-----|-------------|
| All | `▽` | Transparent - pass through |

</div>

### Home Row 1 (Y-P Position)
<div class="shortcuts-table" markdown>

| Position | Key | Description |
|----------|-----|-------------|
| Grave | `` ` `` | Backtick (mirrored) |
| Delete | `Del` | Forward delete |
| Shift+Tab | `⇧Tab` | Reverse tab, outdent |
| Insert | `Ins` | Insert mode toggle |
| Escape | `Esc` | Escape, cancel |
| Transparent | `▽` | Pass through |

</div>

### Home Row 2 (H-; Position)
<div class="shortcuts-table" markdown>

| Position | Key | Description |
|----------|-----|-------------|
| Double Quote | `"` | Double quote (mirrored) |
| Backspace | `⌫` | Delete backward |
| Tab | `⇥` | Tab, indent |
| Space | `␣` | Space (direct access) |
| Enter | `↩` | Return/Enter |
| Transparent | `▽` | Pass through |

</div>

### Bottom Row (N-/ Position)
<div class="shortcuts-table" markdown>

| Position | Key | Description |
|----------|-----|-------------|
| Single Quote | `'` | Single quote (mirrored) |
| Cmd/GUI | `⌘` | Command key (macOS) / Super (Linux) |
| Ctrl | `⌃` | Control modifier |
| Alt | `⌥` | Alt/Option modifier |
| Shift | `⇧` | Shift modifier |
| Transparent | `▽` | Pass through |

</div>

### Thumb Cluster (Right)
<div class="shortcuts-table" markdown>

| Position | Key | Description |
|----------|-----|-------------|
| Backslash | `\` | Backslash, escape character |
| Dot | `.` | Dot/period |
| Asterisk | `*` | Asterisk (mirrored) |
| All Others | `▽` | Transparent - pass through |

</div>

---

## Common Programming Patterns

### Brackets and Braces
All bracket types are on the left hand for easy access:
- **Round**: `(` `)` on number row
- **Square**: `[` `]` on top home row
- **Curly**: `{` `}` on top home row  
- **Angle**: `<` `>` on bottom row

### Operators
Mathematical and logical operators grouped by function:
- **Arithmetic**: `+` `-` `*` `/` on left hand
- **Comparison**: `<` `>` `=` on left hand
- **Logical**: `!` `&` `|` on left hand  
- **Bitwise**: `^` `~` `&` `|` on left hand

### String Delimiters
All quote types accessible:
- **Single**: `'` on left thumb or right middle
- **Double**: `"` on left thumb or right index
- **Backtick**: `` ` `` on left top or right top

### Special Characters
Programming-specific symbols:
- **Hash**: `#` for comments, preprocessor, CSS IDs
- **Dollar**: `$` for variables, shell, jQuery
- **At**: `@` for decorators, email, mentions
- **Underscore**: `_` for snake_case, private members
- **Question**: `?` for ternary, optionals, regex

---

## Usage Tips

1. **Keep Fingers on Home Row**: The most common symbols are positioned to minimize finger travel
2. **Symmetric Design**: Common editing operations (Backspace, Delete, Tab, Space, Enter) mirrored on right hand
3. **Modifier Access**: Right hand provides Shift, Ctrl, Alt, Cmd for easy key combinations
4. **Pair Programming**: Brackets and quotes are positioned to allow quick pair insertion

---

## Quick Reference

### Most Used Symbols (Programming)
| Symbol | Location | Use Case |
|--------|----------|----------|
| `=` | Left Index (Home) | Assignment |
| `(` `)` | Left Top Row | Function calls |
| `{` `}` | Left Top Row | Code blocks |
| `[` `]` | Left Top Row | Arrays, indexing |
| `"` `'` | Left Thumb / Right Hand | Strings |
| `;` | Left Top Row | Statement end |
| `.` | Left Top Row / Right Bottom | Member access |
| `*` | Left Home / Right Thumb | Multiply, pointers |
| `/` | Left Bottom / Right Bottom | Divide, comments |

### Editing Operations
| Action | Location | Shortcut |
|--------|----------|----------|
| Delete Forward | Right Top | `Del` |
| Delete Backward | Right Home | `⌫` |
| Indent | Right Home | `⇥` |
| Outdent | Right Top | `⇧⇥` |
| Cancel | Right Top | `Esc` |

---

[← Back to Glove80 Overview](glove80.md)
