# IntelliJ IDEA Complete Keybindings Reference (TypeScript-Focused)

> Comprehensive keyboard shortcuts for full-stack TypeScript development with IdeaVim, React/Vue, Node.js, and IntelliJ IDEA Ultimate

**Quick Navigation**: [IdeaVim](#ideavim-keybindings-vim-mode) | [Custom IDE](#custom-ide-shortcuts) | [TypeScript](#typescript-essential-shortcuts) | [Conflicts](#vim-vs-ide-conflicts) | [Learning Path](#typescript-focused-learning-path)

---

## IdeaVim Keybindings (Vim Mode)

IdeaVim custom mappings from `ideavim/.ideavimrc`. All mappings use **Space** as leader key.

### Window Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Mode | Context |
|----------|--------|------|---------|
| ++ctrl+h++ | Move to left window | Normal | Window Navigation |
| ++ctrl+j++ | Move to lower window | Normal | Window Navigation |
| ++ctrl+k++ | Move to upper window | Normal | Window Navigation |
| ++ctrl+l++ | Move to right window | Normal | Window Navigation |
| ++ctrl+e++ | Activate Project Tool Window | Normal | Override (IDE wins) |

</div>

### Window Management

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+w+v++ | Split vertically | Window |
| ++space+w+h++ | Split horizontally | Window |
| ++space+w+w++ | Unsplit (close current split) | Window |
| ++space+w+a++ | Unsplit all (close all splits) | Window |

</div>

### Search & Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | IntelliJ Action | Context |
|----------|--------|-----------------|---------|
| ++space+s+f++ | Go to file | `GotoFile` | Search |
| ++space+s+g++ | Find in path (grep) | `FindInPath` | Search |
| ++space+s+s++ | Go to symbol | `GotoSymbol` | Search |
| ++space+s+a++ | Go to action | `GotoAction` | Search |
| ++space+s+d++ | Show error description | `ShowErrorDescription` | Search |
| ++space+s+r++ | Recent files | `RecentFiles` | Search |

</div>

### LSP/Code Intelligence

<div class="shortcuts-table" markdown>

| Shortcut | Action | IntelliJ Action | Context |
|----------|--------|-----------------|---------|
| ++space+g+d++ | Go to declaration | `GotoDeclaration` | LSP |
| ++space+g+y++ | Go to type declaration | `GotoTypeDeclaration` | LSP |
| ++space+g+i++ | Go to implementation | `GotoImplementation` | LSP |
| ++space+g+t++ | Go to test / Create test | `GotoTest` | LSP |
| ++space+r+n++ | Rename element | `RenameElement` | LSP |

</div>

### Code Actions & Refactoring

<div class="shortcuts-table" markdown>

| Shortcut | Action | IntelliJ Action | Context |
|----------|--------|-----------------|---------|
| ++space+c+a++ | Show intention actions (code actions) | `ShowIntentionActions` | Code Actions |
| ++space+s+w++ | Surround with | `SurroundWith` | Code Actions |
| ++shift+space++ | Generate menu (constructor, getter, etc.) | `Generate` | Code Actions |
| ++space+r+m++ | Extract method | `ExtractMethod` | Refactoring |
| ++space+r+v++ | Introduce variable | `IntroduceVariable` | Refactoring |
| ++space+r+f++ | Introduce field | `IntroduceField` | Refactoring |

</div>

### Error Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | IntelliJ Action | Context |
|----------|--------|-----------------|---------|
| ++space+e+n++ | Go to next error | `GotoNextError` | Errors |
| ++space+e+p++ | Go to previous error | `GotoPreviousError` | Errors |

</div>

### File Operations

<div class="shortcuts-table" markdown>

| Shortcut | Action | IntelliJ Action | Context |
|----------|--------|-----------------|---------|
| ++space+q+q++ | Close current editor | `CloseContent` | File |
| ++space+q+a++ | Close all editors | `CloseAllEditors` | File |
| ++space+n+f++ | New file | `NewFile` | File |
| ++space+n+d++ | New directory | `NewDir` | File |

</div>

### Code Formatting

<div class="shortcuts-table" markdown>

| Shortcut | Action | IntelliJ Action | Context |
|----------|--------|-----------------|---------|
| ++space+f++ | Reformat code | `ReformatCode` | Formatting |
| ++space+o+i++ | Optimize imports | `OptimizeImports` | Formatting |

</div>

### Text Manipulation

<div class="shortcuts-table" markdown>

| Shortcut | Action | IntelliJ Action | Mode | Context |
|----------|--------|-----------------|------|---------|
| ++shift+j++ | Move line down | `MoveLineDown` | Visual | Editing |
| ++shift+k++ | Move line up | `MoveLineUp` | Visual | Editing |

</div>

### Multiple Cursors

<div class="shortcuts-table" markdown>

| Shortcut | Action | Mode | Context |
|----------|--------|------|---------|
| ++ctrl+g++ | Select next whole occurrence | Normal/Visual | Multiple Cursors |
| ++g+ctrl+g++ | Select next occurrence (partial) | Normal/Visual | Multiple Cursors |
| ++ctrl+x++ | Skip occurrence | Visual | Multiple Cursors |
| ++ctrl+p++ | Remove occurrence | Visual | Multiple Cursors |
| ++space+ctrl+g++ | Select all whole occurrences | Normal/Visual | Multiple Cursors |
| ++space+g+ctrl+g++ | Select all occurrences (partial) | Normal/Visual | Multiple Cursors |

</div>

**Note**: Multiple cursor shortcuts avoid macOS dead keys (`Alt+n` conflicts with ñ).

---

## Custom IDE Shortcuts

Custom keybindings from `keymaps/macOS copy.xml`. These override default IntelliJ shortcuts.

### Tool Windows

<div class="shortcuts-table" markdown>

| Shortcut | Action | Notes |
|----------|--------|-------|
| ++cmd+1++ | Activate Project Tool Window | Primary shortcut |
| ++ctrl+e++ | Activate Project Tool Window | Alternative (Vim override) |
| ++cmd+2++ | Activate Terminal Tool Window | Custom override |
| ++alt+f12++ | Activate Terminal Tool Window | Default shortcut |

</div>

### AI Assistants - Tabby

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++tab++ | Accept next line of completion | Editor |
| ++ctrl+right++ | Accept next word of completion | Editor |
| ++ctrl+tab++ | Full tab accept | Editor |
| ++ctrl+backslash++ | Trigger Tabby completion manually | Editor |
| ++alt+backslash++ | Trigger Tabby completion (alternative) | Editor |
| ++ctrl+l++ | Toggle Tabby Chat Tool Window | Global |

</div>

### AI Assistants - Copilot

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++shift+ctrl+g++ | Open inline chat | Editor |

</div>

### Other Customizations

<div class="shortcuts-table" markdown>

| Shortcut | Action | Notes |
|----------|--------|-------|
| ++cmd+shift+g++ | Go to Action | Custom override |
| ++cmd+right++ or ++end++ | Go to end of line | Editor |

</div>

---

## Vim vs IDE Conflicts

These shortcuts have different behaviors in Vim mode vs IDE mode. Configured in `vim_settings.xml`.

<div class="shortcuts-table" markdown>

| Shortcut | Vim Action | IDE Action | Winner | Notes |
|----------|------------|------------|--------|-------|
| ++ctrl+g++ | Next occurrence (multiple cursors) | Go to line | **Vim** | Multiple cursors more useful |
| ++ctrl+c++ | Escape / Cancel | Copy | **Vim** | Standard Vim behavior |
| ++ctrl+d++ | Scroll down half page | Duplicate line | **Vim** | Vim navigation |
| ++ctrl+n++ | Next completion / Down | New file | **Vim** | Vim completion |
| ++ctrl+b++ | Page up | Build project | **Vim** | Vim navigation |
| ++ctrl+o++ | Jump to previous location | Override method | **Vim** | Vim jump list |
| ++ctrl+p++ | Previous completion / Up | Print | **Vim** | Vim completion |
| ++ctrl+m++ | Enter | Commit message | **Vim** | Standard Vim |
| ++ctrl+i++ | Jump to next location | Implement methods | **Vim** | Vim jump list |
| ++ctrl+k++ | Move to upper window | Commit dialog | **Vim** | Window navigation |
| ++ctrl+2++ | Mark location | | **Vim** | Vim marks |
| ++ctrl+v++ | Visual block mode | Paste | **Vim** | Essential Vim mode |
| ++ctrl+j++ | Move to lower window | Insert live template | **Vim** | Window navigation |
| ++shift+right++ | Select to right | | **Vim** | Vim visual selection |
| ++ctrl+e++ | Scroll down one line | Activate Project window | **IDE** | Custom override in .ideavimrc |

</div>

**Key insight**: Vim wins most navigation and editing conflicts. Only `Ctrl+E` is overridden to activate Project window for quick access.

---

## TypeScript Essential Shortcuts

Native IntelliJ shortcuts prioritized for full-stack TypeScript development.

### TypeScript Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context | Priority |
|----------|--------|---------|----------|
| ++cmd+b++ | Go to declaration/definition | Editor | ⭐ Essential |
| ++cmd+click++ | Go to definition (mouse) | Editor | ⭐ Essential |
| ++cmd+option+b++ | Go to implementation(s) | Editor | ⭐ Essential |
| ++cmd+u++ | Go to super method/class | Editor | Common |
| ++cmd+shift+t++ | Go to test / Create test | Editor | Common |
| ++cmd+e++ | Recent files | Global | ⭐ Essential |
| ++cmd+shift+e++ | Recent edited files | Global | Common |
| ++cmd+[++ | Navigate back | Global | ⭐ Essential |
| ++cmd+]++ | Navigate forward | Global | ⭐ Essential |
| ++option+f7++ | Find usages | Editor | ⭐ Essential |
| ++cmd+f7++ | Find usages in file | Editor | Common |
| ++cmd+shift+f7++ | Highlight usages in file | Editor | Advanced |

</div>

### TypeScript Refactoring

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context | Priority |
|----------|--------|---------|----------|
| ++shift+f6++ | Rename symbol | Editor | ⭐ Essential |
| ++cmd+option+v++ | Extract variable | Editor | ⭐ Essential |
| ++cmd+option+m++ | Extract method | Editor | ⭐ Essential |
| ++cmd+option+c++ | Extract constant | Editor | Common |
| ++cmd+option+f++ | Extract field | Editor | Common |
| ++cmd+option+n++ | Inline variable/method | Editor | Common |
| ++cmd+option+o++ | Optimize imports | Global | ⭐ Essential |
| ++ctrl+option+o++ | Organize imports | Global | Common |
| ++option+enter++ | Show context actions / Quick fixes | Editor | ⭐ Essential |
| ++cmd+option+l++ | Reformat code | Editor | Common |
| ++cmd+option+shift+l++ | Reformat code dialog | Editor | Advanced |

</div>

### Package Management & npm Scripts

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context | Priority |
|----------|--------|---------|----------|
| ++cmd+shift+a++ then type "npm" | Run npm scripts | Global | ⭐ Essential |
| **Double-click** script in package.json | Run npm script | package.json | ⭐ Essential |
| ++cmd+shift+o++ | Open file dialog | Global | Common |
| ++shift+shift++ | Search everywhere (files, symbols, actions) | Global | ⭐ Essential |

</div>

**Tip**: You can run npm scripts directly from package.json by double-clicking the script name, or use `Cmd+Shift+A` → type "npm" to see all available scripts.

### React/Vue/JSX Editing

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context | Priority |
|----------|--------|---------|----------|
| ++cmd+option+t++ | Surround with (wrap component) | Editor | ⭐ Essential |
| ++cmd+slash++ | Toggle comment | Editor | ⭐ Essential |
| ++cmd+shift+slash++ | Toggle block comment | Editor | Common |
| ++option+enter++ | Show context actions (auto-import) | Editor | ⭐ Essential |
| ++ctrl+space++ | Basic code completion | Editor | Common |
| ++cmd+shift+enter++ | Complete statement (add semicolon, braces) | Editor | Common |
| ++option+cmd+j++ | Surround with live template | Editor | Advanced |

</div>

**React/Vue Tip**: Use `Option+Enter` frequently for auto-importing components and fixing ESLint errors quickly.

### Node.js Debugging

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context | Priority |
|----------|--------|---------|----------|
| ++ctrl+r++ | Run current file/configuration | Global | ⭐ Essential |
| ++ctrl+d++ | Debug current file/configuration | Global | ⭐ Essential |
| ++cmd+f8++ | Toggle breakpoint | Editor | ⭐ Essential |
| ++cmd+shift+f8++ | View breakpoints | Global | Common |
| ++f8++ | Step over | Debugger | ⭐ Essential |
| ++f7++ | Step into | Debugger | ⭐ Essential |
| ++shift+f8++ | Step out | Debugger | ⭐ Essential |
| ++option+f9++ | Run to cursor | Debugger | Common |
| ++cmd+option+r++ | Resume program | Debugger | Common |
| ++f9++ | Resume program (alternative) | Debugger | Common |

</div>

### HTTP Client (API Testing)

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context | Priority |
|----------|--------|---------|----------|
| ++cmd+shift+a++ then "HTTP Client" | Open HTTP request file | Global | ⭐ Essential |
| ++ctrl+enter++ | Execute HTTP request | .http file | ⭐ Essential |
| Create `.http` files in project | Write REST API tests | Project | ⭐ Essential |

</div>

**HTTP Client Tutorial**:
1. Create a file named `api-requests.http` in your project
2. Write requests like:
   ```http
   ### Get users
   GET https://api.example.com/users
   Content-Type: application/json

   ### Create user
   POST https://api.example.com/users
   Content-Type: application/json

   {
     "name": "John Doe",
     "email": "john@example.com"
   }
   ```
3. Press `Ctrl+Enter` on any request to execute
4. View response in separate panel

**Alternative to Postman**: HTTP Client files can be version controlled, shared with team, and include environment variables.

### ESLint & Prettier Integration

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context | Priority |
|----------|--------|---------|----------|
| ++option+enter++ | Fix ESLint errors | Editor | ⭐ Essential |
| ++cmd+option+l++ | Format with Prettier | Editor | ⭐ Essential |
| ++cmd+shift+a++ then "Prettier" | Configure Prettier settings | Global | Common |
| ++option+shift+cmd+p++ | Reformat with Prettier | Editor | Common |

</div>

### Git Integration

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context | Priority |
|----------|--------|---------|----------|
| ++cmd+k++ | Commit dialog | Global | ⭐ Essential |
| ++cmd+shift+k++ | Push commits | Global | ⭐ Essential |
| ++cmd+9++ | Version Control tool window | Global | ⭐ Essential |
| ++option+cmd+z++ | Revert changes | Editor/Project | ⭐ Essential |
| ++cmd+t++ | Update project (pull) | Global | Common |
| ++option+shift+cmd+down++ | Next change | Editor | Common |
| ++option+shift+cmd+up++ | Previous change | Editor | Common |
| ++cmd+d++ | Show diff for current file | Editor | Common |

</div>

### Database Tools (Secondary)

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context | Priority |
|----------|--------|---------|----------|
| ++cmd+shift+a++ then "Database" | Open Database tool window | Global | Common |
| ++ctrl+enter++ | Execute query | SQL editor | ⭐ Essential |
| ++cmd+enter++ | Execute query (alternative) | SQL editor | ⭐ Essential |
| ++f5++ | Refresh table data | Database | Common |
| ++cmd+n++ | New query | Database | Common |

</div>

### Python Support (Secondary)

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context | Priority |
|----------|--------|---------|----------|
| ++cmd+option+l++ | Reformat Python code | Editor | Common |
| ++cmd+shift+a++ then "Python Console" | Open Python REPL | Global | Common |
| ++shift+f10++ | Run Python file | Editor | Common |
| ++shift+f9++ | Debug Python file | Editor | Common |
| ++option+enter++ | Show Python context actions | Editor | Common |

</div>

---

## TypeScript-Focused Learning Path

Progressive 4-week path to master IntelliJ IDEA for full-stack TypeScript development.

### Week 1: Foundation (Vim Mode + Basic Navigation)

**Goal**: Master window navigation and file search fundamentals.

#### 1. Master Vim Window Navigation
Practice these until they become muscle memory:
- ++ctrl+h++ / ++ctrl+j++ / ++ctrl+k++ / ++ctrl+l++ - Navigate between editor panes
- ++space+w+v++ / ++space+w+h++ - Split vertically/horizontally
- ++space+w+w++ - Close current split
- ++ctrl+e++ - Open Project tool window

**Practice drill**: Open 4 files, split into grid (2x2), practice navigating without mouse.

#### 2. Learn File/Symbol Search (Most-Used Shortcuts)
- ++space+s+f++ → Find file (IdeaVim)
- ++space+s+g++ → Search in project (IdeaVim grep)
- ++space+s+s++ → Find symbol (IdeaVim)
- ++cmd+shift+a++ → Find action (native - **learn this first!**)
- ++shift+shift++ → Search everywhere (native - files, symbols, actions, settings)

**Practice drill**: Use only keyboard to open 10 different files by name/symbol.

#### 3. Basic TypeScript Navigation
- ++space+g+d++ or ++cmd+b++ → Go to declaration
- ++cmd+[++ / ++cmd+]++ → Navigate back/forward in history
- ++cmd+e++ → Recent files

**Goal**: By end of Week 1, you should navigate entirely by keyboard without touching the mouse.

---

### Week 2: TypeScript Development Workflow

**Goal**: Master LSP features and refactoring for efficient coding.

#### 1. LSP/IntelliSense Shortcuts
- ++space+g+i++ → Go to implementation (find where interface is implemented)
- ++space+g+y++ → Go to type declaration (jump to type definition)
- ++option+enter++ → Show context actions (auto-import, quick fixes) - **use this constantly!**
- ++ctrl+space++ → Trigger completion manually
- ++option+f7++ → Find usages of symbol

**Practice drill**: Navigate through a React component - jump to prop types, implementations, find all usages.

#### 2. Refactoring Essentials
- ++space+r+n++ or ++shift+f6++ → Rename symbol across project
- ++space+r+m++ or ++cmd+option+m++ → Extract method
- ++space+r+v++ or ++cmd+option+v++ → Extract variable
- ++space+oi++ or ++cmd+option+o++ → Optimize imports (remove unused)
- ++cmd+slash++ → Toggle comment

**Practice drill**: Take a long function (50+ lines) and refactor into smaller functions using keyboard only.

#### 3. Package Management
- ++cmd+shift+a++ → type "npm" → Run npm scripts from command palette
- **Double-click** on script in package.json → Run npm script directly
- ++shift+shift++ → type "package.json" → Open package.json quickly

**Practice drill**: Run `npm run dev`, `npm run build`, `npm run test` using only keyboard shortcuts.

---

### Week 3: Full-Stack TypeScript Mastery

**Goal**: Master React/Vue workflows, Node.js debugging, and API testing.

#### 1. React/Vue Component Workflow
- ++space+c+a++ or ++option+enter++ → Code actions (wrap with component, split JSX)
- ++cmd+option+t++ → Surround with (wrap selected JSX with div, fragment, etc.)
- ++space+g+t++ → Go to test / Create test for component
- ++option+enter++ → Auto-import missing component (**super useful!**)

**Practice drill**: Build a new React component, auto-import all dependencies using `Option+Enter`.

#### 2. Debugging Node.js
- ++ctrl+d++ → Debug current file
- ++cmd+f8++ → Toggle breakpoint on current line
- ++f8++ / ++f7++ / ++shift+f8++ → Step over/into/out
- ++option+f9++ → Run to cursor
- ++cmd+option+r++ → Resume program

**Practice drill**: Debug a Node.js API endpoint, set breakpoints, inspect variables, step through code.

#### 3. API Testing with HTTP Client
**Setup**:
1. Create `api-requests.http` in project root
2. Write HTTP requests:
```http
### Get all users
GET http://localhost:3000/api/users
Content-Type: application/json

### Create new user
POST http://localhost:3000/api/users
Content-Type: application/json

{
  "name": "Test User",
  "email": "test@example.com"
}
```

3. Press ++ctrl+enter++ on any request to execute
4. View response in separate panel with syntax highlighting

**Practice drill**: Replace Postman - write 5 API requests in `.http` file and test your API.

---

### Week 4: Advanced & Productivity

**Goal**: Master Git workflow, AI assistants, and become self-sufficient with discovery tools.

#### 1. Git Workflow
- ++cmd+k++ → Commit dialog (select files, write message)
- ++cmd+9++ → Open Version Control window
- ++option+cmd+z++ → Revert changes in current file
- ++cmd+d++ → Show diff for current file
- ++cmd+shift+k++ → Push commits

**Practice drill**: Make changes, commit, and push using only keyboard.

#### 2. AI Assistants (Tabby)
- ++tab++ → Accept next line of completion
- ++ctrl+right++ → Accept next word only
- ++ctrl+backslash++ → Trigger Tabby completion manually
- ++ctrl+l++ → Open Tabby Chat window

**Practice drill**: Write a TypeScript function and let Tabby suggest implementation, accept with keyboard.

#### 3. Discovery Tools (Most Important!)
- ++cmd+shift+a++ → Find Action - **use this daily!**
  - Search for any action by name
  - Shows keyboard shortcut next to action
  - Learn shortcuts by searching for actions
- ++shift+shift++ → Search everywhere
  - Files, symbols, actions, settings all in one
- Enable "Show shortcuts in Find Action" in settings

**Daily habit**: When you use mouse for an action → Press ++cmd+z++ to undo → Press ++cmd+shift+a++ to find the keyboard shortcut → Repeat action with keyboard.

---

### Continuous Learning Tips

#### Build Muscle Memory
- **Week 1 habit**: No mouse for file navigation
- **Week 2 habit**: No mouse for refactoring
- **Week 3 habit**: No mouse for debugging
- **Week 4 habit**: No mouse for Git operations

#### Track Your Progress
Keep a note (physical or digital) of **3 new shortcuts you learned each week**:
```
Week 1:
- Cmd+Shift+A (Find Action) - game changer!
- Shift+Shift (Search everywhere)
- Option+Enter (Show context actions)

Week 2:
- Cmd+Option+V (Extract variable)
- Shift+F6 (Rename)
- Option+F7 (Find usages)
```

#### Focus on Pain Points
If you do something **>5 times per day**, find its keyboard shortcut:
- Opening files? → ++shift+shift++
- Auto-importing? → ++option+enter++
- Running npm scripts? → ++cmd+shift+a++ → "npm"
- Committing code? → ++cmd+k++

#### Use IntelliJ's Help
- `Help → Keymap Reference` - PDF of all shortcuts
- Enable "Show shortcuts in tooltips" in settings
- Enable "Show shortcuts in Find Action" (++cmd+shift+a++)

---

## Discovery & Reference

### How to Find More Shortcuts

1. **Find Action** (++cmd+shift+a++):
   - Search for any action by name
   - Shows keyboard shortcut next to action
   - Example: Type "format" to find formatting shortcuts

2. **Search Everywhere** (++shift+shift++):
   - Files, classes, symbols, actions, settings
   - One search box for everything
   - Type `/` to filter by category

3. **Keymap Settings**:
   - `Preferences → Keymap`
   - Browse all shortcuts by category
   - Search for conflicts
   - Customize shortcuts

4. **Which-Key** (IdeaVim):
   - After pressing ++space++, wait 100ms
   - Menu appears showing available completions
   - Example: ++space++ → wait → shows `[W]indow`, `[S]earch`, `[G]oto`, etc.

### Official Documentation

- **JetBrains Keymap Reference**: [Download PDF](https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard_macOS.pdf)
- **IdeaVim Documentation**: [GitHub](https://github.com/JetBrains/ideavim)
- **HTTP Client Documentation**: [JetBrains Guide](https://www.jetbrains.com/help/idea/http-client-in-product-code-editor.html)

---

## Configuration References

- **IdeaVim Config**: `ideavim/.ideavimrc`
- **Custom Keymap**: `~/Library/Application Support/JetBrains/IntelliJIdea2025.2/keymaps/macOS copy.xml`
- **Vim Conflicts**: `~/Library/Application Support/JetBrains/IntelliJIdea2025.2/options/vim_settings.xml`
- **Related Docs**: [IdeaVim Basics](./ideavim.md) (Vim mode only)

---

## Related Documentation

- **[IdeaVim](./ideavim.md)** - IdeaVim-specific shortcuts and configuration
- **[Neovim](./neovim.md)** - Neovim keybindings (for comparison and consistency)
- **[Cursor](./cursor.md)** - Cursor IDE keybindings (vim-mode enabled)
- **[Tmux](./ tmux.md)** - Terminal multiplexer shortcuts

---

**Last Updated**: 2025-11-29
**IDE Version**: IntelliJ IDEA Ultimate 2025.2
**Focus**: TypeScript/JavaScript full-stack development
