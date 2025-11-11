# Vim Configuration Harmonization Implementation Plan

## Overview

Synchronize keybindings across Neovim, IdeaVim, and Cursor IDE configurations to achieve complete parity. This plan addresses two critical issues:
1. **Multicursor not working** in Neovim (plugin not installed)
2. **Format key inconsistency** (`<leader>f` vs `<leader><leader>`)
3. **Missing organize imports** binding in Neovim

## Current State Analysis

### Discovered Issues:

1. **Neovim Multicursor (`<C-g>`) Not Working**
   - **Root Cause**: `smoka7/multicursors.nvim` and `nvimtools/hydra.nvim` are NOT installed
   - **Evidence**: Checked `/Users/michallester/.local/share/nvim/lazy/` - plugins missing
   - **Config Location**: `nvim/.config/nvim/lua/custom/plugins/init.lua:6-20`
   - **Status**: Configuration is correct, but needs plugin installation
   - **Current Behavior**: `<C-g>` still shows Vim's default file info (`:h CTRL-G`) instead of starting multicursor
   - **Expected Behavior**: `<C-g>` should invoke multicursor plugin, overriding Vim's default behavior

2. **Format Key Inconsistency**
   - **Neovim**: `<leader>f` → `conform.format()` (`init.lua:737`)
   - **IdeaVim**: `<leader><leader>` → `ReformatCode` (`.ideavimrc:73`)
   - **Cursor**: `<leader><leader>` → `formatDocument` (`settings.json:147`)
   - **Decision**: Standardize on `<leader>f` across all editors

3. **Missing Organize Imports in Neovim**
   - **IdeaVim**: Has `<leader>oi` (`.ideavimrc:74`)
   - **Cursor**: Has `<leader>oi` (`settings.json:151`)
   - **Neovim**: Missing this binding
   - **Need**: Add LSP-based organize imports to Neovim

### Key Constraints:
- Must maintain muscle memory across all three editors
- Neovim uses LSP for organize imports (language-specific)
- IdeaVim and Cursor have native organize imports actions
- Cannot break existing workflows

## Desired End State

After implementation:
- ✅ `<C-g>` multicursor works in Neovim (plugins installed and loaded)
- ✅ `<leader>f` formats code in all three editors
- ✅ `<leader>oi` organizes imports in all three editors
- ✅ All keybindings documented and tested

### Verification:
1. Open Neovim, press `<C-g>` on a word → multicursor starts
2. Press `<leader>f` in any editor → code formats
3. Press `<leader>oi` in any editor → imports organized
4. Run `:checkhealth` in Neovim → no errors related to multicursors

## What We're NOT Doing

- NOT changing `<leader><leader>` in Neovim (currently mapped to buffer search via Telescope)
- NOT modifying window management keybindings (out of scope)
- NOT adding `<leader>gy` type definition harmonization (separate task)
- NOT changing multicursor plugin implementation (keeping `smoka7/multicursors.nvim`)

## Implementation Approach

Use a phased approach with automated verification after each step to ensure changes don't break existing functionality.

---

## Phase 1: Install Multicursor Plugin in Neovim

### Overview
Fix the root cause of multicursor not working by ensuring plugins are properly installed.

### Changes Required:

#### 1. Verify Plugin Configuration
**File**: `nvim/.config/nvim/lua/custom/plugins/init.lua`
**Current State**: Configuration exists (lines 6-20) but plugins not installed

**Action**: No code changes needed - configuration is correct

#### 2. Install Plugins via Lazy.nvim
**Command**: Open Neovim and run `:Lazy sync`

**Expected Result**:
- `smoka7/multicursors.nvim` installed to `~/.local/share/nvim/lazy/multicursors.nvim/`
- `nvimtools/hydra.nvim` installed to `~/.local/share/nvim/lazy/hydra.nvim/`

### Success Criteria:

#### Automated Verification:
- [ ] Plugins directory exists: `ls ~/.local/share/nvim/lazy/multicursors.nvim`
- [ ] Hydra dependency exists: `ls ~/.local/share/nvim/lazy/hydra.nvim`
- [ ] No errors in Neovim: `nvim --headless -c "checkhealth" -c "quit" 2>&1 | grep -i "error"`
- [ ] Plugin loads in Neovim: `nvim --headless -c "lua print(vim.inspect(require('lazy').plugins()))" -c "quit" 2>&1 | grep multicursors`

#### Manual Verification:
- [ ] Open Neovim
- [ ] Place cursor on a word (e.g., "function")
- [ ] Press `<C-g>` in normal mode → word should be selected with virtual cursors
  - **IMPORTANT**: Verify it does NOT show file info (Vim's default `CTRL-G` behavior)
  - Should see multicursor selection highlighting instead
- [ ] Press `<C-g>` again → next occurrence should be selected
- [ ] Press `<Esc>` → multicursor mode exits cleanly
- [ ] In visual mode, select text and press `<C-g>` → multicursor starts on selection
- [ ] Test `<leader><C-g>` → all occurrences selected
- [ ] Confirm `<C-g>` keybinding was properly overridden by the plugin

**Implementation Note**: After completing automated verification and confirming plugins are installed, test multicursor functionality manually before proceeding to Phase 2. The key test is that `<C-g>` no longer shows file information but instead activates multicursor mode.

---

## Phase 2: Standardize Format Key to `<leader>f`

### Overview
Change IdeaVim and Cursor to use `<leader>f` for formatting, matching Neovim's convention.

### Changes Required:

#### 1. IdeaVim - Change Format Key
**File**: `ideavim/.ideavimrc`
**Line**: 73
**Change**:

```vim
" Before:
map <leader><leader> <Action>(ReformatCode)

" After:
map <leader>f <Action>(ReformatCode)
```

#### 2. Cursor - Change Format Key
**File**: `cursor/settings.json`
**Lines**: 145-149
**Change**:

```json
// Before:
{
    "before": ["<leader>", "<leader>"],
    "commands": ["editor.action.formatDocument"]
},

// After:
{
    "before": ["<leader>", "f"],
    "commands": ["editor.action.formatDocument"]
},
```

### Success Criteria:

#### Automated Verification:
- [ ] IdeaVim config has `<leader>f`: `grep "<leader>f" ~/.dotfiles/ideavim/.ideavimrc`
- [ ] IdeaVim config no longer has format on `<leader><leader>`: `! grep "map <leader><leader> <Action>(ReformatCode)" ~/.dotfiles/ideavim/.ideavimrc`
- [ ] Cursor config has `<leader>f` in JSON: `grep '"before".*"<leader>".*"f"' ~/.dotfiles/cursor/settings.json`
- [ ] Cursor config no longer has double leader for format: `! grep '"before".*"<leader>".*"<leader>".*"commands".*"formatDocument"' ~/.dotfiles/cursor/settings.json`

#### Manual Verification:
- [ ] **Neovim**: Open a messy Lua file, press `<leader>f` → file formats correctly
- [ ] **IdeaVim**: Open a messy Java/Kotlin file in IntelliJ, press `<leader>f` → file formats correctly
- [ ] **Cursor**: Open a messy TypeScript file, press `<leader>f` → file formats correctly
- [ ] Verify `<leader><leader>` still works in Neovim for buffer search (Telescope)

**Implementation Note**: After automated checks pass, manually test formatting in all three editors before proceeding to Phase 3.

---

## Phase 3: Add Organize Imports to Neovim

### Overview
Add `<leader>oi` keybinding to Neovim for organizing imports via LSP, achieving parity with IdeaVim and Cursor.

### Changes Required:

#### 1. Add Organize Imports Keymap to LSP On-Attach
**File**: `nvim/.config/nvim/init.lua`
**Location**: Inside the `LspAttach` autocmd callback (after line 586, before line 627)
**Add After**: The existing `<leader>ca` code action mapping

```lua
-- Organize imports (added for parity with IdeaVim/Cursor)
map('<leader>oi', function()
  vim.lsp.buf.code_action({
    context = {
      only = { 'source.organizeImports' },
    },
    apply = true,
  })
end, '[O]rganize [I]mports')
```

**Exact Insertion Point**: After line 582 (after the `<leader>ca` mapping), add the new mapping:

```lua
          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- Organize imports (added for parity with IdeaVim/Cursor)
          map('<leader>oi', function()
            vim.lsp.buf.code_action({
              context = {
                only = { 'source.organizeImports' },
              },
              apply = true,
            })
          end, '[O]rganize [I]mports')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
```

### Success Criteria:

#### Automated Verification:
- [ ] Keymap exists in config: `grep -A5 "<leader>oi" ~/.dotfiles/nvim/.config/nvim/init.lua`
- [ ] No syntax errors: `nvim --headless -c "lua vim.cmd('source ~/.config/nvim/init.lua')" -c "quit" 2>&1 | grep -i error`
- [ ] LSP attach autocmd still works: `nvim --headless -c "lua print('LSP OK')" -c "quit"`

#### Manual Verification:
- [ ] Open a TypeScript/JavaScript file with messy imports in Neovim
- [ ] Ensure LSP is attached (`:LspInfo` shows active client)
- [ ] Press `<leader>oi` → imports should be organized and sorted
- [ ] Test with a Go file → unused imports removed, remaining sorted
- [ ] Test with a Python file → imports organized (if LSP supports it)
- [ ] Verify which-key shows `[O]rganize [I]mports` hint when pressing `<leader>o`

**Implementation Note**: After automated verification passes, test organize imports functionality with TypeScript/JavaScript files where ts_ls LSP is active. If LSP doesn't support organize imports for a language, the command should fail gracefully with a message.

---

## Testing Strategy

### Unit Tests:
N/A - Configuration changes don't require unit tests

### Integration Tests:
- Each phase has specific automated verification commands
- All three editors should be tested in parallel for muscle memory verification

### Manual Testing Steps:

#### Multicursor Testing (Neovim):
1. Open a file with repeated words (e.g., `function`)
2. Place cursor on "function"
3. Press `<C-g>` → first occurrence selected
4. Press `<C-g>` again → second occurrence selected
5. Press `<C-g>` again → third occurrence selected
6. Type to edit all occurrences simultaneously
7. Press `<Esc>` to exit multicursor mode
8. Repeat in visual mode (select text, then `<C-g>`)

#### Format Key Testing (All Editors):
1. **Neovim**: Open messy Lua file → `<leader>f` → formatted
2. **IdeaVim**: Open messy Java file → `<leader>f` → formatted
3. **Cursor**: Open messy TypeScript file → `<leader>f` → formatted
4. Ensure consistent muscle memory across all editors

#### Organize Imports Testing (All Editors):
1. **Neovim**: Open TypeScript with messy imports → `<leader>oi` → organized
2. **IdeaVim**: Open Java with unused imports → `<leader>oi` → organized
3. **Cursor**: Open TypeScript with messy imports → `<leader>oi` → organized

### Edge Cases to Test:
- Multicursor with special characters
- Multicursor in visual block mode
- Format on files with syntax errors (should handle gracefully)
- Organize imports when no LSP is attached (should show message)
- Organize imports when language doesn't support it

## Performance Considerations

- Multicursor plugin uses Hydra for sub-modes → minimal performance impact
- Format operations are async in Neovim (via conform.nvim) → no blocking
- Organize imports via LSP may be slow for large files → acceptable trade-off

## Migration Notes

### Rollback Plan:
If issues arise, revert changes in reverse order:
1. Remove `<leader>oi` from Neovim init.lua
2. Revert IdeaVim and Cursor format keys to `<leader><leader>`
3. Uninstall multicursor plugins (`:Lazy clean` in Neovim)

### Backup:
Before starting, Git status shows:
```
M nvim/.config/nvim/init.lua
M ideavim/.ideavimrc
M cursor/settings.json
```

Create a backup commit before making changes.

## References

- Original research: `thoughts/shared/research/2025-11-11-vim-config-comparison.md`
- Multicursor plugin: https://github.com/smoka7/multicursors.nvim
- Hydra plugin: https://github.com/nvimtools/hydra.nvim
- Neovim LSP code actions: `:help vim.lsp.buf.code_action()`
- Conform.nvim: https://github.com/stevearc/conform.nvim

## Post-Implementation

### Documentation Updates:
- Update CLAUDE.md to reflect `<leader>f` standardization
- Document `<leader>oi` availability in all editors
- Note that multicursor requires `:Lazy sync` after fresh Neovim install

### Follow-up Tasks:
- Consider adding `<leader>wv/wh/ww/wa` window management to Neovim (separate ticket)
- Investigate `<leader>gy` vs `<leader>D` type definition harmonization (separate ticket)
- Add snippet synchronization across editors (future enhancement)
