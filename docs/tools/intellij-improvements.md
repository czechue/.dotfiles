# IntelliJ IDEA Setup: Inconsistencies & Improvement Proposals

> Analysis of IdeaVim configuration vs native IntelliJ conventions for TypeScript development

**Date**: 2025-11-29
**Current Config**: `ideavim/.ideavimrc` + `keymaps/macOS copy.xml`
**Focus**: Optimize for TypeScript full-stack development while respecting IntelliJ conventions

**Related Docs**:
- 🎓 **[Mastery Path](./intellij-mastery-path.md)** - 6-week learning program with milestones
- 📚 **[Complete Keybindings](./intellij-keybindings.md)** - Full reference
- ⚡ **[Quick Reference](./intellij-quick-ref.md)** - Top 30 shortcuts
- ✅ **[Implementation Summary](./intellij-improvements-summary.md)** - What was done

---

## 🔍 Inconsistencies Found

### 1. **Navigation Shortcuts - Speed vs Consistency Trade-off**

#### Current Setup (IdeaVim)
```vim
map <leader>gd <Action>(GotoDeclaration)
map <leader>gy <Action>(GotoTypeDeclaration)
map <leader>gi <Action>(GotoImplementation)
map <leader>gt <Action>(GotoTest)
```

#### IntelliJ Native (macOS)
- `Cmd+B` → Go to Declaration (**most frequently used**)
- `Cmd+Shift+B` → Go to Type Declaration
- `Cmd+Option+B` → Go to Implementation
- `Cmd+Shift+T` → Go to Test

#### Issue
- **Speed**: `Cmd+B` is instant (1 chord), `Space+G+D` requires 3 keypresses
- **Industry Standard**: `Cmd+B` is used across all JetBrains IDEs
- **Team Collaboration**: Others on your team expect standard shortcuts
- **Discoverability**: Native shortcuts appear in menus and tooltips

#### Impact
⚠️ **High** - Navigation is the most frequent action in development. The speed difference compounds over a workday.

---

### 2. **Missing Critical TypeScript Shortcuts**

#### Not Currently Mapped

| Shortcut | Action | Importance | Use Case |
|----------|--------|------------|----------|
| `Option+Enter` | **Show Intention Actions** | ⭐⭐⭐⭐⭐ | Auto-import, quick fixes, ESLint fixes |
| `Cmd+P` | Parameter Info | ⭐⭐⭐⭐ | See method signatures while typing |
| `F1` | Quick Documentation | ⭐⭐⭐⭐ | Inline docs for symbols |
| `Ctrl+T` | **Refactor This** | ⭐⭐⭐⭐⭐ | Context-aware refactoring menu |
| `F2` / `Shift+F2` | Next/Previous Error | ⭐⭐⭐⭐ | Jump between errors (faster than `<leader>en/ep`) |
| `Cmd+F12` | File Structure | ⭐⭐⭐ | Quick symbol overview popup |
| `Cmd+Shift+Enter` | Complete Statement | ⭐⭐⭐ | Smart line completion with semicolons |
| `Ctrl+Shift+Space` | Type-Matching Completion | ⭐⭐⭐⭐ | Smart TypeScript type inference |
| `Double Shift` | **Search Everywhere** | ⭐⭐⭐⭐⭐ | Universal search (files + symbols + actions) |

**Critical Missing**: `Option+Enter` (Show Intention Actions) is THE most important shortcut for TypeScript development - it handles auto-imports, quick fixes, and ESLint errors.

---

### 3. **Code Formatting - Non-Standard Mapping**

#### Current Setup
```vim
map <leader>f <Action>(ReformatCode)
map <leader>oi <Action>(OptimizeImports)
```

#### IntelliJ Native
- `Cmd+Option+L` → Reformat Code (**industry standard**)
- `Ctrl+Option+O` → Optimize Imports

#### Issue
- `Cmd+Option+L` is the universal formatting shortcut across **all JetBrains IDEs** (IntelliJ, WebStorm, PyCharm, etc.)
- Deeply ingrained in developers' muscle memory
- Your mapping requires 3 keypresses vs 1 chord

#### Impact
⚠️ **Medium** - Formatting is frequent but not as critical as navigation. However, using non-standard shortcuts hurts collaboration.

---

### 4. **Refactoring - Missing "Refactor This" Menu**

#### Current Setup
```vim
map <leader>rm <Action>(ExtractMethod)
map <leader>rv <Action>(IntroduceVariable)
map <leader>rf <Action>(IntroduceField)
map <leader>rn <Action>(RenameElement)
```

#### IntelliJ Native
- `Ctrl+T` → **Refactor This** (context-aware menu with ALL refactorings)
- `Shift+F6` → Rename (most common refactoring)
- `Cmd+Option+M` → Extract Method
- `Cmd+Option+V` → Introduce Variable

#### Issue
**Missing the most powerful refactoring feature**: `Ctrl+T` shows a context-aware popup with ALL available refactorings for the current context. This eliminates the need to memorize individual refactoring shortcuts.

**Example workflow:**
1. Select code
2. Press `Ctrl+T`
3. See menu: "Extract Method, Extract Variable, Inline, Change Signature, Move..."
4. Choose from menu or press number key

#### Impact
⚠️ **High** - You're memorizing individual refactorings when one shortcut gives you access to all of them.

---

### 5. **Generate Menu Conflict**

#### Current Setup
```vim
map <S-space> <Action>(Generate)  " ✅ Good!
map <leader>nf <Action>(NewFile)  " ⚠️ Conflicts with native Cmd+N
```

#### IntelliJ Native
- `Cmd+N` → Generate (constructors, getters, setters, toString, etc.)
- This is critical for TypeScript class development

#### Issue
- Your `<leader>nf` for NewFile is fine
- But native `Cmd+N` typically triggers Generate menu in editor context
- Consider whether you need both or if there's a conflict

#### Impact
⚠️ **Low** - `Shift+Space` covers Generate, but document that `Cmd+N` might have different context-dependent behavior.

---

### 6. **Ctrl+L Conflict - Window Navigation vs Tabby**

#### Current Setup (Custom Keymap)
```xml
<action id="Tabby.Chat.ToggleChatToolWindow">
  <keyboard-shortcut first-keystroke="ctrl l" />
</action>
```

#### IdeaVim Mapping
```vim
map <C-l> <C-w>l  " Move to right window
```

#### Issue
**Conflict**: `Ctrl+L` mapped to both:
1. Window navigation (Vim mode) - Move to right pane
2. Tabby Chat toggle (IDE mode)

This works because:
- In **Vim mode** (editor): `Ctrl+L` moves windows
- In **non-Vim contexts** (project tree, etc.): `Ctrl+L` opens Tabby

However, it's confusing and non-discoverable.

#### Impact
⚠️ **Low** - Works due to context separation, but consider using a different key for Tabby (e.g., `Cmd+Option+L` or `Ctrl+;`).

---

### 7. **Double Shift (Search Everywhere) Not Documented**

#### Missing from Your Config
`Double Shift` → Search Everywhere

#### What It Does
Universal search that combines:
- Go to File
- Go to Symbol
- Go to Action
- Search Settings
- Search Recent Files

You can filter by typing `/` for actions, `@` for symbols, etc.

#### Issue
This is **IntelliJ's killer feature** for discovery, but it's not mentioned in your config or documentation.

#### Impact
⚠️ **High** - You have separate `<leader>sf`, `<leader>sg`, `<leader>ss` mappings, but `Double Shift` is faster and more powerful.

---

## ✅ What You're Doing Right

### Excellent Decisions in Your Config

1. **Window Navigation** (`Ctrl+H/J/K/L`) ✅
   - Perfect Vim-style pane navigation
   - Doesn't conflict with critical IDE shortcuts
   - Muscle memory from Neovim

2. **Window Management** (`<leader>w*`) ✅
   - Clean namespace organization
   - Consistent with Neovim Telescope
   - Split/unsplit mappings are logical

3. **Search Namespace** (`<leader>s*`) ✅
   - Excellent discoverability
   - Matches Telescope patterns from Neovim
   - `<leader>sa` for actions is great

4. **Error Navigation** (`<leader>en/ep`) ✅
   - Consistent namespace
   - Though `F2`/`Shift+F2` are faster native alternatives

5. **Which-Key Integration** ✅
   - Fantastic for discoverability
   - Shows available completions after `Space`
   - Helps learn shortcuts

6. **Ctrl+E Override** ✅
   - Good choice to map `Ctrl+E` to Project window
   - More useful than scroll down in IDE context

7. **Multiple Cursors** ✅
   - vim-multiple-cursors plugin with Mac-friendly shortcuts
   - Avoids dead keys (`Alt+N` → ñ issue)
   - `<leader><C-g>` for select all is discoverable

---

## 💡 Improvement Proposals

### Recommendation: **Hybrid Approach**

Keep your Vim-style consistency while preserving IntelliJ's power features. Use **both** native and leader-key mappings where appropriate.

---

### Proposal 1: **Add Missing Critical Shortcuts** (PRIORITY: HIGH)

Add these essential shortcuts that are currently missing:

```vim
" ===================================================================
" CRITICAL ADDITIONS - TypeScript Development
" ===================================================================

" Show intention actions and quick fixes (THE most important for TS!)
" Already have: map <leader>ca <Action>(ShowIntentionActions)
" Native Option+Enter also works - preserve it!

" Parameter info while typing (critical for TypeScript)
map <leader>K <Action>(QuickJavaDoc)        " Quick documentation (like Vim K)
map <leader>p <Action>(ParameterInfo)       " Parameter hints

" Refactor This - context-aware refactoring menu (most powerful)
map <leader>rt <Action>(Refactorin gMenu)

" File structure popup (quick symbol navigation within file)
map <leader>so <Action>(FileStructurePopup)  " Symbol outline

" Complete current statement (add semicolons, braces)
imap <C-CR> <Action>(CompleteStatement)

" Type-matching completion (smart TypeScript types)
" Native Ctrl+Shift+Space works, but add alias:
imap <C-Space><C-Space> <Action>(SmartTypeCompletion)
```

**Rationale**: These shortcuts fill critical gaps in TypeScript workflows without disrupting your existing mappings.

---

### Proposal 2: **Dual Mappings for Navigation** (PRIORITY: MEDIUM)

Support **both** native IntelliJ shortcuts AND your leader-key mappings for flexibility:

```vim
" ===================================================================
" DUAL NAVIGATION - Best of Both Worlds
" ===================================================================

" Your leader-key mappings (keep for consistency)
map <leader>gd <Action>(GotoDeclaration)
map <leader>gy <Action>(GotoTypeDeclaration)
map <leader>gi <Action>(GotoImplementation)
map <leader>gt <Action>(GotoTest)
map <leader>gr <Action>(ShowUsages)          " NEW: Find usages

" ALSO add Vim-style alternatives (faster than leader-key)
nmap gd <Action>(GotoDeclaration)            " Vim-style 'go to definition'
nmap gD <Action>(GotoTypeDeclaration)        " Vim-style 'go to type'
nmap gi <Action>(GotoImplementation)         " Already Vim standard
nmap gr <Action>(ShowUsages)                 " Vim-style 'go to references'
nmap gh <Action>(QuickJavaDoc)               " Hover documentation

" PRESERVE native shortcuts (don't override these!)
" Cmd+B, Cmd+Shift+B, Cmd+Option+B, Cmd+Shift+T work automatically
```

**Rationale**:
- Vim-style `gd`, `gr`, `gi` are faster than leader sequences (2 keys vs 3)
- Matches Neovim LSP conventions (`gd` is standard for go-to-definition)
- Native `Cmd+B` still works for maximum speed
- Choose based on context: leader-key for consistency, `g*` for speed, `Cmd+B` for fastest

---

### Proposal 3: **Document Native Shortcuts to Preserve** (PRIORITY: HIGH)

Add a section to your `.ideavimrc` documenting critical native shortcuts to preserve:

```vim
" ===================================================================
" IMPORTANT: Preserve These Native IntelliJ Shortcuts
" ===================================================================
" These shortcuts are NOT remapped - use them directly!
"
" Navigation & Search:
"   Cmd+B           - Go to Declaration (FASTEST - use this!)
"   Cmd+Shift+B     - Go to Type Declaration
"   Cmd+Option+B    - Go to Implementation
"   Option+F7       - Find Usages
"   Cmd+[, Cmd+]    - Navigate Back/Forward
"   Double Shift    - Search Everywhere (universal search!)
"   Cmd+E           - Recent Files
"   Cmd+Shift+E     - Recent Edited Files
"
" Quick Fixes & Refactoring:
"   Option+Enter    - Show Intention Actions (auto-import, quick fixes)
"   Ctrl+T          - Refactor This (context-aware refactoring menu)
"   Shift+F6        - Rename Element
"   Cmd+Option+L    - Reformat Code (industry standard)
"   Ctrl+Option+O   - Optimize Imports
"
" Code Intelligence:
"   Cmd+P           - Parameter Info
"   F1              - Quick Documentation
"   Cmd+F12         - File Structure Popup
"   Ctrl+Shift+Space - Smart Type Completion
"
" Errors & Debugging:
"   F2, Shift+F2    - Next/Previous Error (faster than <leader>en/ep)
"   Cmd+F8          - Toggle Breakpoint
"   Ctrl+D          - Debug
"   Ctrl+R          - Run
"
" Discovery:
"   Cmd+Shift+A     - Find Action (command palette)
"   Cmd+Shift+P     - Command Palette (alternative)
"
" ===================================================================
```

**Rationale**: Documenting preserved shortcuts helps you remember to use them and aids team collaboration.

---

### Proposal 4: **Resolve Ctrl+L Conflict** (PRIORITY: LOW)

**Option A**: Keep current setup (works due to context separation)
```vim
" Current: Ctrl+L for window navigation (Vim mode)
" Current: Ctrl+L for Tabby Chat (non-editor contexts)
" Status: Works but confusing
```

**Option B**: Remap Tabby Chat to different key (recommended)
```xml
<!-- In keymaps/macOS copy.xml, change from ctrl l to: -->
<action id="Tabby.Chat.ToggleChatToolWindow">
  <keyboard-shortcut first-keystroke="ctrl semicolon" />
  <!-- or -->
  <keyboard-shortcut first-keystroke="meta alt l" />
</action>
```

**Rationale**: `Ctrl+;` or `Cmd+Option+L` would be less confusing and more discoverable.

---

### Proposal 5: **Add TypeScript-Specific Actions** (PRIORITY: MEDIUM)

Add shortcuts for TypeScript-specific refactorings and actions:

```vim
" ===================================================================
" TYPESCRIPT-SPECIFIC ACTIONS
" ===================================================================

" Generate (constructors, getters, etc.)
" Already have: map <S-space> <Action>(Generate)
" Add alias:
map <leader>ge <Action>(Generate)

" Implement/Override Methods
map <leader>im <Action>(ImplementMethods)
map <leader>om <Action>(OverrideMethods)

" Introduce Parameter (common in TypeScript refactoring)
map <leader>rp <Action>(IntroduceParameter)

" Inline variable/method (reverse of extract)
map <leader>ri <Action>(Inline)

" Change signature (useful for refactoring function signatures)
map <leader>rs <Action>(ChangeSignature)

" Move refactoring (move functions between files)
map <leader>mov <Action>(Move)

" Safe delete (checks usages before deleting)
map <leader>del <Action>(SafeDelete)
```

**Rationale**: These are common TypeScript refactorings that complement your existing mappings.

---

### Proposal 6: **Add HTTP Client Shortcuts** (PRIORITY: LOW)

Since you're using the HTTP Client for API testing:

```vim
" ===================================================================
" HTTP CLIENT (API Testing)
" ===================================================================

" Execute HTTP request (in .http files)
" Native Ctrl+Enter works, but add for discoverability:
" map <leader>hr <Action>(Execution.Http)

" Note: Ctrl+Enter is standard and works well in .http files
```

**Rationale**: `Ctrl+Enter` is already standard and works well. No change needed unless you want a discoverable alias.

---

### Proposal 7: **Error Navigation Enhancement** (PRIORITY: LOW)

Keep your existing error navigation but add native shortcuts as aliases:

```vim
" Errors navigation (keep current)
map <leader>en <Action>(GotoNextError)
map <leader>ep <Action>(GotoPreviousError)

" ALSO support native F2/Shift+F2 for speed
" (These work automatically, just document them)

" Show error description (already have <leader>sd)
map <leader>ed <Action>(ShowErrorDescription)
```

**Rationale**: `F2`/`Shift+F2` are faster (1 key vs 3), but your mappings are more discoverable via Which-Key.

---

## 📋 Recommended Implementation Plan

### Phase 1: Critical Additions (Do This First)

1. **Add missing critical shortcuts** (Proposal 1)
   - Parameter Info (`<leader>p`)
   - Quick Documentation (`<leader>K`)
   - Refactor This (`<leader>rt`)
   - File Structure (`<leader>so`)
   - Complete Statement (`Ctrl+Enter` in insert mode)

2. **Document native shortcuts to preserve** (Proposal 3)
   - Add comment section at top of `.ideavimrc`
   - List critical shortcuts to NOT override

### Phase 2: Navigation Improvements (Optional but Recommended)

3. **Add Vim-style navigation aliases** (Proposal 2)
   - `gd` → GotoDeclaration (faster than `<leader>gd`)
   - `gr` → ShowUsages
   - `gi` → GotoImplementation
   - `gh` → QuickJavaDoc

### Phase 3: TypeScript-Specific (Nice to Have)

4. **Add TypeScript refactorings** (Proposal 5)
   - Introduce Parameter
   - Inline variable
   - Change signature
   - Safe delete

5. **Resolve Ctrl+L conflict** (Proposal 4)
   - Consider remapping Tabby Chat to `Ctrl+;`

---

## 🎯 Final Recommendation: **Balanced Hybrid Approach**

**Strategy**: Keep your Neovim-consistent leader-key mappings for discoverability, but ADD:
1. Vim-style `g*` shortcuts for speed (2 keypresses)
2. Documentation of native shortcuts to preserve
3. Missing critical shortcuts for TypeScript

**Workflow**:
- **For consistency**: Use `<leader>*` mappings
- **For speed**: Use `g*` mappings (Vim-style)
- **For maximum speed**: Use native `Cmd+*` shortcuts
- **For discovery**: Use `Cmd+Shift+A` (Find Action)

This gives you **three layers of shortcuts**:
1. **Fast**: Native `Cmd+B` (1 chord)
2. **Medium**: Vim-style `gd` (2 keys)
3. **Discoverable**: `<leader>gd` (3 keys, appears in Which-Key menu)

Use the appropriate layer based on your current flow state and familiarity.

---

## 📝 Summary of Changes

### ✅ Keep As-Is
- Window navigation (`Ctrl+H/J/K/L`)
- Window management (`<leader>w*`)
- Search namespace (`<leader>s*`)
- All existing mappings

### ➕ Add New
- Parameter Info (`<leader>p`)
- Quick Documentation (`<leader>K`)
- Refactor This (`<leader>rt`)
- File Structure (`<leader>so`)
- Vim-style navigation (`gd`, `gr`, `gi`, `gh`)
- Documentation of native shortcuts

### 📖 Document
- Native shortcuts to preserve
- Three-layer shortcut strategy
- When to use which layer

### 🔧 Optional Changes
- Resolve `Ctrl+L` conflict (Tabby → `Ctrl+;`)
- Add TypeScript-specific refactorings

---

**Next Steps**: Review these proposals and decide which changes align with your workflow. I can help implement any approved changes to your `.ideavimrc` file.
