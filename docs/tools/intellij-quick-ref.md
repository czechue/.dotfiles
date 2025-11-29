# IntelliJ IDEA Quick Reference Card

> Top 30 Essential Shortcuts for TypeScript Full-Stack Development

**Print This**: One-page quick reference for daily use | [Full Documentation](./intellij-keybindings.md)

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

## 🧭 Navigation & LSP

| Shortcut | Action | Use Case |
|----------|--------|----------|
| ++cmd+b++ | Go to declaration/definition | Jump to source |
| ++space+g+i++ | Go to implementation | Find interface implementations |
| ++space+g+y++ | Go to type declaration | Jump to TypeScript type |
| ++option+f7++ | Find usages | Where is this used? |
| ++cmd+[++ / ++cmd+]++ | Navigate back/forward | Jump history |

---

## ✏️ Editing & Refactoring

| Shortcut | Action | Use Case |
|----------|--------|----------|
| ++option+enter++ | **Context actions / Quick fixes** | **⭐ Auto-import, fix errors** |
| ++shift+f6++ | Rename symbol | Rename across project |
| ++cmd+option+v++ | Extract variable | Refactor to variable |
| ++cmd+option+m++ | Extract method | Refactor to function |
| ++cmd+option+o++ | Optimize imports | Remove unused imports |
| ++cmd+slash++ | Toggle comment | Comment/uncomment code |

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

### Daily Habits
1. **Replace mouse with keyboard**: When you click something, press ++cmd+z++ and find the keyboard shortcut using ++cmd+shift+a++
2. **Use ++option+enter++ constantly**: Auto-import, fix ESLint, quick fixes
3. **++shift+shift++ is your friend**: Search files, symbols, actions all at once

### Week 1 Focus
- Master: ++cmd+shift+a++, ++shift+shift++, ++option+enter++
- Practice: Window navigation with ++ctrl+h/j/k/l++

### TypeScript Workflow
1. Write code → ++option+enter++ for auto-imports
2. Refactor → ++shift+f6++ to rename, ++cmd+option+v++ to extract
3. Debug → ++ctrl+d++ + ++cmd+f8++ for breakpoints
4. Test APIs → Create `.http` files + ++ctrl+enter++

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
