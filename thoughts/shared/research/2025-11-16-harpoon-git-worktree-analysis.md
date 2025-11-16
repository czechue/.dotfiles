---
date: 2025-11-16T10:30:00+01:00
researcher: Michał Lester
git_commit: 0418f80d0b514fd3e01a69295a903db2a64537dd
branch: master
repository: .dotfiles
topic: "Analysis of Adding Harpoon and git-worktree.nvim Plugins to Neovim Setup"
tags: [research, codebase, nvim, neovim, harpoon, git-worktree, lazygit, plugins, navigation]
status: complete
last_updated: 2025-11-16
last_updated_by: Michał Lester
last_updated_note: "Corrected keybinding conflict analysis - <leader>h is completely free (gitsigns keybindings not enabled)"
---

# Research: Analysis of Adding Harpoon and git-worktree.nvim to Neovim Setup

**Date**: 2025-11-16T10:30:00+01:00
**Researcher**: Michał Lester
**Git Commit**: 0418f80d0b514fd3e01a69295a903db2a64537dd
**Branch**: master
**Repository**: .dotfiles

## Research Question

Analyze the current Neovim setup to assess the feasibility and compatibility of adding two plugins from ThePrimeagen:
1. **Harpoon** (https://github.com/ThePrimeagen/harpoon) - Quick file navigation
2. **git-worktree.nvim** (https://github.com/ThePrimeagen/git-worktree.nvim) - Git worktree management

Specifically evaluate:
- How these plugins fit into the existing workflow
- Compatibility with current plugins (especially lazygit)
- Integration with lazy.nvim plugin manager
- Potential keybinding conflicts
- Whether they complement or duplicate existing functionality

**Trigger**: YouTube video https://www.youtube.com/watch?v=bdumjiHabhQ

## Summary

Both **Harpoon** and **git-worktree.nvim** are excellent additions to the current Neovim setup and **complement existing functionality** rather than duplicating it.

**Key Findings**:
- **Harpoon** fills a navigation gap between Telescope (project-wide search) and buffer navigation - providing instant access to a working set of 4-6 frequently used files
- **git-worktree.nvim** is **fully compatible** with lazygit - they work together harmoniously to manage Git worktrees
- Both plugins integrate cleanly with lazy.nvim and have minimal dependencies (only plenary.nvim, already present)
- **Zero keybinding conflicts**: `<leader>h` is completely free (gitsigns keybindings are not enabled in the configuration)
- Both plugins follow similar patterns to existing configuration (Telescope integration, leader-based keymaps)

**Critical Discovery**: The gitsigns keybindings module (`kickstart/plugins/gitsigns.lua`) is commented out in `init.lua:1112`, making `<leader>h` completely available for Harpoon without any adjustments needed.

**Recommendation**: Both plugins are safe to add and will enhance the development workflow without disrupting existing patterns.

## Detailed Findings

### Current Neovim Setup Context

**Plugin Manager**: lazy.nvim (init.lua:232-242)

**Total Plugins**: 32 plugins currently installed (from previous research: 2025-11-15-nvim-configuration-analysis.md)

**Relevant Existing Plugins**:
- **Telescope** (init.lua:360-536) - Fuzzy finder for files, grep, LSP symbols
- **Neo-tree** (lua/kickstart/plugins/neo-tree.lua) - File tree explorer
- **lazygit.nvim** (lua/custom/plugins/init.lua:31-47) - Git TUI integration
- **gitsigns.nvim** (init.lua:271-282) - Git gutter signs and hunk operations
- **plenary.nvim** - Already present as dependency for Telescope

**Current Navigation Patterns**:
- `<leader>sf` - Telescope file search
- `<leader>s.` - Recent files (oldfiles)
- `<leader><leader>` - Buffer switching
- `<C-e>` - Neo-tree file explorer
- `<leader>gg` - LazyGit interface
- Custom directory scope freezing in Telescope (`<C-d>`)

**Leader Key**: `<space>` (init.lua:90)

---

## Plugin 1: Harpoon Analysis

### What Harpoon Provides

**Core Functionality**:
- Marks a small set (4-6) of frequently accessed files for instant navigation
- Provides direct numeric keybindings to jump to marked files
- Maintains cursor position within marked files
- Persists marks per-project across sessions

**Problem It Solves**:
- **Telescope Fatigue**: When you find yourself searching for the same files repeatedly
- **Buffer Cycling Tedium**: When `:bnext`/`:bprev` becomes too slow for many buffers
- **Context Switching Overhead**: Reduces cognitive load by providing deterministic file access

**Philosophy**: "Living marks" for your active working set - not for all files, just the ones you're working with *right now*.

### How It Differs from Existing Navigation

| Tool | Scope | Use Case | Speed | When to Use |
|------|-------|----------|-------|-------------|
| **Telescope** | All files in project | Discovery, searching | 3-5 keystrokes + typing | "Where is that file?" |
| **Neo-tree** | Directory structure | Visual exploration | Multiple keystrokes | "Browse project structure" |
| **Buffer list** | Open buffers | Switching between many open files | 2-4 keystrokes | "Which file was open?" |
| **Harpoon** | 4-6 marked files | Rapid switching in working set | **1 keystroke** | "Back to my core files" |

**Key Insight**: Harpoon is **complementary**, not competing:
- Use **Telescope** to discover files (95% of project)
- Use **Harpoon** after marking your working set (5% actively editing)
- Use **Neo-tree** for visual browsing
- Use **Buffer list** when working with 7+ files

### Integration Requirements

**Dependencies**:
- `nvim-lua/plenary.nvim` - ✅ Already present (used by Telescope)
- Neovim 0.8.0+ - ✅ Current setup uses Neovim 0.11

**lazy.nvim Configuration Pattern**:
```lua
{
  "ThePrimeagen/harpoon",
  branch = "harpoon2",  -- IMPORTANT: Use harpoon2 branch
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon: Mark file" },
    { "<leader>h", function()
      local harpoon = require("harpoon")
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, desc = "Harpoon: Menu" },
    { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon: File 1" },
    { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon: File 2" },
    { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon: File 3" },
    { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon: File 4" },
  },
  config = function()
    require("harpoon"):setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })
  end,
}
```

### Keybinding Compatibility Analysis

**Proposed Keybindings**:
- `<leader>a` - Add current file to harpoon
- `<leader>h` - Toggle harpoon quick menu
- `<leader>1` through `<leader>4` (or more) - Jump to marked files

**Conflict Check**:
- `<leader>a` - ✅ Not currently used
- `<leader>h` - ✅ **COMPLETELY FREE** (gitsigns keybindings are NOT enabled - line 1112 in init.lua is commented out)
- `<leader>1` through `<leader>9` - ✅ Not currently used

**Important Discovery**:
While `kickstart/plugins/gitsigns.lua` exists and defines `<leader>h*` keybindings, it is **NOT loaded** in the configuration:
```lua
-- Line 1112 in init.lua:
-- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
```

This means:
- ✅ gitsigns.nvim IS installed (for visual signs in gutter: `+`, `~`, `_`)
- ✅ gitsigns keybindings are NOT loaded
- ✅ `<leader>h` is completely available for Harpoon
- ✅ No conflicts whatsoever

**Recommended Keybindings**:
```lua
<leader>a   -- Add file to harpoon
<leader>h   -- Harpoon menu (NO CONFLICT!)
<leader>1-4 -- Direct file access
```

### Optional Telescope Integration

Harpoon 2 can integrate with Telescope for browsing marks:
```lua
vim.keymap.set("n", "<C-e>", function()
  local harpoon = require('harpoon')
  local conf = require("telescope.config").values
  local file_paths = {}
  for _, item in ipairs(harpoon:list().items) do
    table.insert(file_paths, item.value)
  end
  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({ results = file_paths }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end, { desc = "Open Harpoon in Telescope" })
```

This would conflict with current Neo-tree `<C-e>` binding but demonstrates the integration flexibility.

### Benefits for Current Workflow

**Use Case 1: Feature Development**
```
Day 1 of new feature:
1. Use Telescope (<leader>sf) to find controller → Mark with <leader>a
2. Use Telescope to find service → Mark with <leader>a
3. Find test file → Mark with <leader>a
4. Find component → Mark with <leader>a

Now: <leader>1-4 instantly switch between these files
```

**Use Case 2: Bug Fixing**
```
Bug reported in production:
1. Find bug location via Telescope → Mark
2. Find related files → Mark each
3. Find test file → Mark

Rapidly iterate: <leader>1 (bug) → fix → <leader>2 (test) → verify → repeat
```

**Use Case 3: Code Review**
```
PR files to review:
1. Mark each file as you go through them
2. Jump between implementations: <leader>1-4
3. Compare approaches without fuzzy finding
```

### Workflow Integration

**With Telescope**:
- Telescope remains primary tool for discovery
- After finding files, mark them with Harpoon
- Use Harpoon for repeated access during focused work

**With Neo-tree**:
- Neo-tree still useful for visual browsing
- Use Neo-tree to explore, Harpoon to work

**With Buffer List**:
- Harpoon reduces need for buffer list when working on specific task
- Buffer list still useful for "what's open?" overview

**With tmux-sessionizer** (init.lua:176):
- Current setup uses `<C-f>` for project switching
- Harpoon marks are per-project, so switching projects gives fresh marks
- Complements project-level navigation

---

## Plugin 2: git-worktree.nvim Analysis

### What git-worktree.nvim Provides

**Core Functionality**:
- Simplifies Git worktree management from within Neovim
- Create, switch, and delete worktrees via Telescope or Lua API
- Automatic buffer and jumplist management when switching worktrees
- Hooks system for integration with other plugins

**Git Worktrees Explained**:
- Git feature allowing multiple branches checked out simultaneously
- Each worktree is a separate working directory
- Shares the same `.git` repository (space efficient)
- Prevents branch conflicts (one branch per worktree)

**Problem It Solves**:
- **No More Stashing**: Work on multiple branches without stashing changes
- **Parallel Workflows**: Run tests in one worktree while coding in another
- **PR Reviews**: Check out PRs without disrupting current work
- **Hotfix Management**: Handle urgent fixes without losing context

### Compatibility with lazygit

**Key Finding**: **Fully Compatible** ✅

**Evidence**:
1. **Lazygit has native worktree support** (added in recent versions)
   - Can navigate worktrees in lazygit UI
   - Can `cd` into worktrees by pressing space
   - Provides visual terminal interface for worktree management

2. **git-worktree.nvim operates on same Git data**
   - Both tools interact with Git's worktree structure
   - No conflicts - they complement each other

3. **Real-world usage patterns**:
   - Create worktrees with git-worktree.nvim (via Telescope)
   - Manage branches/commits in those worktrees with lazygit
   - Switch between worktrees using either tool

**Integration Example from AstroNvim**:
AstroNvim documentation shows explicit configuration for using gitsigns, lazygit, and git-worktree together with detached worktrees.

**Workflow with Both Tools**:
```
1. Create worktree: Telescope git_worktree (Neovim)
2. Switch to worktree: <leader>gws (Neovim)
3. Make changes: normal editing
4. Git operations: <leader>gg (lazygit) for commits, branches, etc.
5. Switch back: <leader>gws (Neovim)
```

### Integration Requirements

**Dependencies**:
- `nvim-lua/plenary.nvim` - ✅ Already present
- `nvim-telescope/telescope.nvim` - ✅ Already present
- External: `git` command - ✅ Already required for lazygit

**lazy.nvim Configuration Pattern**:
```lua
{
  'ThePrimeagen/git-worktree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim'
  },
  config = function()
    require("git-worktree").setup({
      change_directory_command = "cd",
      update_on_change = true,
      update_on_change_command = "e .",
      clearjumps_on_change = true,
      autopush = false,
    })
    require("telescope").load_extension("git_worktree")
  end,
  keys = {
    { '<leader>gws', function() require('telescope').extensions.git_worktree.git_worktrees() end, desc = 'Git Worktree: Switch' },
    { '<leader>gwc', function() require('telescope').extensions.git_worktree.create_git_worktree() end, desc = 'Git Worktree: Create' },
  }
}
```

### Keybinding Compatibility Analysis

**Proposed Keybindings**:
- `<leader>gws` - Git Worktree Switch (list and switch)
- `<leader>gwc` - Git Worktree Create

**Conflict Check**:
- `<leader>g*` prefix - Currently used for LSP "goto" operations (gd, gr, gI)
- `<leader>gg` - Currently used for LazyGit (init.lua:44)
- `<leader>gw*` - ✅ Not currently used

**Analysis**:
- No conflicts! `<leader>gw` is available
- Fits existing pattern of git operations with `<leader>g*`
- `<leader>gg` = Git TUI (lazygit)
- `<leader>gw*` = Git Worktrees
- LSP uses short forms (`gd`, `gr`) or `<leader>g*` for type definition

**Additional Bindings in Telescope Picker**:
- `<Enter>` - Switch to worktree (default in picker)
- `<C-d>` - Delete worktree (default in picker)
- `<C-f>` - Toggle force delete (default in picker)

Note: `<C-d>` in worktree picker won't conflict with Telescope's directory scope freeze (different context - only in worktree picker).

### Integration with Current Git Workflow

**Current Git Setup**:
- **lazygit.nvim** (lua/custom/plugins/init.lua:31-47): Full git TUI
  - Keybinding: `<leader>gg`
  - Commands: `:LazyGit`, `:LazyGitCurrentFile`, etc.

- **gitsigns.nvim** (init.lua:271-282): Visual git indicators only
  - Shows `+`, `~`, `-` in sign column (gutter)
  - Keybindings are NOT loaded (init.lua:1112 is commented out)
  - No `<leader>h*` keybindings active

**git-worktree.nvim Adds**:
- Worktree management layer on top of existing git operations
- Doesn't replace lazygit or gitsigns
- Provides worktree-specific operations:
  - Create worktree from branch
  - Switch between worktrees
  - Delete worktrees
  - Automatic buffer updates when switching

**Updated Git Workflow**:
```
Visual git indicators → gitsigns.nvim (gutter signs only)
Commits/branches/general git → lazygit.nvim (<leader>gg)
Worktree management → git-worktree.nvim (<leader>gw*)
```

All work together without conflicts.

### Benefits for Current Workflow

**Use Case 1: PR Review Without Stashing**
```
Current: Working on feature-auth
PR comes in for review: feature-api

Traditional flow:
1. git stash
2. git checkout feature-api
3. Review, test, comment
4. git checkout feature-auth
5. git stash pop
(Disruptive, risk of stash conflicts)

With git-worktree.nvim:
1. <leader>gwc → create worktree for feature-api
2. Review in separate directory
3. <leader>gws → switch back to feature-auth
4. Delete worktree when done
(Non-disruptive, work remains intact)
```

**Use Case 2: Hotfix While Developing**
```
Working on long-running feature with uncommitted changes
Bug reported in production

With worktrees:
1. <leader>gwc → create worktree from main
2. Fix bug, test, commit, push (using <leader>gg for lazygit)
3. <leader>gws → back to feature branch (exactly as left)
4. Delete hotfix worktree
```

**Use Case 3: Multiple Features in Parallel**
```
Working on frontend and backend features
Backend has long build times

With worktrees:
1. Create worktree for backend-api
2. Start build in that worktree
3. <leader>gws → switch to frontend-ui worktree
4. Work on frontend while backend builds
5. Switch back when build complete
```

**Use Case 4: Testing Branch Without Switching**
```
Want to test someone's branch without losing current state

With worktrees:
1. <leader>gwc → create worktree from remote branch
2. npm install, npm run dev (in separate directory)
3. Test in browser
4. <leader>gws → back to main work
5. Delete test worktree
```

### Configuration Options

**Available Settings**:
- `change_directory_command`: Vim command for changing directory (default: "cd")
- `update_on_change`: Auto-update buffers when switching (default: true)
- `update_on_change_command`: Command when file not found (default: "e .")
- `clearjumps_on_change`: Clear jumplist on switch (default: true)
- `autopush`: Auto-push new branches (default: false)

**Recommended for Current Setup**:
```lua
{
  change_directory_command = "cd",        -- Standard
  update_on_change = true,                -- Auto-update buffers (helpful)
  update_on_change_command = "e .",       -- Refresh Neo-tree when switching
  clearjumps_on_change = true,            -- Prevent jumping to old worktree files
  autopush = false,                       -- Manual push preferred
}
```

### Hooks System for Advanced Integration

git-worktree.nvim provides hooks for plugin integration:
```lua
local Worktree = require("git-worktree")
Worktree.on_tree_change(function(op, metadata)
  if op == Worktree.Operations.Switch then
    print("Switched to: " .. metadata.path)
    -- Could refresh Harpoon marks here
    -- Could refresh lazygit state here
    -- Could trigger lualine update here
  end
end)
```

This enables advanced integrations like:
- Clearing Harpoon marks when switching worktrees
- Updating statusline with current worktree
- Refreshing lazygit when switching
- Triggering Neo-tree refresh

---

## Compatibility Matrix

| Plugin | Harpoon | git-worktree.nvim |
|--------|---------|-------------------|
| **lazy.nvim** | ✅ Native support | ✅ Native support |
| **Telescope** | ✅ Optional integration | ✅ Required for UI |
| **lazygit.nvim** | ✅ No interaction | ✅ Fully compatible |
| **gitsigns.nvim** | ✅ No interaction (keybindings not loaded) | ✅ Works in worktrees |
| **Neo-tree** | ✅ No interaction | ✅ Refreshes on switch |
| **plenary.nvim** | ✅ Required | ✅ Required |
| **LSP** | ✅ No interaction | ✅ Works per worktree |
| **Existing keybindings** | ✅ **Zero conflicts** (`<leader>h` is free) | ✅ No conflicts |

---

## Installation Recommendations

### Recommended Configuration for Harpoon

Place in `lua/custom/plugins/init.lua` (alongside lazygit):

```lua
-- Harpoon 2 - Quick file navigation
{
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>a', function() require('harpoon'):list():add() end, desc = 'Harpoon: Add file' },
    { '<leader>h', function()
      local harpoon = require('harpoon')
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, desc = 'Harpoon: Menu' },
    { '<leader>1', function() require('harpoon'):list():select(1) end, desc = 'Harpoon: File 1' },
    { '<leader>2', function() require('harpoon'):list():select(2) end, desc = 'Harpoon: File 2' },
    { '<leader>3', function() require('harpoon'):list():select(3) end, desc = 'Harpoon: File 3' },
    { '<leader>4', function() require('harpoon'):list():select(4) end, desc = 'Harpoon: File 4' },
    -- Optional: Add more files (up to <leader>9)
    -- Optional: Cycle through marks
    { '<C-S-P>', function() require('harpoon'):list():prev() end, desc = 'Harpoon: Previous' },
    { '<C-S-N>', function() require('harpoon'):list():next() end, desc = 'Harpoon: Next' },
  },
  config = function()
    require('harpoon'):setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })
  end,
},
```

**Keybinding Rationale**:
- `<leader>a` - Mnemonic: "add" to harpoon
- `<leader>h` - Mnemonic: "harpoon" menu (NO CONFLICT - this key is completely free!)
- `<leader>1-4` - Direct numeric access (can extend to 9 if needed)
- `<C-S-P/N>` - Optional cycling for those who prefer sequential navigation

**Note**: gitsigns keybindings are NOT enabled in your configuration (init.lua:1112 is commented out), so `<leader>h` is completely available.

### Recommended Configuration for git-worktree.nvim

Place in `lua/custom/plugins/init.lua`:

```lua
-- Git worktree management
{
  'ThePrimeagen/git-worktree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('git-worktree').setup({
      change_directory_command = 'cd',
      update_on_change = true,
      update_on_change_command = 'e .',
      clearjumps_on_change = true,
      autopush = false,
    })
    require('telescope').load_extension('git_worktree')
  end,
  keys = {
    {
      '<leader>gws',
      function()
        require('telescope').extensions.git_worktree.git_worktrees()
      end,
      desc = 'Git Worktree: Switch/Delete',
    },
    {
      '<leader>gwc',
      function()
        require('telescope').extensions.git_worktree.create_git_worktree()
      end,
      desc = 'Git Worktree: Create',
    },
  },
},
```

**Keybinding Rationale**:
- `<leader>gws` - Mnemonic: "git worktree switch"
- `<leader>gwc` - Mnemonic: "git worktree create"
- Fits existing git pattern (`<leader>gg` for lazygit)

### Updated Plugin Count

After adding both plugins:
- **Before**: 32 plugins
- **After**: 34 plugins
- **New dependencies**: None (plenary.nvim and telescope.nvim already present)

---

## Workflow Examples with Both Plugins

### Scenario 1: Feature Development with Rapid File Switching

**Setup Phase**:
```
1. Open project via tmux-sessionizer (<C-f>)
2. Find controller with Telescope (<leader>sf)
3. Mark with Harpoon (<leader>a)
4. Find service, mark (<leader>a)
5. Find test file, mark (<leader>a)
6. Find component, mark (<leader>a)
```

**Development Phase**:
```
1. Edit controller (<leader>1)
2. Edit service (<leader>2)
3. Write test (<leader>3)
4. Update component (<leader>4)
5. Rapid cycling: 1 → 2 → 3 → 4 → repeat
```

**No Telescope searching needed after initial setup!**

### Scenario 2: PR Review with Worktrees

**PR Arrives for Review**:
```
1. Currently on feature-auth with uncommitted changes
2. Create worktree for PR: <leader>gwc
   - Enter branch name: feature-payment
   - Worktree created in ../feature-payment
3. Neovim automatically switches to new worktree
4. Use Telescope to explore PR files (<leader>sf)
5. Mark key files with Harpoon (<leader>a)
6. Review code, jump between files (<leader>1-4)
7. Run tests, check behavior
8. Open lazygit for commit history (<leader>gg)
9. Done reviewing: <leader>gws (switch back to feature-auth)
10. Delete PR worktree: <leader>gws → <C-d> on feature-payment
```

**Result**: feature-auth work completely untouched throughout review

### Scenario 3: Hotfix with Parallel Development

**Production Bug Reported**:
```
1. Working on feature-auth with Harpoon marks set
2. Create hotfix worktree: <leader>gwc
   - Base: main
   - Branch: hotfix/login-validation
3. Neovim switches to hotfix worktree
4. Find bug location with Telescope (<leader>sf)
5. Mark bug file, test file with Harpoon (<leader>a)
6. Fix bug, switch between files (<leader>1-2)
7. Open lazygit, commit, push (<leader>gg)
8. Switch back to feature-auth: <leader>gws
9. Harpoon marks restored to feature-auth files!
10. Continue development exactly where left off
```

### Scenario 4: Multiple Features with Independent Harpoon Marks

**Parallel Development**:
```
Feature A: frontend-ui (in ~/projects/app/frontend-ui)
- Harpoon marks: Dashboard.tsx, API.ts, Dashboard.test.tsx

Feature B: backend-api (in ~/projects/app/backend-api)
- Harpoon marks: UserController.ts, UserService.ts, user.test.ts

Switching:
1. <leader>gws → select backend-api
   - Harpoon marks: Controller, Service, Test
   - Jump between them: <leader>1-3
2. <leader>gws → select frontend-ui
   - Harpoon marks: Dashboard, API, Test
   - Jump between them: <leader>1-3
```

**Each worktree maintains independent Harpoon marks!**

---

## Potential Issues and Mitigations

### Issue 1: Harpoon Marks Per Worktree

**Behavior**: Harpoon marks are per-project (per worktree directory)

**Implication**: Each worktree has independent Harpoon marks

**Is this good or bad?**
- ✅ **Good**: Each worktree represents different context, so independent marks make sense
- ✅ **Good**: Can have different working sets for different features
- ⚠️ **Consideration**: Marks don't follow when switching worktrees

**Mitigation**: This is actually desired behavior - each worktree is a different context

### Issue 2: Worktree Directory Clutter

**Problem**: Creating many worktrees can clutter parent directory

**Example**:
```
~/projects/myapp/
  main/          (worktree)
  feature-a/     (worktree)
  feature-b/     (worktree)
  hotfix-x/      (worktree)
  .git/          (repository)
```

**Solution**: Use bare repository workflow (recommended by ThePrimeagen):
```
~/projects/myapp/
  .bare/         (git repository)
  .git           (pointer file)
  main/          (worktree)
  feature-a/     (worktree)
```

**Setup**:
```bash
mkdir myapp && cd myapp
git clone --bare git@github.com:user/repo.git .bare
echo "gitdir: ./.bare" > .git
git config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
```

This isn't required but provides cleaner organization.

### Issue 3: Node Modules / Build Artifacts Per Worktree

**Reality**: Each worktree has its own `node_modules`, build artifacts, etc.

**Implication**: More disk space, more `npm install` runs

**Mitigation**:
- This is by design (prevents conflicts between branches)
- Disk space is cheap
- The benefit (no rebuilding when switching) outweighs the cost
- Delete worktrees when done to reclaim space

### Issue 4: Learning Curve

**Challenge**: Both plugins introduce new concepts
- Harpoon: "mark files" vs "open files"
- Worktrees: "switch worktrees" vs "switch branches"

**Mitigation**:
- Start small: Mark 2-3 files with Harpoon, get comfortable
- Try worktrees for PR review first (low risk)
- Watch ThePrimeagen's videos for workflow examples
- Both plugins are simple at core - complexity is opt-in

---

## Related Research and Documentation

**Previous Research in this Repository**:
- `thoughts/shared/research/2025-11-15-nvim-configuration-analysis.md` - Complete Neovim setup analysis
- `thoughts/shared/research/2025-11-11-vim-config-comparison.md` - Vim config comparison across editors

**External Resources**:

**Harpoon**:
- [Official Repository (Harpoon 2)](https://github.com/ThePrimeagen/harpoon/tree/harpoon2)
- [ThePrimeagen - Frontend Masters Course](https://frontendmasters.com/courses/vim-fundamentals/harpoon/)
- [You Don't Need Tabs in Neovim](https://medium.com/@jogarcia/you-dont-need-tabs-in-neovim-c6ba5ee44e3e)
- [LazyVim Harpoon2 Extra](https://www.lazyvim.org/extras/editor/harpoon2)

**git-worktree.nvim**:
- [Official Repository](https://github.com/ThePrimeagen/git-worktree.nvim)
- [ThePrimeagen - Everything Git Course](https://frontendmasters.com/courses/everything-git/worktrees/)
- [Official Git Worktree Docs](https://git-scm.com/docs/git-worktree)
- [lazygit Worktree Discussion](https://github.com/jesseduffield/lazygit/discussions/2803)
- [AstroNvim Worktree Recipe](https://docs.astronvim.com/recipes/detached_git_worktrees/)
- [Morgan Cugerone - Clean Worktree Workflow](https://morgan.cugerone.com/blog/how-to-use-git-worktree-and-in-a-clean-way/)

**Video Trigger**:
- [YouTube: ThePrimeagen Setup Stream](https://www.youtube.com/watch?v=bdumjiHabhQ)

---

## Code References

**Current Configuration Files**:
- Main Neovim config: `nvim/.config/nvim/init.lua`
- Custom plugins: `nvim/.config/nvim/lua/custom/plugins/init.lua:1-48`
- Neo-tree config: `nvim/.config/nvim/lua/kickstart/plugins/neo-tree.lua`
- Git signs config: `nvim/.config/nvim/lua/kickstart/plugins/gitsigns.lua`
- Lazy lock file: `nvim/.config/nvim/lazy-lock.json`

**Relevant Configuration Sections**:
- Leader key: `nvim/.config/nvim/init.lua:90`
- Telescope setup: `nvim/.config/nvim/init.lua:360-536`
- Telescope keymaps: `nvim/.config/nvim/init.lua:495-533`
- lazygit plugin: `nvim/.config/nvim/lua/custom/plugins/init.lua:31-47`
- Buffer navigation: `nvim/.config/nvim/init.lua:507`
- Window navigation: `nvim/.config/nvim/init.lua:199-202`
- Git hunk group: `nvim/.config/nvim/init.lua:348`

---

## Conclusion

Both **Harpoon** and **git-worktree.nvim** are excellent additions to the current Neovim setup:

**Harpoon**:
- ✅ Fills navigation gap between Telescope and buffer list
- ✅ Provides instant access to working set (1 keystroke)
- ✅ Complements existing tools without duplication
- ⚠️ Minor keybinding adjustment needed (`<leader>hm` instead of `<leader>h`)
- ✅ Minimal dependencies (plenary already present)
- ✅ Enhances workflow for focused development

**git-worktree.nvim**:
- ✅ Fully compatible with lazygit (they work together)
- ✅ No keybinding conflicts (`<leader>gw*` is available)
- ✅ Enables parallel development without stashing
- ✅ Perfect for PR reviews and hotfixes
- ✅ Minimal dependencies (plenary + telescope already present)
- ✅ Integrates seamlessly with existing git workflow

**Recommended Action**: Install both plugins with the configurations provided above. They will enhance the development workflow without disrupting existing patterns.

**Total Impact**:
- Plugins added: 2 (Harpoon, git-worktree.nvim)
- New dependencies: 0
- Keybinding conflicts: 0 (no conflicts whatsoever - `<leader>h` is completely free)
- Compatibility issues: 0
- Learning curve: Low (both plugins are simple at core)
- Workflow enhancement: High

Both plugins follow the same philosophy as the current setup: powerful features with minimal configuration, lazy-loaded for performance, Telescope integration, and leader-based keymaps.

**Key Discovery**: The gitsigns keybindings module (kickstart/plugins/gitsigns.lua) is NOT loaded in the configuration, making `<leader>h` completely available for Harpoon without any adjustments needed.
