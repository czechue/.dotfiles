---
date: 2025-11-22
researcher: Claude
git_commit: 3099e108c89541429ae89f11dc87c130f204f505
branch: master
repository: .dotfiles
topic: "Neovim TypeScript Development Setup - Improvement Proposals"
tags: [research, neovim, typescript, improvements, ai-completion, debugging, testing, critical-analysis]
status: complete
last_updated: 2025-11-22
last_updated_by: Claude
---

# Neovim TypeScript Development Setup - Critical Analysis & Improvement Proposals

**Date**: 2025-11-22
**Researcher**: Claude
**Based on**: Current config analysis + Modern Neovim TS ecosystem research (2024-2025)

## Executive Summary

Your current Neovim TypeScript setup is **solid and well-configured**, with proper LSP, formatting (Prettier), and linting (ESLint) integration. However, there are several modern enhancements that could significantly improve productivity without adding noise:

**Key Recommendations:**
1. ✅ **ADD**: AI-powered autocompletion (Codeium or Copilot) - High impact, low noise
2. ✅ **ADD**: Auto-import on save for TypeScript - Native LSP capability, zero noise
3. ✅ **ADD**: TypeScript debugging via nvim-dap - Professional-grade debugging
4. ✅ **ADD**: Testing integration (Neotest) - Run tests without leaving editor
5. ⚠️ **CONSIDER**: typescript-tools.nvim - More features, but may be overkill
6. ❌ **SKIP**: nvim-lint for JS/TS - You already use ESLint LSP (better)
7. ⚠️ **CONSIDER**: Trouble.nvim - Better diagnostics UI, but check if needed
8. ⚠️ **CONSIDER**: nvim-bqf - Enhanced quickfix, but Telescope may be enough

## Current Setup Analysis

### ✅ What's Working Well

1. **LSP Configuration** (`init.lua:762-802`)
   - TypeScript Language Server (`ts_ls`) for IntelliSense and type checking
   - ESLint Language Server with real-time linting (`run: 'onType'`)
   - Proper monorepo support (`workingDirectory.mode: 'auto'`)
   - Auto-fix on save for ESLint
   - **VERDICT**: Excellent setup, no changes needed

2. **Formatting Setup** (`init.lua:859-917`)
   - conform.nvim with Prettier
   - Two-phase formatting: Prettier → ESLint auto-fix
   - 500ms timeout prevents hanging
   - Format on save + manual `<leader>f`
   - **VERDICT**: Well-designed, smart approach

3. **Code Navigation** (`init.lua:613-651`)
   - Telescope integration for LSP navigation
   - All essential LSP keymaps configured
   - Organize imports available (`<leader>oi`)
   - **VERDICT**: Complete and ergonomic

4. **Plugin Ecosystem**
   - Harpoon 2 for quick file switching
   - LazyGit integration
   - Neo-tree file explorer
   - Render-markdown for documentation
   - **VERDICT**: Good productivity plugins

### ⚠️ What's Missing (High Value)

1. **No AI-Powered Autocompletion**
   - Modern TS development heavily relies on AI suggestions
   - Can reduce boilerplate typing by 30-50%
   - **Impact**: HIGH | **Noise**: LOW (suggestions are contextual)

2. **No Auto-Import on Save**
   - You have organize imports (`<leader>oi`), but not automatic
   - Native TypeScript LSP supports `source.addMissingImports.ts`
   - **Impact**: MEDIUM | **Noise**: ZERO (silent, on-save only)

3. **No Debugging Setup**
   - `debug.lua` exists but configured for Go only
   - TypeScript debugging requires `js-debug-adapter`
   - **Impact**: HIGH (for complex bugs) | **Noise**: ZERO (opt-in)

4. **No Testing Integration**
   - Running tests requires terminal switching
   - Neotest provides in-editor test running with visual feedback
   - **Impact**: MEDIUM | **Noise**: LOW (opt-in, keybind-based)

### 🤔 Potential Issues & Noise Sources

1. **Double ESLint Fix** (`init.lua:791-801`, `init.lua:874-880`)
   - ESLint auto-fix runs on save AND on manual format
   - **Analysis**: This is intentional redundancy - not a bug
   - **Verdict**: Keep as-is, ensures fixes always apply

2. **Real-Time ESLint** (`run: 'onType'`)
   - Lints on every keystroke, may cause performance issues on large files
   - **Analysis**: Modern approach, but consider `run: 'onSave'` if slow
   - **Verdict**: Monitor performance, switch if needed

3. **Prettier Not in Mason** (`init.lua:835-837`)
   - Prettier not auto-installed, relies on project-local version
   - **Analysis**: Intentional - uses project's Prettier version
   - **Verdict**: Correct approach for consistency across team

4. **No Inlay Hints by Default** (`init.lua:690-694`)
   - TypeScript inlay hints available but require `<leader>th` toggle
   - **Analysis**: Reasonable - inlay hints can be distracting
   - **Verdict**: Keep as toggle, don't enable by default

5. **friendly-snippets Commented Out** (`init.lua:939-944`)
   - Pre-made snippets disabled
   - **Analysis**: Reduces clutter, encourages custom snippets
   - **Verdict**: Good decision for minimal setup

## Detailed Recommendations

---

### 1. ✅ ADD: AI-Powered Autocompletion

**Recommendation**: Add **Codeium** (free, fast) or **GitHub Copilot** (paid, best quality)

#### Why Codeium Over Copilot?
- **Free forever** for individuals
- **Fast**: Low-latency suggestions (~50-100ms)
- **Privacy**: Improving privacy features (not as strict as Tabnine)
- **70+ languages** including TypeScript, TSX
- **Neovim plugin**: Official `codeium.vim` or `cmp-codeium` for nvim-cmp integration

#### Why NOT Tabnine?
- Limited free tier (vs. Codeium's generous free tier)
- Smaller community and plugin ecosystem
- Privacy-first is great, but only matters if you handle sensitive code

#### Implementation (cmp-codeium)

**Advantages of cmp-codeium**:
- Integrates with your existing nvim-cmp setup
- Consistent UI with other completion sources
- No new keybindings to learn
- Works alongside LSP completions

**Add to `init.lua` or `lua/custom/plugins/init.lua`:**

```lua
{
  'Exafunction/codeium.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  event = 'InsertEnter',
  config = function()
    require('codeium').setup({})
  end,
}
```

**Update nvim-cmp sources** (`init.lua:1021-1030`):

```lua
sources = {
  { name = 'codeium', priority = 1000 }, -- Add this
  {
    name = 'lazydev',
    group_index = 0,
  },
  { name = 'nvim_lsp' },
  { name = 'luasnip' },
  { name = 'path' },
},
```

**Optional: Add visual indicator** (shows AI icon in completion menu):

```lua
-- In nvim-cmp setup, add formatting
formatting = {
  format = function(entry, vim_item)
    vim_item.menu = ({
      codeium = '[AI]',
      nvim_lsp = '[LSP]',
      luasnip = '[Snip]',
      path = '[Path]',
    })[entry.source.name]
    return vim_item
  end,
},
```

**Noise Level**: LOW
- Suggestions appear inline (ghost text) or in completion menu
- Easy to ignore (just keep typing)
- No popups or interruptions

**Impact**: HIGH
- Reduces boilerplate code significantly
- Learns your coding patterns
- Especially useful for repetitive TypeScript patterns (interfaces, types, React components)

---

### 2. ✅ ADD: Auto-Import on Save

**Recommendation**: Add native LSP-based auto-import for TypeScript

#### Why This is Essential
- You already have organize imports (`<leader>oi`), but it's manual
- TypeScript LSP natively supports adding missing imports
- **Zero configuration**, just add an autocmd

#### Implementation

**Add to LSP `on_attach` for `ts_ls`** (`init.lua:762-769`):

```lua
ts_ls = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_dir = function(fname)
    local util = require('lspconfig.util')
    return util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname)
  end,
  on_attach = function(client, bufnr)
    -- Auto-import on save
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
        -- Remove unused imports (optional, organize imports already does this)
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

**Alternative: Simpler version (organize imports on save)**

If the above doesn't work well, just enable organize imports on save:

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

**Noise Level**: ZERO
- Runs silently on save
- Only adds imports that are actually needed
- No popups or confirmations

**Impact**: MEDIUM
- Saves manual `<leader>oi` keystrokes
- One less thing to remember
- Keeps imports clean automatically

---

### 3. ✅ ADD: TypeScript Debugging (nvim-dap)

**Recommendation**: Configure nvim-dap for TypeScript/Node.js debugging

#### Why You Need This
- You already have `debug.lua` for Go
- Professional development requires step-through debugging
- Alternative is `console.log` debugging (primitive)

#### Implementation

**Update `lua/kickstart/plugins/debug.lua`** to add TypeScript support:

```lua
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
    'mxsdev/nvim-dap-vscode-js', -- Add this for TypeScript
  },
  keys = {
    -- ... existing keys ...
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'delve', -- Go
        'js-debug-adapter', -- TypeScript/JavaScript
      },
    }

    -- ... existing dapui setup ...

    -- Install Go config (existing)
    require('dap-go').setup()

    -- Add TypeScript/Node.js configuration
    require('dap-vscode-js').setup({
      debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
      adapters = { 'pwa-node', 'pwa-chrome', 'node-terminal' },
    })

    -- Configure TypeScript debugging
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
      }
    end
  end,
}
```

**Usage**:
- `<F5>` - Start/continue debugging
- `<leader>b` - Toggle breakpoint
- `<F1>/<F2>/<F3>` - Step into/over/out
- `<F7>` - Toggle DAP UI

**Noise Level**: ZERO
- Completely opt-in (requires explicit breakpoint + `<F5>`)
- UI only appears when debugging
- No impact on normal editing

**Impact**: HIGH (for complex debugging)
- Essential for debugging async code, promises, closures
- Visual inspection of variables, call stack
- Much faster than console.log debugging

---

### 4. ✅ ADD: Testing Integration (Neotest)

**Recommendation**: Add Neotest with Jest/Vitest adapters

#### Why You Need This
- Running tests in terminal breaks flow
- Neotest provides visual feedback (pass/fail indicators)
- Run individual tests or test files without leaving editor

#### Implementation

**Add to `lua/custom/plugins/init.lua`:**

```lua
{
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'antoinemadec/FixCursorHold.nvim',
    -- Adapters (uncomment what you use)
    'nvim-neotest/neotest-jest',
    -- 'nvim-neotest/neotest-vitest',
  },
  keys = {
    { '<leader>tt', function() require('neotest').run.run() end, desc = 'Test: Run nearest' },
    { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Test: Run file' },
    { '<leader>ta', function() require('neotest').run.run(vim.fn.getcwd()) end, desc = 'Test: Run all' },
    { '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Test: Toggle summary' },
    { '<leader>to', function() require('neotest').output.open({ enter = true }) end, desc = 'Test: Show output' },
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-jest')({
          jestCommand = 'npm test --',
          jestConfigFile = 'jest.config.js',
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
        -- If using Vitest:
        -- require('neotest-vitest'),
      },
    })
  end,
}
```

**Which Adapter?**
- **Jest**: Most popular for React/Node.js projects
- **Vitest**: Modern, faster alternative (if your project uses Vite)
- Check your project's `package.json` to see which test runner you use

**Usage**:
- `<leader>tt` - Run test under cursor
- `<leader>tf` - Run all tests in current file
- `<leader>ta` - Run entire test suite
- `<leader>ts` - Toggle test summary panel

**Noise Level**: LOW
- Opt-in (requires keybinding)
- Visual indicators in gutter (small icons)
- Summary panel only when toggled

**Impact**: MEDIUM
- Faster test-driven development workflow
- Immediate visual feedback
- No more terminal switching

---

### 5. ⚠️ CONSIDER: typescript-tools.nvim

**Alternative to `ts_ls`**: More features, but potentially overkill

#### What It Offers
- All `ts_ls` features + enhanced capabilities
- Faster "organize imports" and "remove unused"
- Better inlay hints
- More TypeScript-specific commands

#### Why You Might NOT Need It
- Your current `ts_ls` setup works perfectly
- Additional features may go unused
- More configuration complexity
- "If it ain't broke, don't fix it"

#### When to Consider
- If you feel `ts_ls` is slow
- If you want more advanced TypeScript refactoring
- If you're doing heavy TypeScript development (80%+ of your work)

**Verdict**: SKIP for now, revisit if you hit limitations with `ts_ls`

---

### 6. ❌ SKIP: nvim-lint for JavaScript/TypeScript

**Recommendation**: Do NOT add nvim-lint for JS/TS

#### Why NOT
- You already use **ESLint LSP** (`init.lua:770-802`)
- ESLint LSP provides:
  - Real-time diagnostics as you type
  - Auto-fix capabilities
  - Better integration with LSP ecosystem
- nvim-lint would be redundant and slower

#### When nvim-lint is Useful
- For languages without LSP support (you use it for Markdown - correct)
- For quick linting without full LSP overhead

**Verdict**: Your current setup is optimal, don't change it

---

### 7. ⚠️ CONSIDER: Trouble.nvim

**Better diagnostics/quickfix UI**

#### What It Offers
- Unified view of LSP diagnostics, quickfix, references
- Better than default quickfix window
- Visual grouping by file and severity

#### Current Alternative
- You use Telescope for diagnostics (`<leader>sd`)
- Telescope quickfix integration

#### Comparison
- **Telescope**: Good for searching/filtering
- **Trouble**: Better for browsing/grouping

#### Implementation

```lua
{
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'Trouble',
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
    { '<leader>xq', '<cmd>Trouble quickfix toggle<cr>', desc = 'Quickfix (Trouble)' },
  },
  opts = {},
}
```

**Noise Level**: ZERO (opt-in, keybind-based)

**Impact**: LOW-MEDIUM
- Better UX for browsing errors
- Not essential (Telescope + quickfix work fine)

**Verdict**: Try it if you frequently work with many diagnostics

---

### 8. ⚠️ CONSIDER: nvim-bqf

**Enhanced quickfix window**

#### What It Offers
- Preview window for quickfix entries
- Fuzzy search within quickfix
- Better navigation

#### Current Alternative
- Standard quickfix + Telescope integration

#### When It's Useful
- If you use quickfix heavily (grep results, LSP references)
- If you want preview without opening files

**Verdict**: Nice-to-have, but Telescope already provides similar functionality

---

## Configuration Noise Audit

### Potential Noise Sources in Current Config

1. ✅ **Which-key popups** (`init.lua:299-350`)
   - **Analysis**: Helpful for learning, low noise
   - **Verdict**: Keep

2. ✅ **Cursor highlighting** (`init.lua:663-684`)
   - **Analysis**: Subtle, helps with visual tracking
   - **Verdict**: Keep

3. ⚠️ **Real-time ESLint** (`run: 'onType'`)
   - **Analysis**: May cause lag on large files
   - **Recommendation**: Monitor performance, switch to `onSave` if slow

4. ✅ **Format on save** (`init.lua:888-903`)
   - **Analysis**: Essential, not noisy
   - **Verdict**: Keep

5. ✅ **Diagnostic virtual text** (`init.lua:701`)
   - **Analysis**: Shows errors inline, can be noisy on error-heavy code
   - **Recommendation**: Current setup is fine, keep `virtual_text = true`

### Plugins to AVOID (Too Noisy)

1. ❌ **nvim-notify** - Fancy notifications
   - Reason: Distracting, default notifications work fine

2. ❌ **noice.nvim** - Fancy UI for messages/cmdline
   - Reason: Heavy, changes core UX, can be jarring

3. ❌ **indent-blankline** - Indent guides
   - Reason: Visual clutter (your config wisely avoids this)

4. ❌ **nvim-colorizer** - Inline color previews
   - Reason: Only useful for CSS/design work, adds noise in TS files

5. ❌ **symbols-outline** - Symbol sidebar
   - Reason: Telescope symbols (`<leader>ds`) is better, less intrusive

---

## Priority Implementation Order

### High Priority (Implement First)

1. **AI Autocompletion** (Codeium)
   - Highest productivity gain
   - Minimal configuration
   - Free and fast

2. **Auto-Import on Save**
   - Zero noise, immediate benefit
   - 5 lines of code to add

### Medium Priority (Implement Second)

3. **TypeScript Debugging** (nvim-dap)
   - Essential for professional development
   - More complex setup, but well worth it

4. **Testing Integration** (Neotest)
   - Quality-of-life improvement
   - Depends on project (Jest/Vitest must be configured)

### Low Priority (Optional)

5. **Trouble.nvim**
   - Try if you work with many diagnostics
   - Not essential

6. **nvim-bqf**
   - Only if you use quickfix heavily

---

## Implementation Checklist

### Step 1: AI Autocompletion (15 minutes)

```bash
# Add codeium to plugins
# Update nvim-cmp sources
# Restart Neovim
# :Lazy sync
# First use will prompt for Codeium auth (one-time)
```

### Step 2: Auto-Import (5 minutes)

```bash
# Add on_attach to ts_ls config
# Restart Neovim
# Test: Import something, save file, verify import appears
```

### Step 3: TypeScript Debugging (30 minutes)

```bash
# Update debug.lua with TypeScript config
# :Lazy sync
# :Mason to verify js-debug-adapter installed
# Create test file, add breakpoint, press F5
```

### Step 4: Testing Integration (20 minutes)

```bash
# Add Neotest plugin
# :Lazy sync
# Open test file
# Press <leader>tt on a test
```

---

## Conclusion

### What to ADD
1. ✅ **Codeium/Copilot** - AI autocompletion (free/paid)
2. ✅ **Auto-import on save** - Native TypeScript LSP feature
3. ✅ **nvim-dap TypeScript** - Professional debugging
4. ✅ **Neotest** - In-editor test running

### What to AVOID
1. ❌ **nvim-lint for JS/TS** - Redundant (ESLint LSP is better)
2. ❌ **typescript-tools.nvim** - Overkill (ts_ls works great)
3. ❌ **Noisy UI plugins** - indent-blankline, nvim-notify, etc.

### Current Config Strengths
- Excellent LSP setup (ts_ls + ESLint LSP)
- Smart two-phase formatting (Prettier → ESLint)
- Clean, minimal plugin set
- Good keybinding ergonomics

### Performance Notes
- Monitor ESLint `run: 'onType'` - switch to `onSave` if laggy
- Codeium is fast (<100ms latency)
- Neotest only runs on demand, zero background cost

---

## Next Steps

1. **Read this document** and decide which features you want
2. **Implement incrementally** - one feature at a time
3. **Test each addition** before moving to the next
4. **Remove if noisy** - don't be afraid to undo

**Remember**: The best config is one that **you understand and can maintain**. Your current setup is excellent - these are enhancements, not fixes.
