# IntelliJ IDEA Quick Reference Card

> Top 30 Essential Shortcuts for TypeScript Full-Stack Development

**Print This**: One-page quick reference for daily use

**Related Docs**:
- 📚 **[Full Documentation](./intellij-keybindings.md)** - Complete keybindings reference
- 🎓 **[Mastery Path](./intellij-mastery-path.md)** - 6-week learning program with milestones
- 🔧 **[Improvements](./intellij-improvements.md)** - What changed and why

## 🎯 Three-Layer Shortcut System

Your config now supports **three speed tiers** - use the right one for your flow:

- **🏎️ Fast (1 key)**: Native shortcuts - `Cmd+B`, `Option+Enter` - Maximum speed
- **⚡ Medium (2 keys)**: Vim-style - `gd`, `gr`, `gi` - Balanced & familiar
- **🧭 Discoverable (3 keys)**: Leader-key - `Space+G+D` - Appears in Which-Key menu

**Tip**: Start with leader-key (discoverable), graduate to Vim-style (fast), use native (fastest).

---

## 🔍 Discovery & Search (Most Important!)

| Shortcut | Action | Mnemonic |
|----------|--------|----------|
| ++cmd+shift+a++ | **Find Action** - Search any command | **⭐ Learn this first!** |
| ++shift+shift++ | **Search Everywhere** - Files, symbols, actions | Double shift = search all |
| ++space+s+f++ | Find file | **S**earch **F**ile |
| ++space+s+g++ | Search in project (grep) | **S**earch **G**rep |
| ++cmd+e++ | Recent files | **E**dit history |

---

## 🧭 Navigation & LSP (Three Layers!)

### 🏎️ Fast Layer (Native - 1 key)
| Shortcut | Action | When to Use |
|----------|--------|-------------|
| ++cmd+b++ | Go to declaration | **Fastest** - use this most! |
| ++option+f7++ | Find usages | Where is this used? |
| ++cmd+[++ / ++cmd+]++ | Navigate back/forward | Jump history |

### ⚡ Medium Layer (Vim-style - 2 keys) **NEW!**
| Shortcut | Action | When to Use |
|----------|--------|-------------|
| ++g+d++ | Go to declaration | Vim muscle memory |
| ++g+r++ | Find usages (references) | Vim-style references |
| ++g+i++ | Go to implementation | Find implementations |
| ++g+h++ | Quick documentation | Hover docs (like Vim K) |

### 🧭 Discoverable Layer (Leader-key - 3 keys)
| Shortcut | Action | When to Use |
|----------|--------|-------------|
| ++space+g+d++ | Go to declaration | Learning, exploring |
| ++space+g+i++ | Go to implementation | Appears in Which-Key |
| ++space+g+y++ | Go to type declaration | TypeScript types |
| ++space+g+r++ | Find usages | Show all references |

---

## ✏️ Editing & Refactoring

### Critical Shortcuts (Learn These First!)
| Shortcut | Action | Importance |
|----------|--------|------------|
| ++option+enter++ | **Context actions / Quick fixes** | ⭐⭐⭐⭐⭐ **THE most important!** |
| ++ctrl+t++ | **Refactor This** (all refactorings menu) | ⭐⭐⭐⭐⭐ **One shortcut for everything!** |
| ++shift+f6++ | Rename symbol | ⭐⭐⭐⭐ Most common refactoring |
| ++cmd+option+l++ | Reformat code | ⭐⭐⭐⭐ Industry standard |

### Common Refactorings
| Shortcut | Action | Use Case |
|----------|--------|----------|
| ++space+rt++ | Refactor This menu | Alternative to Ctrl+T |
| ++space+shift+k++ | Quick documentation | Show docs for symbol |
| ++space+p++ | Parameter info | See method signatures |
| ++space+s+o++ | File structure | Quick symbol overview |
| ++cmd+option+v++ | Extract variable | Refactor to variable |
| ++cmd+option+m++ | Extract method | Refactor to function |
| ++cmd+option+o++ | Optimize imports | Remove unused imports |
| ++cmd+slash++ | Toggle comment | Comment/uncomment code |

### vim-surround - Fast Text Wrapping ⚡

!!! tip "Faster than Visual Mode Selection!"
    Use `ysiw{char}` instead of selecting text first - no mode switching required!

| Command | Example | Before → After | Use Case |
|---------|---------|----------------|----------|
| `ysiw"` | Cursor on word | `className` → `"className"` | JSX attributes |
| `ysiw{` | Cursor on word | `user` → `{user}` | Object shorthand |
| `cs'"` | Change quotes | `'text'` → `"text"` | Quote conversion |
| `cs'` ` | To template literal | `'Hello'` → `` `Hello` `` | Template strings |
| `ds"` | Delete quotes | `"text"` → `text` | Remove wrapping |
| `dst` | Delete HTML tag | `<div>text</div>` → `text` | Remove tags |

**Common Pattern**: `ysiw"` (4 keys) + `.` (repeat) is faster than `viw` + `S"` (mode switch)

### Zoom / Font Size & Code Folding

| Shortcut | Action | Notes |
|----------|--------|-------|
| ++cmd+plus++ or ++cmd+equal++ | Zoom in | ⚡ NEW! Now controls zoom (not folding) |
| ++cmd+minus++ | Zoom out | ⚡ NEW! Now controls zoom (not folding) |
| ++space+z+i/o/r++ | Zoom in/out/reset | Discoverable alternatives |
| ++space+z+c/e++ | Collapse/Expand code | NEW! Code folding moved here |

!!! tip "Behavior Changed"
    **Cmd+/-** now controls **zoom** (matches browser shortcuts). For **code folding**, use **Space+Z+C/E**.

---

## 🐛 Debugging

| Shortcut | Action | Use Case |
|----------|--------|----------|
| ++ctrl+d++ | Debug current file | Start debugging |
| ++cmd+f8++ | Toggle breakpoint | Set/remove breakpoint |
| ++f8++ | Step over | Next line |
| ++f7++ | Step into | Enter function |

---

## 🪟 Window Management (Vim Mode)

| Shortcut | Action | Mnemonic |
|----------|--------|----------|
| ++ctrl+h/j/k/l++ | Navigate panes | Vim directions |
| ++ctrl+e++ | Open Project window | Project **E**xplorer |
| ++cmd+1++ | Project window | Tool window 1 |
| ++cmd+2++ | Terminal window | Tool window 2 |

---

## 🔧 TypeScript Specific

| Shortcut | Action | Use Case |
|----------|--------|----------|
| ++cmd+shift+a++ → "npm" | Run npm scripts | Run dev/build/test |
| ++ctrl+enter++ | Execute HTTP request | Test APIs (in .http files) |
| ++cmd+option+l++ | Reformat code | Format with Prettier |

---

## 🤖 AI Assistants (Tabby)

| Shortcut | Action | Use Case |
|----------|--------|----------|
| ++tab++ | Accept next line | Accept AI completion |
| ++ctrl+right++ | Accept next word | Partial acceptance |
| ++ctrl+backslash++ | Trigger Tabby | Manual completion |

---

## 📦 Git

| Shortcut | Action | Use Case |
|----------|--------|----------|
| ++cmd+k++ | Commit dialog | Commit changes |
| ++cmd+9++ | Version Control window | View Git history |
| ++option+cmd+z++ | Revert changes | Undo file changes |

---

## 💡 Pro Tips

### Understanding the 3-Layer System

**When typing fast (flow state)**:
- Use native shortcuts: `Cmd+B`, `Option+Enter`, `Cmd+Option+L`
- One keystroke, maximum speed

**When using Vim muscle memory**:
- Use Vim-style: `gd`, `gr`, `gi`, `gh`
- Two keystrokes, familiar patterns

**When learning/exploring**:
- Use leader-key: `Space+G+D`, `Space+S+F`
- Three keystrokes, appears in Which-Key menu for discovery

### Daily Habits
1. **Master the critical two**: ++option+enter++ (auto-import/fix) and ++ctrl+t++ (refactor menu)
2. **Replace mouse with keyboard**: When you click → press ++cmd+z++ → use ++cmd+shift+a++ to find shortcut
3. **Use ++shift+shift++ for discovery**: Search files, symbols, actions all at once
4. **Graduate through layers**: Start with `Space+G+D`, practice `gd`, eventually use `Cmd+B`

### Week 1 Focus (Updated!)
- Master: ++cmd+shift+a++ (Find Action), ++shift+shift++ (Search Everywhere), ++option+enter++ (Quick Fixes)
- Learn: ++ctrl+t++ (Refactor This menu) - one shortcut for all refactorings!
- Practice: Window navigation with ++ctrl+h/j/k/l++
- Try: Vim-style navigation with ++g+d++, ++g+r++, ++g+i++

### TypeScript Workflow (Enhanced)
1. **Navigate**: `Cmd+B` (fastest) or `gd` (Vim-style) or `Space+G+D` (discoverable)
2. **Write code**: ++option+enter++ constantly for auto-imports and quick fixes
3. **Refactor**: ++ctrl+t++ to see all refactorings, choose from menu
4. **Rename**: ++shift+f6++ across entire project
5. **Debug**: ++ctrl+d++ + ++cmd+f8++ for breakpoints
6. **Document**: ++g+h++ or ++space+shift+k++ for quick docs
7. **Test APIs**: Create `.http` files + ++ctrl+enter++

### HTTP Client (Postman Alternative)
Create `api-requests.http`:
```http
### Test endpoint
GET http://localhost:3000/api/users
```
Press ++ctrl+enter++ to execute!

---

## 🎯 Learning Path

**Week 1**: Discovery tools (++cmd+shift+a++, ++shift+shift++) + Navigation (++ctrl+hjkl++)

**Week 2**: Refactoring (++shift+f6++, ++cmd+option+v++) + LSP (++space+g+*++)

**Week 3**: Debugging (++ctrl+d++, ++cmd+f8++) + HTTP Client (++ctrl+enter++)

**Week 4**: Git (++cmd+k++) + AI (++tab++) + Discovery mastery

---

**📚 Full Documentation**: [intellij-keybindings.md](./intellij-keybindings.md)
**⚙️ Configuration**: `ideavim/.ideavimrc` | `keymaps/macOS copy.xml`
**🎯 Focus**: TypeScript/JavaScript full-stack development
