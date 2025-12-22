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

## vim-surround - Text Manipulation

The `vim-surround` plugin provides powerful commands for adding, changing, and deleting surrounding characters (quotes, parentheses, brackets, tags, etc.).

### Core Commands

<div class="shortcuts-table" markdown>

| Command | Action | Example |
|---------|--------|---------|
| `ys{motion}{char}` | Add surround | `ysiw"` on `hello` → `"hello"` |
| `cs{old}{new}` | Change surround | `cs"'` on `"hello"` → `'hello'` |
| `ds{char}` | Delete surround | `ds"` on `"hello"` → `hello` |
| `S{char}` (Visual) | Surround selection | Select text + `S"` → `"text"` |

</div>

### Common Motion Examples

<div class="shortcuts-table" markdown>

| Shortcut | Description | Before | After |
|----------|-------------|--------|-------|
| `ysiw"` | Surround inner word with quotes | `hello` | `"hello"` |
| `ysiw(` | Surround with parens + space | `hello` | `( hello )` |
| `ysiw)` | Surround with parens (no space) | `hello` | `(hello)` |
| `ysiw{` | Surround with braces + space | `hello` | `{ hello }` |
| `ysiw}` | Surround with braces (no space) | `hello` | `{hello}` |
| `ysiw[` | Surround with brackets + space | `hello` | `[ hello ]` |
| `ysiw]` | Surround with brackets (no space) | `hello` | `[hello]` |
| `ysiw<em>` | Surround with HTML tag | `hello` | `<em>hello</em>` |
| `ysip"` | Surround inner paragraph | (paragraph) | `"paragraph"` |
| `yss"` | Surround entire line | `hello world` | `"hello world"` |

</div>

### Change Surround Examples

<div class="shortcuts-table" markdown>

| Shortcut | Description | Before | After |
|----------|-------------|--------|-------|
| `cs"'` | Change double to single quotes | `"hello"` | `'hello'` |
| `cs'` ` | Change quotes to backticks | `'hello'` | `` `hello` `` |
| `cs({` | Change parens to braces + space | `(hello)` | `{ hello }` |
| `cs)]` | Change parens to brackets | `(hello)` | `[hello]` |
| `cst"` | Change HTML tag to quotes | `<em>hello</em>` | `"hello"` |
| `cs"<p>` | Change quotes to HTML tag | `"hello"` | `<p>hello</p>` |

</div>

### Delete Surround Examples

<div class="shortcuts-table" markdown>

| Shortcut | Description | Before | After |
|----------|-------------|--------|-------|
| `ds"` | Delete surrounding quotes | `"hello"` | `hello` |
| `ds'` | Delete surrounding single quotes | `'hello'` | `hello` |
| `ds(` | Delete surrounding parentheses | `(hello)` | `hello` |
| `ds{` | Delete surrounding braces | `{ hello }` | `hello` |
| `ds[` | Delete surrounding brackets | `[hello]` | `hello` |
| `dst` | Delete surrounding HTML tag | `<div>hello</div>` | `hello` |

</div>

### TypeScript/JavaScript Workflows

<div class="shortcuts-table" markdown>

| Workflow | Commands | Example |
|----------|----------|---------|
| String to template literal | `cs'` ` | `'Hello ${name}'` → `` `Hello ${name}` `` |
| Array to object destructure | `cs[{` | `[a, b]` → `{ a, b }` |
| Function arg to object | `ysiw{` | `arg` → `{arg}` |
| Add JSX attribute quotes | `ysiw"` | `className` → `"className"` |
| Wrap in console.log | `ysiwfconsole.log` | `variable` → `console.log(variable)` |

</div>

### Visual Mode Surround

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| `viw` + `S"` | Select word, surround with quotes | Quick surround |
| `vi{` + `S(` | Select inside braces, wrap in parens | Nested surround |
| `V` + `S<div>` | Select line, wrap in HTML tag | HTML workflow |
| `viw` + `S` ` | Select word, make template literal | TypeScript |

</div>

### Pro Tips

!!! tip "Faster than Visual Mode"
    Instead of selecting text first (`viw` + `S"`), use `ysiw"` directly - it's faster!

    - ❌ Slow: `viw` → `S"` (4 keystrokes)
    - ✅ Fast: `ysiw"` (4 keystrokes, but no mode switching)

!!! tip "Use Dot Repeat"
    After `ysiw"`, press `.` to repeat on next word. Navigate with `w`, repeat with `.`

!!! tip "TypeScript Template Literals"
    Quick conversion: `cs'` ` (change single quotes to backticks)

!!! tip "HTML Tag Editing"
    - `cst<span>` - Change tag to `<span>`
    - `dst` - Delete tag entirely

## Editor Font Size / Zoom

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++cmd+equal++ or ++cmd+plus++ | Increase font size (zoom in) | Editor |
| ++cmd+minus++ | Decrease font size (zoom out) | Editor |
| ++space+z+i++ | Zoom in (alternative) | Editor |
| ++space+z+o++ | Zoom out (alternative) | Editor |
| ++space+z+r++ | Reset font size | Editor |

</div>

## Code Folding

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+z+c++ | Collapse region (fold code) | Code Folding |
| ++space+z+e++ | Expand region (unfold code) | Code Folding |
| ++space+z+shift+c++ | Collapse all regions | Code Folding |
| ++space+z+shift+e++ | Expand all regions | Code Folding |

</div>

!!! warning "Behavior Changed: Cmd+/- Now Control Zoom"
    **Previous behavior** (standard IntelliJ):

    - ++cmd+minus++ → Collapse code region (folding)
    - ++cmd+plus++ → Expand code region (folding)

    **New behavior** (optimized for zoom):

    - ++cmd+minus++ → **Zoom out** (decrease font size)
    - ++cmd+plus++ → **Zoom in** (increase font size)
    - ++space+z+c++ → Collapse code (folding alternative)
    - ++space+z+e++ → Expand code (folding alternative)

    **Rationale**: Cmd+/- is more intuitive for zoom (matches browser behavior). Code folding is less frequently used, so moved to leader-key.

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
