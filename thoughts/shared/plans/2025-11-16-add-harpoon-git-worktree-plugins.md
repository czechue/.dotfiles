# Add Harpoon and git-worktree.nvim Plugins Implementation Plan

## Overview

Add two navigation and workflow enhancement plugins from ThePrimeagen to the Neovim configuration:
1. **Harpoon 2** - Quick file navigation for frequently accessed files in a working set
2. **git-worktree.nvim** - Git worktree management from within Neovim

These plugins complement the existing Telescope, Neo-tree, and lazygit setup without conflicts or duplication.

## Current State Analysis

**Current Plugin Count**: 32 plugins (from research: `2025-11-16-harpoon-git-worktree-analysis.md`)

**Relevant Existing Plugins**:
- `lazy.nvim` - Plugin manager (already configured)
- `telescope.nvim` + `plenary.nvim` - Fuzzy finder (already present)
- `lazygit.nvim` - Git TUI integration at `lua/custom/plugins/init.lua:31-47`
- `gitsigns.nvim` - Git gutter signs only (keybindings NOT loaded - `init.lua:1112` is commented out)
- `which-key.nvim` - Keymap hints (configured at `init.lua:299-351`)

**Current Keybinding Status**:
- `<leader>h` group defined in which-key as 'Git [H]unk' (`init.lua:348`)
- However, gitsigns keybindings module is NOT loaded (`init.lua:1112` commented out)
- Result: **`<leader>h` is completely free** for Harpoon
- `<leader>gw*` - Not currently used, available for git-worktree
- `<leader>1-9` - Not currently used, available for Harpoon file slots

**Custom Plugins Location**: `nvim/.config/nvim/lua/custom/plugins/init.lua`

**Git Commit**: `0418f80d0b514fd3e01a69295a903db2a64537dd`

## Desired End State

### Success State:
After implementation, the Neovim setup will have:
1. **Harpoon 2** installed and configured with:
   - `<leader>a` to add/mark current file
   - `<leader>h` to toggle quick menu
   - `<leader>1` through `<leader>5` for direct file access (5 slots)
   - Marks persisting per-project across sessions
2. **git-worktree.nvim** installed and configured with:
   - `<leader>gws` to switch/delete worktrees via Telescope
   - `<leader>gwc` to create new worktrees
   - Telescope integration loaded
3. **which-key** updated to reflect:
   - `<leader>h` group changed to 'Harpoon' (from 'Git [H]unk')
   - `<leader>g` group includes worktree operations
4. **Total plugin count**: 34 plugins (32 + 2 new)

### How to Verify:
- Open Neovim and check `:Lazy` shows Harpoon and git-worktree.nvim installed
- Press `<leader>` and verify which-key shows correct group labels
- Test Harpoon by marking a file (`<leader>a`) and opening menu (`<leader>h`)
- Test git-worktree by listing worktrees (`<leader>gws`)
- Verify no errors in `:checkhealth` or during startup

## What We're NOT Doing

1. **NOT modifying existing plugin configurations** - Telescope, lazygit, Neo-tree remain unchanged
2. **NOT enabling gitsigns keybindings** - They remain commented out, `<leader>h` stays free
3. **NOT setting up bare repository workflow** - That's a user choice for later if desired
4. **NOT adding Telescope integration for Harpoon** - The quick menu is sufficient; Telescope integration uses `<C-e>` which conflicts with Neo-tree
5. **NOT adding hooks for plugin integration** - Keep configuration simple; advanced hooks can be added later if needed
6. **NOT adding cycling keybindings** (`<C-S-P>/<C-S-N>`) - Stick to direct numeric access for simplicity

## Implementation Approach

**Strategy**: Incremental, tested additions
1. Add Harpoon first, test it independently
2. Add git-worktree.nvim second, test it independently
3. Update which-key configuration to reflect new keybindings
4. Final verification of all components together

**Why this order?**
- Harpoon has no dependencies on other plugins (just plenary, already present)
- git-worktree requires Telescope extension loading, verify Harpoon works first
- which-key update is cosmetic and should be done after functional plugins work

## Phase 1: Add Harpoon Configuration

### Overview
Add Harpoon 2 plugin configuration to `lua/custom/plugins/init.lua` with keybindings for marking files and quick access to 5 file slots.

### Changes Required:

#### 1. Add Harpoon Plugin Configuration
**File**: `nvim/.config/nvim/lua/custom/plugins/init.lua`
**Changes**: Add new plugin entry after lazygit.nvim (around line 47)

```lua
  -- Harpoon 2 - Quick file navigation for working set
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
      { '<leader>5', function() require('harpoon'):list():select(5) end, desc = 'Harpoon: File 5' },
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

**Location**: Insert after line 47 (after lazygit.nvim closing brace), before the final `return` closing brace on line 48.

**Rationale**:
- `branch = 'harpoon2'` - Use Harpoon 2 (current stable version)
- `keys` - Lazy-loading on keybindings for performance
- `save_on_toggle = true` - Persist marks when closing menu
- `sync_on_ui_close = true` - Save marks when UI closes
- 5 file slots as requested by user

### Success Criteria:

#### Automated Verification:
- [ ] Neovim starts without errors: `nvim --headless +qall`
- [ ] Plugin manager shows Harpoon installed: Check `:Lazy` output (manual inspection via `nvim -c 'Lazy' -c 'sleep 2' -c 'qall'` not reliable for verification)
- [ ] Checkhealth passes: `nvim --headless +"checkhealth lazy" +qall` (shows no critical errors)

#### Manual Verification:
- [ ] Open Neovim and run `:Lazy` - verify Harpoon appears in plugin list with correct status
- [ ] Open a file and press `<leader>a` - verify no error messages appear
- [ ] Press `<leader>h` - verify Harpoon quick menu opens showing the marked file
- [ ] Navigate to another file, mark it, press `<leader>1` - verify it jumps to first marked file
- [ ] Press `<leader>2` - verify it jumps to second marked file
- [ ] Close and reopen Neovim in same directory - verify marks persist across sessions
- [ ] Verify all 5 slots work: `<leader>1` through `<leader>5`

**Implementation Note**: After completing this phase and all automated verification passes, pause here for manual confirmation from the human that the manual testing was successful before proceeding to Phase 2.

---

## Phase 2: Add git-worktree.nvim Configuration

### Overview
Add git-worktree.nvim plugin to enable Git worktree management via Telescope integration. This plugin works alongside lazygit for comprehensive Git workflow support.

### Changes Required:

#### 1. Add git-worktree.nvim Plugin Configuration
**File**: `nvim/.config/nvim/lua/custom/plugins/init.lua`
**Changes**: Add new plugin entry after Harpoon configuration

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

**Location**: Insert after Harpoon configuration, before the final `return` closing brace.

**Configuration Rationale**:
- `change_directory_command = 'cd'` - Standard vim directory change command
- `update_on_change = true` - Auto-update buffers when switching worktrees (helpful for Neo-tree refresh)
- `clearjumps_on_change = true` - Prevent jumping to files from old worktree via jumplist
- `autopush = false` - Manual push preferred (safer workflow)
- Telescope extension loaded for UI integration

**Keybinding Rationale**:
- `<leader>gws` - Mnemonic: "git worktree switch" - lists worktrees, allows switching or deleting
- `<leader>gwc` - Mnemonic: "git worktree create" - creates new worktree
- Fits existing pattern: `<leader>gg` for lazygit

### Success Criteria:

#### Automated Verification:
- [ ] Neovim starts without errors: `nvim --headless +qall`
- [ ] Plugin manager shows git-worktree.nvim installed: Check `:Lazy` (manual inspection required)
- [ ] Telescope extension loads: `nvim --headless +"lua require('telescope').load_extension('git_worktree')" +qall` (no errors)
- [ ] Checkhealth passes: `nvim --headless +"checkhealth lazy" +qall`

#### Manual Verification:
- [ ] Open Neovim in a git repository and run `:Lazy` - verify git-worktree.nvim appears in plugin list
- [ ] Press `<leader>gws` - verify Telescope opens with worktree list (may show only current worktree)
- [ ] Press `<leader>gwc` - verify Telescope prompts for branch name and path
- [ ] If in a repository with multiple worktrees, test switching between them via `<leader>gws` → select worktree → Enter
- [ ] Verify no errors in `:messages` after using worktree commands
- [ ] Test that lazygit (`<leader>gg`) still works correctly alongside git-worktree

**Implementation Note**: After completing this phase and all automated verification passes, pause here for manual confirmation from the human that the manual testing was successful before proceeding to Phase 3.

---

## Phase 3: Update which-key Configuration

### Overview
Update the which-key group definitions to reflect the new Harpoon keybindings. Change `<leader>h` from 'Git [H]unk' to 'Harpoon' since gitsigns keybindings are not loaded.

### Changes Required:

#### 1. Update which-key Group Definition
**File**: `nvim/.config/nvim/init.lua`
**Changes**: Modify the `spec` section in which-key configuration (around line 341-349)

**Old code** (line 348):
```lua
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
```

**New code**:
```lua
        { '<leader>h', group = 'Harpoon', mode = { 'n', 'v' } },
```

**Rationale**:
- The original 'Git [H]unk' group was intended for gitsigns keybindings
- gitsigns keybindings module is NOT loaded (`init.lua:1112` commented out)
- `<leader>h` is now used by Harpoon, so the label should reflect this
- Mode includes both 'n' (normal) and 'v' (visual) to match original definition

### Success Criteria:

#### Automated Verification:
- [ ] Neovim starts without errors: `nvim --headless +qall`
- [ ] No Lua syntax errors: `nvim --headless +"luafile ~/.config/nvim/init.lua" +qall`

#### Manual Verification:
- [ ] Open Neovim and press `<leader>` (space) - verify which-key popup appears
- [ ] In the which-key popup, verify `h` shows as "Harpoon" (not "Git [H]unk")
- [ ] Press `h` while which-key is open - verify submenu shows Harpoon keybindings:
  - Should show options like "Menu", "Add file", etc.
- [ ] Verify other which-key groups are unchanged (s, g, c, d, r, w, t)

**Implementation Note**: This phase is cosmetic and low-risk. After verification, proceed to final testing phase.

---

## Phase 4: Final Verification and Documentation

### Overview
Perform comprehensive testing of all new functionality together and verify integration with existing plugins.

### Changes Required:

No code changes in this phase - this is pure verification and testing.

### Success Criteria:

#### Automated Verification:
- [ ] Full Neovim startup check: `nvim --headless +qall` (exit code 0)
- [ ] Plugin count verification: Check `:Lazy` shows 34 total plugins
- [ ] Full checkhealth: `nvim --headless +"checkhealth" +qall > /tmp/health.log 2>&1; cat /tmp/health.log | grep -i "error\|warning"`

#### Manual Verification:

**Harpoon Integration Test**:
- [ ] Open project via `<C-f>` (tmux-sessionizer)
- [ ] Use Telescope (`<leader>sf`) to find a file, then mark it with `<leader>a`
- [ ] Find 4 more files and mark each (`<leader>a`)
- [ ] Press `<leader>h` to verify all 5 files appear in menu
- [ ] Test rapid switching: `<leader>1` → `<leader>2` → `<leader>3` → `<leader>4` → `<leader>5`
- [ ] Verify cursor position is preserved when switching between marked files
- [ ] Close Neovim, reopen in same directory, verify marks persisted

**git-worktree Integration Test** (if in a git repository):
- [ ] In a git repository, press `<leader>gws` to list worktrees
- [ ] If multiple worktrees exist, test switching between them
- [ ] Create a new worktree: `<leader>gwc` → enter branch name → enter path
- [ ] Verify Neovim switches to new worktree directory
- [ ] Verify Neo-tree updates to show new worktree files
- [ ] Switch back to original worktree: `<leader>gws` → select original
- [ ] Open lazygit (`<leader>gg`) and verify it shows correct worktree context

**Existing Functionality Test**:
- [ ] Telescope still works: `<leader>sf`, `<leader>sg`, `<leader>sh`
- [ ] Neo-tree still works: `<C-e>`
- [ ] lazygit still works: `<leader>gg`
- [ ] LSP still works: `gd`, `gr`, `<leader>ca`
- [ ] Buffer navigation still works: `<leader><leader>`
- [ ] No conflicts or errors in `:messages`

**which-key Verification**:
- [ ] Press `<leader>` - verify which-key shows clean, organized groups
- [ ] Verify `h` group shows as "Harpoon"
- [ ] Verify `g` group includes git operations (lazygit + worktree)
- [ ] Verify numeric keys 1-5 show Harpoon descriptions

**Performance Check**:
- [ ] Neovim startup time is acceptable (use `:Lazy profile` to check)
- [ ] No noticeable lag when using Harpoon or git-worktree commands
- [ ] Plugins are lazy-loaded correctly (check `:Lazy` status)

### Final Validation

After all manual testing succeeds:
1. Run `:Lazy sync` to ensure all plugins are up to date
2. Restart Neovim one final time to verify clean startup
3. Confirm total plugin count is 34 (32 original + 2 new)
4. Verify no warnings in `:checkhealth lazy`

---

## Testing Strategy

### Unit Testing:
Not applicable - Neovim plugin configuration is tested via manual verification and startup checks.

### Integration Testing:

**Test 1: Harpoon with Telescope**
1. Use Telescope to find files
2. Mark files with Harpoon
3. Verify rapid switching works
4. Verify marks persist across sessions

**Test 2: git-worktree with lazygit**
1. Create worktree via git-worktree.nvim
2. Switch to worktree
3. Open lazygit in worktree
4. Perform git operations (stage, commit)
5. Switch back via git-worktree.nvim
6. Verify lazygit context updates correctly

**Test 3: which-key Integration**
1. Press `<leader>` to open which-key
2. Navigate through groups
3. Verify all Harpoon and worktree commands appear correctly
4. Verify descriptions are clear and accurate

### Manual Testing Steps:

**Scenario 1: Feature Development Workflow**
1. Open project via `<C-f>` (tmux-sessionizer)
2. Use Telescope (`<leader>sf`) to find component file → mark with `<leader>a`
3. Find test file → mark with `<leader>a`
4. Find config file → mark with `<leader>a`
5. Rapid cycle: `<leader>1` (component) → edit → `<leader>2` (test) → write test → `<leader>3` (config) → update
6. Verify workflow is faster than repeated Telescope searches

**Scenario 2: PR Review with Worktrees**
1. Currently on `main` branch with uncommitted changes
2. Create worktree for PR: `<leader>gwc` → enter `feature-review` → enter path `../feature-review`
3. Neovim switches to new worktree
4. Review code in worktree
5. Switch back: `<leader>gws` → select `main`
6. Verify original work is intact and uncommitted changes preserved
7. Delete review worktree: `<leader>gws` → select `feature-review` → `<C-d>`

**Scenario 3: Cross-Plugin Integration**
1. In main worktree, mark 5 files with Harpoon
2. Create new worktree: `<leader>gwc`
3. Verify Harpoon marks are independent in new worktree
4. Mark different files in new worktree
5. Switch back to main worktree: `<leader>gws`
6. Verify original Harpoon marks are restored
7. Open lazygit (`<leader>gg`) - verify correct worktree context

## Performance Considerations

**Lazy Loading**:
- Both plugins use `keys` parameter for lazy loading on keybindings
- Harpoon loads only when using `<leader>a`, `<leader>h`, or `<leader>1-5`
- git-worktree loads only when using `<leader>gws` or `<leader>gwc`
- Minimal impact on startup time

**Memory Usage**:
- Harpoon stores marks in project-local files (negligible disk space)
- git-worktree operates on Git's native worktree structure (no additional overhead)

**Potential Bottlenecks**:
None expected. Both plugins are lightweight and only active when explicitly invoked.

## Migration Notes

Not applicable - this is a new feature addition, not a migration.

**Rollback Strategy** (if needed):
1. Remove Harpoon and git-worktree.nvim entries from `lua/custom/plugins/init.lua`
2. Revert which-key change in `init.lua` (change 'Harpoon' back to 'Git [H]unk')
3. Run `:Lazy clean` to remove plugins
4. Restart Neovim

## References

- Original research: `thoughts/shared/research/2025-11-16-harpoon-git-worktree-analysis.md`
- Previous Neovim research: `thoughts/shared/research/2025-11-15-nvim-configuration-analysis.md`
- Harpoon 2 repository: https://github.com/ThePrimeagen/harpoon/tree/harpoon2
- git-worktree.nvim repository: https://github.com/ThePrimeagen/git-worktree.nvim
- YouTube trigger: https://www.youtube.com/watch?v=bdumjiHabhQ
- Configuration files:
  - Custom plugins: `nvim/.config/nvim/lua/custom/plugins/init.lua:1-48`
  - Main config: `nvim/.config/nvim/init.lua`
  - which-key config: `nvim/.config/nvim/init.lua:299-351`
