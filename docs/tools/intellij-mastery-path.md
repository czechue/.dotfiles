# IntelliJ IDEA Mastery Path

> Progressive milestone system to achieve fluency in IdeaVim + IntelliJ for TypeScript development

**Goal**: Transform from mouse-dependent to keyboard-first IntelliJ master in 6 weeks

**Related Docs**: [Complete Keybindings](./intellij-keybindings.md) | [Quick Reference](./intellij-quick-ref.md) | [Improvements Analysis](./intellij-improvements.md)

---

## 🎯 Overview: Path to Mastery

This learning path uses a **milestone-based system** with clear, measurable goals. Each milestone builds on the previous one, gradually increasing your speed and efficiency.

### **Mastery Levels**

1. **🌱 Novice** (Week 1) - Foundation & Discovery
2. **📚 Learner** (Week 2) - TypeScript Essentials
3. **⚡ Proficient** (Week 3) - Full-Stack Workflows
4. **🚀 Advanced** (Week 4) - Speed & Optimization
5. **💎 Expert** (Week 5) - Refactoring Mastery
6. **🏆 Master** (Week 6) - Flow State & Teaching

### **Progression System**

Each milestone has:
- **Learning Goals** - What to learn
- **Practice Exercises** - Concrete tasks to complete
- **Success Criteria** - How to know you've mastered it
- **Daily Challenges** - Practical application
- **Self-Assessment** - Check your progress

---

## 🌱 Milestone 1: Novice (Week 1)

**Goal**: Master basic navigation and discovery tools. Eliminate mouse for file operations.

### **Learning Goals**

#### 1.1 Discovery Tools (Day 1-2)
- [ ] Master `Cmd+Shift+A` (Find Action) - THE most important shortcut
- [ ] Master `Shift+Shift` (Search Everywhere) - Universal search
- [ ] Understand difference between Find Action vs Search Everywhere
- [ ] Learn to read Which-Key menu (press `Space` → wait 100ms)

**Practice Exercise**:
```
Task: Find and execute 5 different actions using Cmd+Shift+A
1. "Reformat Code" → execute
2. "Optimize Imports" → execute
3. "Generate" → execute
4. "Rename" → execute
5. "Extract Method" → execute

Success: You can find any action in <5 seconds without mouse
```

#### 1.2 Window Navigation (Day 2-3)
- [ ] `Ctrl+H/J/K/L` - Move between editor panes (Vim-style)
- [ ] `Ctrl+E` - Toggle Project window
- [ ] `Cmd+1` - Open Project window
- [ ] `Cmd+2` - Open Terminal window
- [ ] `Space+W+V` - Split vertically
- [ ] `Space+W+H` - Split horizontally
- [ ] `Space+W+W` - Close split

**Practice Exercise**:
```
Task: Window Management Drill
1. Open 4 files in your project
2. Split into 2x2 grid using Space+W+V and Space+W+H
3. Navigate all 4 panes using only Ctrl+H/J/K/L (no mouse!)
4. Close all splits using Space+W+A
5. Repeat until muscle memory is built

Success: Navigate 4-pane setup in <10 seconds without looking at keyboard
```

#### 1.3 File Search (Day 3-4)
- [ ] `Space+S+F` - Find file (leader-key, discoverable)
- [ ] `Shift+Shift` - Search everywhere (faster alternative)
- [ ] `Space+S+R` - Recent files
- [ ] `Cmd+E` - Recent files (native, faster)
- [ ] `Space+S+S` - Find symbol

**Practice Exercise**:
```
Task: File Navigation Speed Test
Open these files using ONLY keyboard (time yourself):
1. package.json
2. tsconfig.json
3. src/index.ts (or main entry file)
4. README.md
5. Any component file in src/

Target: <3 seconds per file using Shift+Shift
```

#### 1.4 Basic Text Editing (Day 4-5)
- [ ] `Cmd+/` - Toggle line comment
- [ ] `Cmd+D` - Duplicate line
- [ ] `Cmd+Backspace` - Delete line
- [ ] `Shift+J/K` (visual mode) - Move lines up/down
- [ ] `Cmd+C/V/X` - Copy/Paste/Cut (standard)

**Practice Exercise**:
```
Task: Code Rearrangement
1. Open any TypeScript file
2. Select 3 lines with Shift+Down/Up
3. Move them down 5 lines using Shift+J
4. Duplicate the block with Cmd+D
5. Comment out original with Cmd+/

Success: Complete in <30 seconds
```

### **Week 1 Daily Challenges**

**Monday**: Use `Cmd+Shift+A` for EVERYTHING. Don't click any menu item.
**Tuesday**: Navigate between files only with `Shift+Shift`. No Project tree clicking.
**Wednesday**: Split screen day - work with 2+ panes open all day.
**Thursday**: Comment/uncomment challenge - use `Cmd+/` 50 times.
**Friday**: Speed test - open 10 random files in <30 seconds using keyboard.

### **Week 1 Success Criteria**

- [ ] Can find any IntelliJ action in <5 seconds using `Cmd+Shift+A`
- [ ] Navigate 4-pane editor without touching mouse
- [ ] Open any file in project in <3 seconds using `Shift+Shift`
- [ ] Haven't clicked Project tree to open files for 2 full days
- [ ] Can use Which-Key menu (`Space` → wait) to discover shortcuts

**Self-Assessment**: If you touched the mouse <10 times for file/window operations today, you passed! 🎉

---

## 📚 Milestone 2: Learner (Week 2)

**Goal**: Master TypeScript-specific navigation and the three-layer shortcut system.

### **Learning Goals**

#### 2.1 Three-Layer Navigation System (Day 1-2)
- [ ] **Fast Layer** (1 key): `Cmd+B` - Go to declaration
- [ ] **Medium Layer** (2 keys): `gd` - Go to declaration (Vim-style)
- [ ] **Discoverable Layer** (3 keys): `Space+G+D` - Go to declaration
- [ ] Understand when to use each layer
- [ ] Practice transitioning between layers

**Practice Exercise**:
```
Task: Navigation Layer Comparison
Open a TypeScript file with imports.

For each imported symbol:
1. Use Space+G+D (discoverable) - count keystrokes & time
2. Use gd (Vim-style) - count keystrokes & time
3. Use Cmd+B (native) - count keystrokes & time

Record your times. Notice the speed difference!

Target: Cmd+B becomes your default within 3 days
```

#### 2.2 Go-To Operations (Day 2-3)
- [ ] `gd` or `Cmd+B` - Go to declaration
- [ ] `gr` or `Option+F7` - Find usages (where is this used?)
- [ ] `gi` or `Cmd+Option+B` - Go to implementation
- [ ] `Space+G+T` or `Cmd+Shift+T` - Go to test
- [ ] `Cmd+[` / `Cmd+]` - Navigate back/forward

**Practice Exercise**:
```
Task: Declaration Chase
1. Open your main TypeScript file
2. Pick any imported function
3. Jump to its declaration (gd or Cmd+B)
4. Find all usages (gr or Option+F7)
5. Jump to one usage
6. Navigate back (Cmd+[)
7. Jump to test (Space+G+T)

Repeat 10 times until it feels natural.

Success: Complete the cycle in <15 seconds
```

#### 2.3 Quick Fixes & Auto-Import (Day 3-4)
- [ ] `Option+Enter` - THE most important shortcut ⭐⭐⭐⭐⭐
- [ ] Understand when red squiggles appear
- [ ] Auto-import missing symbols
- [ ] Apply ESLint quick fixes
- [ ] Generate missing code

**Practice Exercise**:
```
Task: Auto-Import Challenge
1. Create new TypeScript file
2. Write code using 10 imports WITHOUT importing them:
   - import React from 'react'
   - import useState from 'react'
   - import axios from 'axios'
   etc.
3. Use ONLY Option+Enter to auto-import everything
4. Fix any ESLint errors using Option+Enter

Target: Import 10 symbols in <60 seconds using Option+Enter
```

#### 2.4 Documentation & Type Info (Day 4-5)
- [ ] `gh` or `Space+K` or `F1` - Quick documentation
- [ ] `Space+P` or `Cmd+P` - Parameter info
- [ ] `Space+S+O` or `Cmd+F12` - File structure popup
- [ ] `Space+T+I` - Type info at cursor

**Practice Exercise**:
```
Task: Documentation Exploration
1. Open any TypeScript file with function calls
2. For each function:
   - Use gh to see documentation
   - Use Space+P to see parameters
   - Use Space+TI to see return type
3. Open file structure with Space+SO
4. Navigate between methods using arrows

Success: Can inspect any symbol without leaving keyboard
```

### **Week 2 Daily Challenges**

**Monday**: Use `Option+Enter` 100 times. Auto-import everything.
**Tuesday**: Navigation day - use `gd` to jump to 50 declarations.
**Wednesday**: Reference day - use `gr` to find usages of 20 symbols.
**Thursday**: Documentation day - use `gh` on every function you call.
**Friday**: Three-layer challenge - use all three layers (Fast/Medium/Discoverable) throughout the day.

### **Week 2 Success Criteria**

- [ ] `Option+Enter` is your first instinct for red squiggles
- [ ] Can jump to any declaration in <2 seconds using `gd` or `Cmd+B`
- [ ] Understand when to use Fast/Medium/Discoverable layers
- [ ] Haven't manually typed an import statement for 2 days
- [ ] Can find all usages of any symbol in <5 seconds

**Self-Assessment**: If you used `Option+Enter` >50 times today without thinking, you passed! 🎉

---

## ⚡ Milestone 3: Proficient (Week 3)

**Goal**: Master refactoring, full-stack TypeScript workflows, and debugging.

### **Learning Goals**

#### 3.1 The Refactoring Menu (Day 1-2)
- [ ] `Ctrl+T` or `Space+RT` - **Refactor This** menu ⭐⭐⭐⭐⭐
- [ ] Understand context-aware refactorings
- [ ] Navigate menu with arrow keys or numbers
- [ ] Learn to trust the refactoring menu instead of memorizing individual shortcuts

**Practice Exercise**:
```
Task: Refactor This Exploration
1. Select a variable → press Ctrl+T → see options
2. Select a method → press Ctrl+T → see different options
3. Select a class → press Ctrl+T → see yet different options

Try every refactoring option at least once:
- Extract Method
- Extract Variable
- Inline
- Rename
- Move
- Change Signature

Success: You stop trying to memorize individual refactoring shortcuts
```

#### 3.2 Common Refactorings (Day 2-3)
- [ ] `Shift+F6` or `Space+R+N` - Rename
- [ ] `Cmd+Option+V` or `Space+R+V` - Extract variable
- [ ] `Cmd+Option+M` or `Space+R+M` - Extract method
- [ ] `Space+R+I` - Inline variable/method
- [ ] `Space+R+P` - Introduce parameter
- [ ] `Space+R+S` - Change signature

**Practice Exercise**:
```
Task: Refactoring Kata
Start with this messy code:
```typescript
function processUser(data: any) {
  const result = data.name + " " + data.lastName;
  console.log(result);
  const age = 2024 - data.birthYear;
  console.log(age);
  return result + " is " + age;
}
```

Refactor it using ONLY keyboard:
1. Rename `data` to `user` (Shift+F6)
2. Extract `result` calculation to `getFullName` method (Cmd+Option+M)
3. Extract `age` calculation to `calculateAge` method (Cmd+Option+M)
4. Extract magic number 2024 to constant (Cmd+Option+V)
5. Add type annotation using Option+Enter

Target: Complete refactoring in <3 minutes
```

#### 3.3 Node.js Debugging (Day 3-4)
- [ ] `Ctrl+D` - Debug current file
- [ ] `Cmd+F8` - Toggle breakpoint
- [ ] `F8` - Step over
- [ ] `F7` - Step into
- [ ] `Shift+F8` - Step out
- [ ] `Option+F9` - Run to cursor
- [ ] `Cmd+Option+R` - Resume program

**Practice Exercise**:
```
Task: Debugging Workflow
1. Open any API endpoint or function
2. Set breakpoint on first line (Cmd+F8)
3. Debug it (Ctrl+D)
4. Step through with F8
5. Step into a function call with F7
6. Inspect variables
7. Step out with Shift+F8
8. Set another breakpoint
9. Resume with Cmd+Option+R

Repeat 5 times until it's natural.

Success: Debug entire request/response cycle without mouse
```

#### 3.4 React/Vue Component Workflows (Day 4-5)
- [ ] `Option+Enter` - Auto-import components
- [ ] `Space+C+A` or `Option+Enter` - Code actions (wrap JSX, split props)
- [ ] `Space+GE` or `Shift+Space` - Generate menu
- [ ] `Space+IM` - Implement methods (interfaces)
- [ ] `Space+OM` - Override methods

**Practice Exercise**:
```
Task: Component Creation Challenge
Create a new React component from scratch using ONLY keyboard:
1. Create new file (Space+N+F) → name it Button.tsx
2. Type component without imports
3. Auto-import React (Option+Enter)
4. Generate interface for props (Shift+Space → Interface)
5. Implement component
6. Add JSX
7. Wrap JSX with fragment (Option+Enter)
8. Format code (Cmd+Option+L)
9. Optimize imports (Space+OI)

Target: Create working component in <2 minutes
```

#### 3.5 HTTP Client for API Testing (Day 5)
- [ ] Create `.http` files
- [ ] `Ctrl+Enter` - Execute HTTP request
- [ ] Understand environment variables
- [ ] Use response data in subsequent requests

**Practice Exercise**:
```
Task: API Testing Setup
1. Create `api-tests.http` file
2. Write 5 API requests:
   - GET /users
   - POST /users
   - GET /users/:id
   - PUT /users/:id
   - DELETE /users/:id
3. Execute each with Ctrl+Enter
4. Save response to variable
5. Use variable in next request

Success: Replace Postman for one full day with .http files
```

### **Week 3 Daily Challenges**

**Monday**: Refactoring day - use `Ctrl+T` on 30 different selections.
**Tuesday**: Rename day - rename 20 variables/functions using `Shift+F6`.
**Wednesday**: Debugging day - debug 5 functions with breakpoints.
**Thursday**: Component day - create 3 React/Vue components using only keyboard.
**Friday**: API testing day - test all your API endpoints using .http files.

### **Week 3 Success Criteria**

- [ ] `Ctrl+T` is your first thought when refactoring anything
- [ ] Can rename across entire project in <5 seconds
- [ ] Debug full request/response cycle without touching mouse
- [ ] Created 3+ components without typing a single import manually
- [ ] Replaced Postman with HTTP Client for one full day

**Self-Assessment**: If you refactored code 5+ times today using `Ctrl+T`, you passed! 🎉

---

## 🚀 Milestone 4: Advanced (Week 4)

**Goal**: Optimize for speed. Graduate from Discoverable to Medium/Fast layers. Build muscle memory.

### **Learning Goals**

#### 4.1 Speed Optimization (Day 1-2)
- [ ] Replace `Space+G+D` with `gd` (3 keys → 2 keys)
- [ ] Replace `Space+S+F` with `Shift+Shift` (3 keys → 2 keys)
- [ ] Replace `Space+K` with `gh` (3 keys → 2 keys)
- [ ] Use native shortcuts for most common actions
- [ ] Measure your speed improvement

**Practice Exercise**:
```
Task: Speed Optimization Challenge
Time yourself doing these actions with different layers:

Action: Go to declaration 10 times
- Space+G+D: ___ seconds
- gd: ___ seconds
- Cmd+B: ___ seconds

Action: Find 10 files
- Space+S+F: ___ seconds
- Shift+Shift: ___ seconds

Action: See documentation 10 times
- Space+K: ___ seconds
- gh: ___ seconds
- F1: ___ seconds

Goal: Notice 2-3x speed improvement!
```

#### 4.2 Git Workflows (Day 2-3)
- [ ] `Cmd+K` - Commit dialog
- [ ] `Cmd+9` - Version Control window
- [ ] `Option+Cmd+Z` - Revert changes
- [ ] `Cmd+D` - Show diff
- [ ] `Cmd+Shift+K` - Push
- [ ] `Cmd+T` - Pull (update project)

**Practice Exercise**:
```
Task: Git Workflow
Make a code change and commit using ONLY keyboard:
1. Modify a file
2. Show diff (Cmd+D)
3. Open commit dialog (Cmd+K)
4. Select files with Space
5. Write commit message
6. Commit with Cmd+Enter
7. Push with Cmd+Shift+K

Repeat 10 times until smooth.

Target: Commit cycle in <30 seconds
```

#### 4.3 Multiple Cursors & Selection (Day 3-4)
- [ ] `Ctrl+G` - Select next occurrence
- [ ] `Space+Ctrl+G` - Select all occurrences
- [ ] `Ctrl+X` - Skip occurrence
- [ ] `Option+Shift+Click` - Add cursor (mouse fallback)

**Practice Exercise**:
```
Task: Batch Editing Challenge
You have 20 similar lines that need the same change:
```typescript
const user1 = getUser(1);
const user2 = getUser(2);
// ... 18 more lines
```

Change all to: `const user1 = await getUser(1);`

1. Place cursor on "const"
2. Space+Ctrl+G to select all occurrences
3. Type "const " to replace
4. Cmd+Right to move to end
5. Type "await " before getUser

Target: Modify 20 lines in <10 seconds
```

#### 4.4 Advanced Search (Day 4-5)
- [ ] `Cmd+F` - Find in file
- [ ] `Cmd+R` - Replace in file
- [ ] `Cmd+Shift+F` - Find in project
- [ ] `Cmd+Shift+R` - Replace in project
- [ ] Regex search patterns
- [ ] Scope filters (Project, Module, Directory)

**Practice Exercise**:
```
Task: Project-Wide Refactoring
Search and replace across entire project:
1. Press Cmd+Shift+F
2. Search for "console.log"
3. Filter to *.ts files only
4. Review matches
5. Switch to Replace (Cmd+Shift+R)
6. Replace with "logger.debug"
7. Preview changes
8. Execute replace

Success: Batch-replace 50+ occurrences safely
```

### **Week 4 Daily Challenges**

**Monday**: Speed day - use Vim-style (`gd`, `gr`, `gi`) exclusively. No leader-key.
**Tuesday**: Git day - 20 commits using only keyboard.
**Wednesday**: Multiple cursors day - use `Ctrl+G` for every batch edit.
**Thursday**: Search day - use `Cmd+Shift+F` to find 10 things across project.
**Friday**: Time trial - compare your Week 1 speed test results with today!

### **Week 4 Success Criteria**

- [ ] `gd` is faster than `Space+G+D` by muscle memory
- [ ] Can commit and push without thinking in <30 seconds
- [ ] Use multiple cursors for batch edits instinctively
- [ ] Search across entire project in <10 seconds
- [ ] 2-3x faster than Week 1 on same tasks

**Self-Assessment**: If you barely used leader-key today (mostly Vim-style or native), you passed! 🎉

---

## 💎 Milestone 5: Expert (Week 5)

**Goal**: Master advanced refactorings, code generation, and become self-sufficient in discovering new shortcuts.

### **Learning Goals**

#### 5.1 Advanced Refactorings (Day 1-2)
- [ ] `Space+RS` - Change signature (add/remove/reorder parameters)
- [ ] `Space+MOV` - Move class/method to another file
- [ ] `Space+DEL` - Safe delete (checks all usages)
- [ ] `Space+RP` - Introduce parameter
- [ ] `Space+RI` - Inline (reverse of extract)

**Practice Exercise**:
```
Task: Function Signature Evolution
Start with:
```typescript
function createUser(name: string) {
  return { name };
}
```

Evolve it using refactorings:
1. Change signature to add `email` parameter (Space+RS)
2. Extract name validation to method (Cmd+Option+M)
3. Introduce parameter `options` (Space+RP)
4. Move to UserService class (Space+MOV)
5. Inline simple getters (Space+RI)

All using keyboard only!

Success: Complete evolution in <5 minutes
```

#### 5.2 Code Generation Mastery (Day 2-3)
- [ ] `Shift+Space` or `Space+GE` - Generate menu
- [ ] Generate constructors
- [ ] Generate getters/setters
- [ ] Generate toString/equals
- [ ] Generate tests
- [ ] Generate missing members

**Practice Exercise**:
```
Task: Class Generation Challenge
Create a TypeScript class using ONLY generation:
1. Type: `class User {}`
2. Generate constructor (Shift+Space)
3. Add properties through constructor
4. Generate getters (Shift+Space)
5. Generate toString (Shift+Space)
6. Implement interface (Space+IM)
7. Override methods (Space+OM)
8. Generate test (Space+G+T)

Target: Create full class with tests in <3 minutes
```

#### 5.3 Live Templates & Snippets (Day 3-4)
- [ ] Learn built-in live templates
- [ ] `main` - main method
- [ ] `sout` - console.log
- [ ] `iter` - for loop
- [ ] `itar` - for array loop
- [ ] Create custom templates

**Practice Exercise**:
```
Task: Template Speed Coding
Write these patterns using live templates:
1. Create async function → type "afn" + Tab
2. Try-catch block → type "try" + Tab
3. Console log → type "log" + Tab
4. Arrow function → type "arrow" + Tab
5. Interface → type "interface" + Tab

Learn 10 built-in templates.

Success: Use templates for 50% of boilerplate code
```

#### 5.4 Customization & Discovery (Day 4-5)
- [ ] Customize keymap (Preferences → Keymap)
- [ ] Add missing shortcuts
- [ ] Resolve conflicts
- [ ] Export keymap for backup
- [ ] Teach someone else a shortcut

**Practice Exercise**:
```
Task: Find Your Gaps
1. List 5 actions you do frequently with mouse
2. Use Cmd+Shift+A to find those actions
3. Check if they have shortcuts
4. If not, add custom shortcuts
5. Practice new shortcuts 20 times each

Examples:
- Running specific test
- Opening specific tool window
- Executing npm script
- Switching projects
```

### **Week 5 Daily Challenges**

**Monday**: Advanced refactoring day - change 5 function signatures.
**Tuesday**: Generation day - generate 10 classes with all methods.
**Wednesday**: Template day - use live templates for all boilerplate.
**Thursday**: Customization day - add 5 custom shortcuts for your frequent actions.
**Friday**: Teaching day - teach 3 shortcuts to a colleague (or write about them).

### **Week 5 Success Criteria**

- [ ] Can change function signature across entire codebase confidently
- [ ] Generate complete classes without typing boilerplate
- [ ] Use live templates for >50% of repetitive code
- [ ] Added 5+ custom shortcuts for your workflow
- [ ] Helped someone else learn a shortcut

**Self-Assessment**: If you added custom shortcuts and taught someone a shortcut, you passed! 🎉

---

## 🏆 Milestone 6: Master (Week 6)

**Goal**: Achieve flow state. Work entirely in keyboard-first mode. Become a resource for others.

### **Learning Goals**

#### 6.1 Flow State Optimization (Day 1-2)
- [ ] Zero mouse usage for 4+ hour sessions
- [ ] Automatic shortcut selection (no thinking)
- [ ] Smooth context switching
- [ ] Instant file/symbol lookup
- [ ] Effortless refactoring

**Practice Exercise**:
```
Task: Flow State Session
Set timer for 2 hours. Code entire feature using ONLY keyboard:
- No mouse
- No trackpad
- No arrow keys for navigation (use Vim motions)

Track your flow:
- How many times did you think about shortcuts? ___
- How many times did you reach for mouse? ___
- Did shortcuts feel automatic? Yes/No

Goal: Zero conscious thought about shortcuts
```

#### 6.2 Workflow Integration (Day 2-3)
- [ ] Seamless Git workflow
- [ ] Integrated debugging
- [ ] API testing without leaving IDE
- [ ] Documentation lookup without browser
- [ ] Test running with shortcuts

**Practice Exercise**:
```
Task: Full Feature Development
Develop a complete feature without leaving IntelliJ:
1. Create feature branch (Cmd+Shift+A → "Branches")
2. Create new files
3. Write code with auto-imports
4. Write tests
5. Run tests (Cmd+Shift+A → "Run tests")
6. Debug failures
7. Test API with .http files
8. Format & optimize
9. Commit & push
10. Create PR (gh cli or IDE)

All with keyboard!

Success: Complete feature in flow state
```

#### 6.3 Vim Integration Mastery (Day 3-4)
- [ ] Use Vim motions for all text editing
- [ ] Combine Vim + IDE shortcuts seamlessly
- [ ] Visual mode selections
- [ ] Vim registers for copying
- [ ] Macros for repetitive tasks

**Practice Exercise**:
```
Task: Vim + IntelliJ Harmony
Refactor code using Vim motions + IntelliJ shortcuts:
1. Use Vim motions to select method (vi{)
2. Extract method (Cmd+Option+M)
3. Use Vim to go to next method (}})
4. Use di{ to delete method body
5. Use gd to jump to declaration
6. Use Ctrl+O to jump back
7. Use . to repeat last change

Practice until Vim and IDE feel like one tool.

Success: Can't tell where Vim ends and IDE begins
```

#### 6.4 Teaching & Documentation (Day 4-5)
- [ ] Document your custom workflows
- [ ] Create custom shortcuts for team
- [ ] Write shortcuts cheat sheet
- [ ] Teach 5 people your top shortcuts
- [ ] Contribute to team efficiency

**Practice Exercise**:
```
Task: Create Team Shortcuts Guide
1. Document your top 20 shortcuts
2. Create examples for each
3. Rank by importance
4. Add screenshots/GIFs
5. Share with team
6. Run 30-min workshop

Success: 3+ team members adopt your shortcuts
```

#### 6.5 Continuous Improvement (Day 5-6)
- [ ] Track shortcuts usage (which do you use most?)
- [ ] Identify bottlenecks (what's still slow?)
- [ ] Learn one new shortcut per week
- [ ] Refine custom shortcuts
- [ ] Maintain mastery

**Practice Exercise**:
```
Task: Personal Shortcuts Audit
1. List 10 actions you do most frequently
2. Time each action
3. Check if you're using fastest shortcut
4. Optimize slow actions
5. Practice optimized workflow

Examples:
- Opening files: Shift+Shift (< 2 sec)
- Going to declaration: Cmd+B (< 1 sec)
- Refactoring: Ctrl+T (< 2 sec)
- Committing: Cmd+K (< 10 sec)

Goal: Identify and eliminate all bottlenecks
```

### **Week 6 Daily Challenges**

**Monday**: Zero-mouse Monday - no mouse/trackpad all day.
**Tuesday**: Flow state Tuesday - 4+ hour coding session in flow.
**Wednesday**: Vim mastery Wednesday - use only Vim motions for editing.
**Thursday**: Teaching Thursday - teach 3 people 3 shortcuts each.
**Friday**: Reflection Friday - document your journey and improvements.

### **Week 6 Success Criteria**

- [ ] 4+ hour coding sessions without touching mouse
- [ ] Shortcuts feel completely automatic (zero thinking)
- [ ] Vim motions + IDE shortcuts feel unified
- [ ] Taught 5+ people IntelliJ shortcuts
- [ ] Documented your custom workflow

**Self-Assessment**: If you coded for 4+ hours without thinking about shortcuts once, you're a MASTER! 🏆

---

## 📊 Progress Tracking

### **Weekly Self-Assessment**

After each week, rate yourself (1-5) on these dimensions:

| Dimension | Week 1 | Week 2 | Week 3 | Week 4 | Week 5 | Week 6 |
|-----------|--------|--------|--------|--------|--------|--------|
| **Speed** (vs mouse) | __ | __ | __ | __ | __ | __ |
| **Automaticity** (no thinking) | __ | __ | __ | __ | __ | __ |
| **Coverage** (% keyboard only) | __ | __ | __ | __ | __ | __ |
| **Confidence** | __ | __ | __ | __ | __ | __ |
| **Flow State** | __ | __ | __ | __ | __ | __ |

**Rating Scale**:
- 1 = Beginner (struggling, slow)
- 2 = Learning (getting it, still slow)
- 3 = Proficient (comfortable, decent speed)
- 4 = Advanced (fast, automatic)
- 5 = Master (effortless, teaching others)

### **Shortcuts Mastery Checklist**

Track which shortcuts you've mastered:

**Discovery (Essential)**:
- [ ] `Cmd+Shift+A` - Find Action
- [ ] `Shift+Shift` - Search Everywhere
- [ ] `Option+Enter` - Quick fixes ⭐⭐⭐⭐⭐
- [ ] `Ctrl+T` - Refactor This ⭐⭐⭐⭐⭐

**Navigation (Fast Layer)**:
- [ ] `Cmd+B` - Go to declaration
- [ ] `Option+F7` - Find usages
- [ ] `Cmd+[` / `Cmd+]` - Back/Forward

**Navigation (Vim Layer)**:
- [ ] `gd` - Go to declaration
- [ ] `gr` - Find references
- [ ] `gi` - Go to implementation
- [ ] `gh` - Quick documentation

**Refactoring**:
- [ ] `Shift+F6` - Rename
- [ ] `Cmd+Option+V` - Extract variable
- [ ] `Cmd+Option+M` - Extract method
- [ ] `Cmd+Option+L` - Reformat code

**Code Intelligence**:
- [ ] `Space+K` or `gh` - Quick docs
- [ ] `Space+P` or `Cmd+P` - Parameter info
- [ ] `Space+SO` or `Cmd+F12` - File structure

**Window Management**:
- [ ] `Ctrl+H/J/K/L` - Navigate panes
- [ ] `Ctrl+E` - Toggle Project
- [ ] `Space+W+V/H` - Split vertical/horizontal

**Total Mastered**: ___ / 30

**Goal**: Master all 30 shortcuts by end of Week 6!

---

## 🎯 Ultimate Mastery Goals

By completing this 6-week program, you will:

### **Speed Goals**
- [ ] 5x faster than mouse-based workflow
- [ ] Open any file in project in <2 seconds
- [ ] Navigate to any symbol in <3 seconds
- [ ] Refactor code in <10 seconds
- [ ] Commit & push in <30 seconds

### **Efficiency Goals**
- [ ] Zero mouse usage for 4+ hour coding sessions
- [ ] 100% keyboard-driven file operations
- [ ] Auto-import every symbol without typing
- [ ] Refactor fearlessly with keyboard shortcuts
- [ ] Debug entire flows without leaving keyboard

### **Mastery Goals**
- [ ] Shortcuts feel automatic (zero thinking)
- [ ] Achieve flow state regularly
- [ ] Teach others IntelliJ shortcuts
- [ ] Create custom shortcuts for team
- [ ] Contribute to team productivity

---

## 📈 Measuring Success

### **Quantitative Metrics**

**Week 1 Baseline** (measure these):
- Time to open 10 random files: ___ seconds
- Time to find 5 symbols: ___ seconds
- Mouse clicks per hour: ___ clicks
- Shortcuts used per hour: ___ shortcuts

**Week 6 Final** (measure again):
- Time to open 10 random files: ___ seconds (goal: 3x faster)
- Time to find 5 symbols: ___ seconds (goal: 3x faster)
- Mouse clicks per hour: ___ clicks (goal: <10 clicks)
- Shortcuts used per hour: ___ shortcuts (goal: >100 shortcuts)

### **Qualitative Indicators**

You've achieved mastery when:
- ✅ You don't think about shortcuts - they just happen
- ✅ Reaching for mouse feels weird and slow
- ✅ You're teaching others shortcuts
- ✅ You can code in flow state for hours
- ✅ You've created custom shortcuts for your workflow
- ✅ You can't imagine going back to mouse-based workflow

---

## 🎓 Graduation Certificate

```
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║         IntelliJ IDEA + IdeaVim Mastery Certificate       ║
║                                                            ║
║  This certifies that [Your Name] has successfully         ║
║  completed the 6-week IntelliJ Mastery Path and           ║
║  achieved fluency in keyboard-driven TypeScript           ║
║  development.                                              ║
║                                                            ║
║  Completion Date: _______________                          ║
║                                                            ║
║  Milestones Achieved:                                      ║
║  ✓ Novice (Week 1) - Foundation & Discovery               ║
║  ✓ Learner (Week 2) - TypeScript Essentials               ║
║  ✓ Proficient (Week 3) - Full-Stack Workflows             ║
║  ✓ Advanced (Week 4) - Speed & Optimization                ║
║  ✓ Expert (Week 5) - Refactoring Mastery                   ║
║  ✓ Master (Week 6) - Flow State & Teaching                 ║
║                                                            ║
║  Total Shortcuts Mastered: 30+                             ║
║  Speed Improvement: 5x faster than baseline                ║
║  Keyboard-Only Sessions: 4+ hours                          ║
║                                                            ║
║  🏆 MASTER LEVEL ACHIEVED 🏆                              ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
```

---

## 📚 Resources

- **[Complete Keybindings Reference](./intellij-keybindings.md)** - All shortcuts documented
- **[Quick Reference Card](./intellij-quick-ref.md)** - Top 30 essential shortcuts
- **[Improvements Analysis](./intellij-improvements.md)** - Inconsistencies & fixes
- **[IdeaVim Config](../../ideavim/.ideavimrc)** - Your actual configuration

---

## 💬 Community & Support

### **Share Your Progress**
- Tweet your milestones with #IntelliJMastery
- Share your custom shortcuts with the team
- Teach others what you learn each week

### **Get Help**
- Use `Cmd+Shift+A` to discover any action
- Check [JetBrains docs](https://www.jetbrains.com/help/idea/)
- Ask in your team's Slack/Discord

---

**Ready to start your mastery journey? Begin with Week 1 tomorrow!** 🚀

**Remember**: The goal isn't to memorize every shortcut. The goal is to make keyboard-first development feel **natural, fast, and effortless**. Focus on one milestone at a time, practice daily, and track your progress.

**You've got this!** 💪
