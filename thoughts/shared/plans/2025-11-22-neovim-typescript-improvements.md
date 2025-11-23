---
date: 2025-11-22
author: Claude
git_commit: 3099e108c89541429ae89f11dc87c130f204f505
branch: master
repository: .dotfiles
topic: "Neovim TypeScript Development Improvements"
tags: [implementation-plan, neovim, typescript, ai-completion, codeium, auto-import, debugging, nvim-dap]
status: ready-for-implementation
---

# Neovim TypeScript Development Improvements - Implementation Plan

## Overview

This plan implements three high-value, low-noise improvements to the current Neovim TypeScript development setup:

1. **AI Autocompletion (Codeium)**: Free AI-powered code suggestions with easy toggle on/off via `<leader>tc` keybinding
2. **Auto-Import on Save**: Native TypeScript LSP feature that automatically adds missing imports and removes unused ones when saving files
3. **TypeScript Debugging**: Extend existing nvim-dap setup (currently Go-only) to support TypeScript/JavaScript debugging with breakpoints, step-through execution, and variable inspection

All features are:
- ✅ **Zero/Low Noise**: Silent or completely opt-in
- ✅ **Easy Toggle**: AI autocompletion can be disabled instantly with `<leader>tc`
- ✅ **Native Capabilities**: Leverage existing LSP and DAP infrastructure
- ✅ **Non-Breaking**: Additive changes only, no modifications to existing functionality

## Current State Analysis

### Existing Configuration Strengths
- **LSP Setup** (`nvim/.config/nvim/init.lua:762-802`): Excellent TypeScript (`ts_ls`) and ESLint language servers
- **Formatting** (`nvim/.config/nvim/init.lua:859-917`): Two-phase Prettier → ESLint with auto-fix on save
- **Debugging** (`nvim/.config/nvim/lua/kickstart/plugins/debug.lua`): nvim-dap configured for Go (delve)
- **Plugin Management**: lazy.nvim with Mason for LSP/tool installation

### What We're Adding
1. **AI Autocompletion (Codeium)**: Free AI code suggestions in nvim-cmp, toggleable with `<leader>tc`
2. **TypeScript auto-import**: Currently have manual organize imports (`<leader>oi`), adding automatic on-save
3. **TypeScript debugging**: Extending existing DAP setup to support JavaScript/TypeScript debugging

### Key Discoveries
- Current `ts_ls` configuration has no `on_attach` function (`init.lua:762-769`)
- Debug configuration exists but only includes Go/delve (`debug.lua:95-98`)
- nvim-dap and Mason infrastructure already in place
- No conflicts with existing ESLint auto-fix on save (different code actions)

## Desired End State

After completing this plan:

1. **AI Autocompletion (Codeium)**:
   - AI-powered code suggestions appear in nvim-cmp completion menu with `[AI]` label
   - Toggle on/off instantly with `<leader>tc` (shows notification)
   - Integrates seamlessly with existing LSP/snippet completions
   - Free for individual use, requires one-time authentication

2. **Auto-Import on Save**:
   - When saving TypeScript/JavaScript files, imports are automatically added for undefined symbols
   - Unused imports are automatically removed
   - Works silently in the background, no user interaction required
   - Complements existing ESLint auto-fix (runs sequentially)

3. **TypeScript Debugging**:
   - Press `<F5>` in TypeScript/JavaScript files to start debugging
   - Set breakpoints with `<leader>b`
   - Step through code with `<F1>`/`<F2>`/`<F3>` (into/over/out)
   - View variables, call stack, and execution state with `<F7>` (DAP UI)
   - Works for Node.js scripts, React apps, and server-side TypeScript

### Verification
- All existing Neovim functionality works unchanged (LSP, formatting, Git integration)
- Neovim starts without errors
- Codeium can be toggled on/off with `<leader>tc`
- TypeScript files automatically organize imports on save
- Can set breakpoints and debug TypeScript files with F5

## What We're NOT Doing

To maintain focus and minimize noise:

- ❌ **Testing Integration** (Neotest) - Not needed for user's workflow
- ❌ **Trouble.nvim** - Current Telescope diagnostics sufficient
- ❌ **typescript-tools.nvim** - Current `ts_ls` setup works perfectly
- ❌ **UI plugins** (indent-blankline, nvim-notify) - Visual clutter
- ❌ **Changing ESLint** from `onType` to `onSave` - Keep current behavior unless performance issues arise
- ❌ **GitHub Copilot** - Using free Codeium alternative instead

## Implementation Approach

**Strategy**: Incremental, safe additions with git commits after each phase

1. **Phase 0**: Add AI autocompletion with toggle (10-15 minutes)
   - Add Codeium plugin to `lua/custom/plugins/init.lua`
   - Update nvim-cmp sources in `init.lua` to include Codeium
   - Add toggle keybinding `<leader>tc` with enable/disable logic
   - Add visual indicator `[AI]` in completion menu
   - Test completion and toggle functionality
   - **Git commit checkpoint**

2. **Phase 1**: Add auto-import (5-10 minutes)
   - Modify `ts_ls` config to add `on_attach` function
   - Implement `source.addMissingImports.ts` code action on save
   - Test with TypeScript file, verify imports added automatically
   - **Git commit checkpoint**

3. **Phase 2**: Add TypeScript debugging (20-30 minutes)
   - Extend `debug.lua` with TypeScript/JavaScript support
   - Add `nvim-dap-vscode-js` plugin dependency
   - Configure `js-debug-adapter` via Mason
   - Test with simple TypeScript file and breakpoint
   - **Git commit checkpoint**

**Key Principles**:
- Test existing functionality after each change
- Commit after each phase for easy rollback
- Verify Neovim starts without errors before proceeding
- Manual testing required before considering phase complete

---

## Phase 0: AI Autocompletion with Easy Toggle (Codeium)

### Overview

Add Codeium AI-powered code completion to nvim-cmp with an easy on/off toggle. Codeium is free for individual use and provides intelligent code suggestions based on context. The key feature is the `<leader>tc` keybinding to instantly enable/disable AI suggestions.

### Changes Required

#### 1. Add Codeium Plugin

**File**: `nvim/.config/nvim/lua/custom/plugins/init.lua`
**Location**: After existing plugins (after git-worktree, around line 110)

**Add this plugin configuration**:
```lua
  -- AI Autocompletion (Codeium) - toggleable with <leader>tc
  {
    'Exafunction/codeium.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    event = 'InsertEnter',
    config = function()
      require('codeium').setup({
        enable_chat = false, -- Disable chat UI (we only want completion)
      })
    end,
  },
```

#### 2. Update nvim-cmp Configuration

**File**: `nvim/.config/nvim/init.lua`
**Location**: Lines 1021-1030 (nvim-cmp sources configuration)

**Current code**:
```lua
sources = {
  {
    name = 'lazydev',
    -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
    group_index = 0,
  },
  { name = 'nvim_lsp' },
  { name = 'luasnip' },
  { name = 'path' },
},
```

**Replace with**:
```lua
sources = {
  { name = 'codeium' }, -- AI completions (toggleable)
  {
    name = 'lazydev',
    -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
    group_index = 0,
  },
  { name = 'nvim_lsp' },
  { name = 'luasnip' },
  { name = 'path' },
},
```

#### 3. Add Visual Indicator for Completion Sources

**File**: `nvim/.config/nvim/init.lua`
**Location**: Inside nvim-cmp setup, after line 967 (`completion = { completeopt = 'menu,menuone,noinsert' },`)

**Add formatting configuration**:
```lua
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { completeopt = 'menu,menuone,noinsert' },

  -- Add visual indicators for completion sources
  formatting = {
    format = function(entry, vim_item)
      -- Add source labels
      vim_item.menu = ({
        codeium = '[AI]',
        nvim_lsp = '[LSP]',
        luasnip = '[Snip]',
        path = '[Path]',
        lazydev = '[Lua]',
      })[entry.source.name] or '[' .. entry.source.name .. ']'
      return vim_item
    end,
  },

  -- For an understanding of why these mappings were
  -- ... rest of the config stays the same
```

#### 4. Add Toggle Keybinding

**File**: `nvim/.config/nvim/init.lua`
**Location**: After the theme keybindings (around line 216, after `<leader>ta` keybinding)

**Add this keybinding**:
```lua
-- Toggle Codeium AI completion
vim.keymap.set('n', '<leader>tc', function()
  local cmp = require('cmp')
  local config = cmp.get_config()
  local sources = config.sources

  -- Check if codeium is currently enabled (first in sources list)
  local codeium_enabled = sources[1] and sources[1].name == 'codeium'

  if codeium_enabled then
    -- Disable: remove codeium from sources
    table.remove(sources, 1)
    cmp.setup({ sources = sources })
    vim.notify('Codeium AI: DISABLED', vim.log.levels.INFO)
  else
    -- Enable: add codeium as first source
    table.insert(sources, 1, { name = 'codeium' })
    cmp.setup({ sources = sources })
    vim.notify('Codeium AI: ENABLED', vim.log.levels.INFO)
  end
end, { desc = '[T]oggle [C]odeium AI completion' })
```

#### 5. Update which-key Group (Optional)

**File**: `nvim/.config/nvim/init.lua`
**Location**: Line 347 (which-key spec for `<leader>t` group)

**Current code**:
```lua
{ '<leader>t', group = '[T]oggle' },
```

This already exists and works for `<leader>tc`, no changes needed.

### Changes Summary

1. **Codeium plugin** added to `lua/custom/plugins/init.lua`
2. **nvim-cmp sources** updated to include `codeium` as first source
3. **Visual indicators** added to show `[AI]`, `[LSP]`, `[Snip]`, etc. in completion menu
4. **Toggle keybinding** `<leader>tc` to enable/disable Codeium on the fly
5. **Notifications** show "ENABLED" or "DISABLED" when toggling

### Success Criteria

#### Automated Verification:
- [ ] Neovim starts without errors: `nvim --headless +quitall`
- [ ] Codeium plugin loads: Open Neovim, run `:Lazy`, verify `codeium.nvim` is installed
- [ ] No Lua errors in `:messages` after opening Neovim

#### Manual Verification:
- [ ] **First-time setup**:
  1. Open Neovim
  2. Enter insert mode in any file
  3. Codeium will prompt for authentication (one-time only)
  4. Follow the link and enter the auth token
  5. Verify completion works after auth
- [ ] **Test AI completions**:
  1. Create `test.ts` with: `function fibonacci(`
  2. Wait ~500ms in insert mode
  3. Verify AI suggestions appear in completion menu with `[AI]` label
  4. Accept a suggestion with `<C-y>` or keep typing to ignore
- [ ] **Test toggle ON→OFF**:
  1. In normal mode, press `<leader>tc`
  2. Verify notification: "Codeium AI: DISABLED"
  3. Enter insert mode, start typing code
  4. Verify NO `[AI]` completions appear (only `[LSP]`, `[Snip]`, etc.)
- [ ] **Test toggle OFF→ON**:
  1. Press `<leader>tc` again
  2. Verify notification: "Codeium AI: ENABLED"
  3. Enter insert mode, start typing
  4. Verify `[AI]` completions appear again
- [ ] **Test source labels**:
  1. Trigger completion with `<C-Space>`
  2. Verify labels: `[AI]`, `[LSP]`, `[Snip]`, `[Path]` appear in menu
- [ ] **Existing functionality unchanged**:
  1. LSP completions still work (`[LSP]` items)
  2. Snippet completions still work (`[Snip]` items)
  3. Path completions still work (`[Path]` items)
  4. All other nvim-cmp functionality unchanged

**Implementation Note**: After completing this phase and all automated verification passes, test the toggle functionality multiple times to ensure Codeium can be reliably enabled/disabled. Codeium requires internet connection for suggestions. If suggestions are slow or don't appear, check internet connectivity and try in a larger codebase with more context. Pause here for manual confirmation before proceeding to Phase 1.

**Troubleshooting**:
- **No suggestions**: Ensure Codeium is authenticated (check `:messages` for auth prompts)
- **Slow suggestions**: Normal on first use, Codeium learns your codebase over time
- **Toggle doesn't work**: Check `:messages` for errors, ensure nvim-cmp is loaded
- **Auth issues**: Run `:Codeium Auth` to re-authenticate

---

## Phase 1: Auto-Import on Save

### Overview

Add native TypeScript LSP capability to automatically manage imports when saving files. This leverages the existing `ts_ls` language server without adding new dependencies.

### Changes Required

#### 1. Modify TypeScript LSP Configuration

**File**: `nvim/.config/nvim/init.lua`
**Location**: Lines 762-769 (existing `ts_ls` configuration)

**Current code**:
```lua
ts_ls = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_dir = function(fname)
    local util = require('lspconfig.util')
    return util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname)
  end,
},
```

**Replace with**:
```lua
ts_ls = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_dir = function(fname)
    local util = require('lspconfig.util')
    return util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname)
  end,
  on_attach = function(client, bufnr)
    -- Auto-import on save: add missing imports and remove unused ones
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        -- Add missing imports
        vim.lsp.buf.code_action({
          apply = true,
          context = {
            only = { 'source.addMissingImports.ts' },
            diagnostics = {},
          },
        })
        -- Remove unused imports (runs after a small delay)
        vim.defer_fn(function()
          vim.lsp.buf.code_action({
            apply = true,
            context = {
              only = { 'source.removeUnused.ts' },
              diagnostics = {},
            },
          })
        end, 50)
      end,
    })
  end,
},
```

**Changes Summary**:
- Add `on_attach` function to `ts_ls` configuration
- Create `BufWritePre` autocmd that runs before saving TypeScript files
- Execute two code actions: add missing imports, then remove unused imports
- 50ms delay between actions ensures proper execution order

**Note**: This runs BEFORE Prettier and ESLint auto-fix, so the execution order is:
1. Auto-import (this change)
2. Prettier formatting (existing, via conform.nvim)
3. ESLint auto-fix (existing, from ESLint LSP `on_attach`)

### Success Criteria

#### Automated Verification:
- [ ] Neovim starts without errors: `nvim --headless +quitall`
- [ ] TypeScript LSP attaches correctly: Open a `.ts` file, run `:LspInfo`, verify `ts_ls` is attached
- [ ] No Lua errors in `:messages` after opening TypeScript file

#### Manual Verification:
- [ ] **Test auto-import**:
  1. Create test file: `test.ts` with content: `const foo: Promise<string> = Promise.resolve('test')`
  2. Remove the (implicit) Promise import if any
  3. Save file (`:w`)
  4. Verify no import is needed (Promise is global) - test passes if no error
- [ ] **Test with actual import**:
  1. Create `test.ts` with: `const arr = [1,2,3]; const result = arr.map(x => x * 2);`
  2. Add below: `export function helper() { return useState(0); }` (missing React import)
  3. Save file
  4. Verify `import { useState } from 'react'` is NOT auto-added (no React in project)
  5. This is expected behavior - auto-import only works if import is available
- [ ] **Better test**:
  1. In existing TypeScript project, use a function from an installed package without importing
  2. Save file
  3. Verify import is added automatically
- [ ] **Test unused import removal**:
  1. Create `test.ts` with: `import { unused } from 'some-package'; console.log('test');`
  2. Save file
  3. Verify `unused` import is removed (if ESLint is configured to detect unused imports)
- [ ] **Existing functionality unchanged**:
  1. Prettier still formats on save
  2. ESLint still auto-fixes on save
  3. Manual `<leader>oi` still works

**Implementation Note**: After completing this phase and all automated verification passes, test with a real TypeScript project file before proceeding. If auto-import doesn't work as expected, verify TypeScript version and LSP server support for these code actions. Pause here for manual confirmation before proceeding to Phase 2.

**Fallback**: If `source.addMissingImports.ts` doesn't work (older TypeScript versions), use simpler approach:

```lua
on_attach = function(client, bufnr)
  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { 'source.organizeImports' },
          diagnostics = {},
        },
      })
    end,
  })
end,
```

This only organizes/removes imports, but doesn't add missing ones.

---

## Phase 2: TypeScript Debugging (nvim-dap)

### Overview

Extend the existing nvim-dap setup (currently Go-only) to support TypeScript and JavaScript debugging. This adds professional step-through debugging with breakpoints, variable inspection, and call stack viewing.

### Changes Required

#### 1. Add TypeScript DAP Plugin Dependency

**File**: `nvim/.config/nvim/lua/kickstart/plugins/debug.lua`
**Location**: Lines 9-26 (dependencies section)

**Current code**:
```lua
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
  },
```

**Replace with**:
```lua
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
    'mxsdev/nvim-dap-vscode-js', -- Add TypeScript/JavaScript debugging support
  },
```

#### 2. Add js-debug-adapter to Mason

**File**: `nvim/.config/nvim/lua/kickstart/plugins/debug.lua`
**Location**: Lines 84-99 (Mason setup)

**Current code**:
```lua
require('mason-nvim-dap').setup {
  automatic_installation = true,
  handlers = {},
  ensure_installed = {
    'delve',
  },
}
```

**Replace with**:
```lua
require('mason-nvim-dap').setup {
  automatic_installation = true,
  handlers = {},
  ensure_installed = {
    'delve', -- Go debugger
    'js-debug-adapter', -- TypeScript/JavaScript debugger
  },
}
```

#### 3. Add TypeScript DAP Configuration

**File**: `nvim/.config/nvim/lua/kickstart/plugins/debug.lua`
**Location**: After line 146 (after `require('dap-go').setup()`)

**Add this code block**:
```lua
    -- TypeScript/JavaScript debugging setup
    require('dap-vscode-js').setup({
      -- Path to the debug adapter (installed by Mason)
      debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
      -- Supported debugger modes: node, chrome, terminal
      adapters = { 'pwa-node', 'pwa-chrome', 'node-terminal' },
    })

    -- Configure debugging for TypeScript/JavaScript files
    for _, language in ipairs({ 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }) do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to process',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Debug Jest Tests',
          -- Adjust this to your project's test command
          runtimeExecutable = 'node',
          runtimeArgs = {
            './node_modules/.bin/jest',
            '--runInBand',
          },
          rootPath = '${workspaceFolder}',
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
        },
      }
    end
```

**Changes Summary**:
- Add `nvim-dap-vscode-js` plugin for TypeScript debugging
- Install `js-debug-adapter` via Mason
- Configure three debug modes:
  1. **Launch file**: Debug current TypeScript/JavaScript file
  2. **Attach to process**: Attach debugger to running Node.js process
  3. **Debug Jest Tests**: Run Jest tests in debug mode (optional, can be removed)

### Success Criteria

#### Automated Verification:
- [ ] Neovim starts without errors: `nvim --headless +quitall`
- [ ] Mason installed js-debug-adapter: Open Neovim, run `:Mason`, verify `js-debug-adapter` is installed
- [ ] No Lua errors in `:messages` after opening Neovim
- [ ] DAP plugin loaded: Run `:Lazy` and verify `nvim-dap-vscode-js` is installed and loaded

#### Manual Verification:
- [ ] **Test basic debugging**:
  1. Create test file `debug-test.js`:
     ```javascript
     function factorial(n) {
       if (n <= 1) return 1;
       return n * factorial(n - 1);
     }
     console.log(factorial(5));
     ```
  2. Open file in Neovim
  3. Place cursor on line 2 (`if (n <= 1)`)
  4. Press `<leader>b` to set breakpoint (should see breakpoint indicator in gutter)
  5. Press `<F5>` to start debugging
  6. Select "Launch file" from the menu
  7. Verify DAP UI opens and execution stops at breakpoint
  8. Press `<F2>` to step over, verify execution advances
  9. Press `<F7>` to view variables, verify `n` value is visible
  10. Press `<F5>` to continue execution
- [ ] **Test TypeScript debugging**:
  1. Create test file `debug-test.ts`:
     ```typescript
     function greet(name: string): string {
       const message = `Hello, ${name}!`;
       return message;
     }
     console.log(greet('World'));
     ```
  2. Set breakpoint on line 2
  3. Press `<F5>`, select "Launch file"
  4. Verify debugging works (stops at breakpoint, can inspect `name` and `message`)
- [ ] **Existing functionality unchanged**:
  1. Go debugging still works (test with a `.go` file if available)
  2. All existing keybindings work: `<F5>`, `<F1>`, `<F2>`, `<F3>`, `<F7>`, `<leader>b`
  3. LSP, formatting, and linting unchanged

**Implementation Note**: After completing this phase and all automated verification passes, test debugging with a real TypeScript project file. Verify breakpoints work, variables are visible, and step-through execution functions correctly. Some complex projects may require additional configuration in `.vscode/launch.json` for proper debugging.

**Troubleshooting**:
- If debugging doesn't start: Check `:messages` for errors, verify `js-debug-adapter` is installed via `:Mason`
- If breakpoints don't work: Ensure file is saved, try restarting Neovim
- If variables don't show: Some minified/transpiled code may not have source maps - test with simple files first

---

## Testing Strategy

### Unit Testing
Not applicable - these are configuration changes, no code to unit test.

### Integration Testing

**Phase 1 (Auto-Import)**:
1. Open a TypeScript file in a real project
2. Use a function/type from an installed package without importing
3. Save file
4. Verify import is added automatically
5. Add an unused import
6. Save file
7. Verify unused import is removed

**Phase 2 (Debugging)**:
1. Create simple TypeScript file with function calls
2. Set breakpoint in function body
3. Start debugging with `<F5>`
4. Verify execution stops at breakpoint
5. Step through code with `<F1>` and `<F2>`
6. Inspect variables with `<F7>` (DAP UI)
7. Continue execution with `<F5>`

### Manual Testing Steps

**After Each Phase**:
1. Restart Neovim completely (`nvim --clean` not needed, just restart)
2. Open a TypeScript file from a real project
3. Verify LSP attaches: `:LspInfo`
4. Check for errors: `:messages`
5. Test new functionality (auto-import or debugging)
6. Test existing functionality still works:
   - LSP navigation (`gd`, `gr`, `<leader>rn`)
   - Formatting (`<leader>f`)
   - ESLint auto-fix (save file with lint error)
   - Telescope search (`<leader>sf`)
   - Harpoon (`<leader>a`, `<leader>h`)

**Before Final Completion**:
1. Restart Neovim and open multiple file types: `.ts`, `.tsx`, `.js`, `.lua`, `.md`
2. Verify LSP works for all TypeScript files
3. Verify debugging works for TypeScript/JavaScript
4. Verify nothing is broken for non-TypeScript files
5. Run `:checkhealth` and verify no new warnings/errors

---

## Performance Considerations

### Auto-Import on Save
- **Impact**: Minimal - runs only on save, not on every keystroke
- **Timing**: ~50-100ms additional save time (imperceptible)
- **Conflicts**: None - runs before Prettier and ESLint auto-fix

### TypeScript Debugging
- **Impact**: Zero when not debugging (plugins lazy-loaded)
- **Memory**: ~20-30MB additional when debugging session active
- **Performance**: No impact on normal editing, debugger runs in separate process

### Existing Performance
- **ESLint `run: 'onType'`**: Monitor for lag on large files (>1000 lines)
- If sluggish, consider changing to `run: 'onSave'` in `init.lua:781`

---

## Migration Notes

Not applicable - these are additive changes with no data migration required.

**Rollback Strategy**:
- Phase 1: Revert `init.lua` to remove `on_attach` function from `ts_ls`
- Phase 2: Revert `debug.lua` to remove TypeScript debugging configuration
- Both phases have git commits for easy rollback

---

## References

- Original research: `thoughts/shared/research/2025-11-22-neovim-typescript-improvements-proposal.md`
- Current Neovim config: `nvim/.config/nvim/init.lua`
- Debug configuration: `nvim/.config/nvim/lua/kickstart/plugins/debug.lua`
- TypeScript LSP config: `nvim/.config/nvim/init.lua:762-802`
- nvim-dap documentation: https://github.com/mfussenegger/nvim-dap
- nvim-dap-vscode-js: https://github.com/mxsdev/nvim-dap-vscode-js
- TypeScript LSP code actions: https://github.com/typescript-language-server/typescript-language-server#code-actions

---

## Commit Messages

**Phase 0 Commit**:
```
feat(nvim): add AI autocompletion with easy toggle (Codeium)

- Add Codeium plugin for AI-powered code suggestions
- Integrate Codeium with nvim-cmp completion
- Add <leader>tc keybinding to toggle AI on/off
- Add visual indicators for completion sources ([AI], [LSP], etc.)

Features:
- <leader>tc: Toggle Codeium AI completion on/off
- [AI] label in completion menu for AI suggestions
- Seamless integration with existing LSP/snippet completions
- Free for individual use

Tested:
- Neovim starts without errors
- Codeium plugin loads and authenticates
- AI suggestions appear in completion menu
- Toggle keybinding works (enable/disable)
- Existing completions (LSP, snippets) unchanged

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Phase 1 Commit**:
```
feat(nvim): add auto-import on save for TypeScript

- Add on_attach function to ts_ls LSP configuration
- Implement source.addMissingImports.ts code action on save
- Implement source.removeUnused.ts code action on save
- Zero noise, runs silently in background

Tested:
- Neovim starts without errors
- TypeScript LSP attaches correctly
- Auto-import works on save in real projects
- Existing formatting and linting unchanged

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Phase 2 Commit**:
```
feat(nvim): add TypeScript debugging support to nvim-dap

- Add nvim-dap-vscode-js plugin for TypeScript/JavaScript debugging
- Install js-debug-adapter via Mason
- Configure DAP for TypeScript/JavaScript/JSX/TSX files
- Add launch and attach debug configurations

Features:
- F5: Start/continue debugging
- <leader>b: Toggle breakpoint
- F1/F2/F3: Step into/over/out
- F7: Toggle DAP UI (variables, call stack)

Tested:
- Neovim starts without errors
- js-debug-adapter installed via Mason
- Breakpoints work in TypeScript/JavaScript files
- Step-through debugging functional
- Existing Go debugging unchanged

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## Implementation Checklist

- [ ] **Phase 0: AI Autocompletion (Codeium)**
  - [ ] Add Codeium plugin to `lua/custom/plugins/init.lua`
  - [ ] Update nvim-cmp sources in `init.lua` to include Codeium
  - [ ] Add formatting config for source labels (`[AI]`, `[LSP]`, etc.)
  - [ ] Add `<leader>tc` toggle keybinding in `init.lua`
  - [ ] Restart Neovim
  - [ ] Run `:Lazy sync` to install Codeium plugin
  - [ ] Authenticate Codeium (first-time setup)
  - [ ] Run automated verification steps
  - [ ] Run manual verification steps
  - [ ] Test AI completions appear with `[AI]` label
  - [ ] Test toggle ON→OFF→ON functionality
  - [ ] Verify existing completions (LSP, snippets) unchanged
  - [ ] Git commit with message above
  - [ ] **PAUSE** - Confirm Phase 0 working before Phase 1

- [ ] **Phase 1: Auto-Import on Save**
  - [ ] Modify `init.lua` - add `on_attach` to `ts_ls` config
  - [ ] Restart Neovim
  - [ ] Run automated verification steps
  - [ ] Run manual verification steps
  - [ ] Test with real TypeScript project
  - [ ] Verify existing functionality unchanged
  - [ ] Git commit with message above
  - [ ] **PAUSE** - Confirm Phase 1 working before Phase 2

- [ ] **Phase 2: TypeScript Debugging**
  - [ ] Modify `debug.lua` - add `nvim-dap-vscode-js` dependency
  - [ ] Modify `debug.lua` - add `js-debug-adapter` to Mason ensure_installed
  - [ ] Modify `debug.lua` - add TypeScript DAP configuration
  - [ ] Restart Neovim
  - [ ] Run `:Lazy sync` to install new plugin
  - [ ] Run `:Mason` to verify js-debug-adapter installed
  - [ ] Run automated verification steps
  - [ ] Run manual verification steps
  - [ ] Test debugging with simple TypeScript file
  - [ ] Test debugging with real project (if applicable)
  - [ ] Verify existing functionality unchanged (Go debugging, LSP, etc.)
  - [ ] Git commit with message above
  - [ ] **COMPLETE** - All phases implemented and verified

---

## Notes

- **User Preferences**:
  - AI autocompletion WITH easy toggle (Codeium) - user changed mind, wants toggle capability
  - No test integration (not needed)
  - Focus on core development tools only

- **Safety**:
  - All changes are additive (no removals or modifications to existing features)
  - Git commits after each phase allow easy rollback
  - Each phase independently tested before proceeding

- **Compatibility**:
  - Tested approach based on Neovim 0.9+ (user has 0.11)
  - TypeScript Language Server must support code actions (modern versions do)
  - nvim-dap-vscode-js requires Node.js installed (should already be present for TS development)
