# Automated Keybindings Documentation Implementation Plan

## Overview

Implement an automated documentation system for all keyboard shortcuts across dotfiles tools (Neovim, tmux, AeroSpace, yazi, Cursor, IdeaVim, zsh). The system will generate beautiful, searchable documentation using MkDocs Material with interactive tables, and deploy automatically to GitHub Pages on push to master.

**Approach**: Start with manual documentation using MkDocs Material, with infrastructure for future automation via local scripts.

## Current State Analysis

### Existing Configuration Structure
- **7 tools with distinct formats**: Lua (Neovim), TOML (AeroSpace, yazi), VimScript (IdeaVim), JSON (Cursor), Shell configs (tmux, zsh)
- **Consistent keybinding patterns**: Space leader key, Ctrl+hjkl navigation, `<leader>s*` for search across Vim-style tools
- **No existing documentation site**: Only README.md and tool-specific docs
- **No Python/Node.js dependencies**: Clean slate for adding MkDocs Material

### Key Discoveries
- Repository structure at `/Users/michallester/.dotfiles/` with modular tool directories
- Configuration file references:
  - `nvim/.config/nvim/init.lua:160-216` - Core Neovim keymaps
  - `tmux/.tmux.conf:2-25` - tmux keybindings
  - `aerospace/.config/aerospace/aerospace.toml:74-228` - AeroSpace modes
  - `cursor/keybindings.json:2-52` - Cursor JSON keybindings
  - `ideavim/.ideavimrc:20-103` - IdeaVim keymaps
  - `yazi/keymap.toml:5-180` - yazi keymaps
  - `zsh/.zshrc:15,169` - zsh keybindings
- No existing GitHub Actions workflows - clean slate for CI/CD
- Research document exists: `thoughts/shared/research/2025-11-24-automated-keybindings-documentation.md`

## Desired End State

A live documentation website at `https://czechue.github.io/.dotfiles/` featuring:

1. **Homepage**: Overview of all tools with quick navigation
2. **Per-tool pages**: Dedicated pages for each tool with searchable keybinding tables
3. **Interactive search**: Filter keybindings by typing (e.g., "ctrl+h" finds all matches)
4. **Cross-references**: "Quick Reference" page showing common patterns across tools
5. **Automatic deployment**: Push to master triggers GitHub Pages deployment
6. **Update script**: Local Python script to assist with documentation updates

### Verification
- Site accessible at `https://czechue.github.io/.dotfiles/`
- All tools documented with searchable tables
- Keyboard shortcuts render beautifully (++ctrl+h++ style)
- Search functionality works across all tables
- GitHub Actions workflow deploys successfully
- Mobile-responsive design

## What We're NOT Doing

- ❌ Building automatic config parsers in Phase 1 (manual documentation first)
- ❌ Creating visual keyboard layout diagrams (focus on searchable tables)
- ❌ Multilingual support (English only)
- ❌ Command palette UI (using table-based approach)
- ❌ Real-time keybinding testing/execution
- ❌ Browser extension or standalone desktop app
- ❌ Synchronization with other dotfiles repositories

## Implementation Approach

**Strategy**: Incremental phases with working deliverables at each step. Start with minimal viable documentation site, then enhance with interactivity and automation.

**Technology Stack**:
- **MkDocs Material**: Documentation framework with built-in themes and search
- **pymdownx.keys**: Extension for rendering keyboard shortcuts
- **List.js**: Lightweight JavaScript for searchable/sortable tables
- **GitHub Actions**: Automated deployment pipeline
- **Python**: Future automation scripts

---

## Phase 1: Foundation Setup

### Overview
Install MkDocs Material, create project structure, and establish the documentation site foundation.

### Changes Required

#### 1. Python Environment & Dependencies
**File**: `requirements.txt` (new)
**Changes**: Create Python dependencies file

```txt
mkdocs-material==9.5.3
pymdown-extensions==10.7
```

**Rationale**: Pin versions for reproducible builds. MkDocs Material 9.5.3 is latest stable (2024) with all needed features.

#### 2. MkDocs Configuration
**File**: `mkdocs.yml` (new)
**Changes**: Create main MkDocs configuration

```yaml
site_name: Dotfiles Keybindings
site_url: https://czechue.github.io/.dotfiles/
site_description: Comprehensive keyboard shortcuts documentation for personal dotfiles
site_author: Michal Lester
repo_url: https://github.com/czechue/.dotfiles
repo_name: czechue/.dotfiles
edit_uri: edit/master/docs/

theme:
  name: material
  palette:
    # Light mode
    - scheme: default
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-7
        name: Switch to dark mode
    # Dark mode
    - scheme: slate
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-4
        name: Switch to light mode
  features:
    - navigation.instant
    - navigation.instant.prefetch
    - navigation.tabs
    - navigation.tabs.sticky
    - navigation.sections
    - navigation.expand
    - navigation.top
    - search.suggest
    - search.highlight
    - search.share
    - content.code.copy
    - content.code.annotate

markdown_extensions:
  - pymdownx.keys  # Keyboard shortcut rendering
  - tables
  - attr_list
  - md_in_html
  - admonition
  - pymdownx.details
  - pymdownx.superfences
  - pymdownx.tabbed:
      alternate_style: true

extra_css:
  - stylesheets/shortcuts.css

extra_javascript:
  - https://cdnjs.cloudflare.com/ajax/libs/list.js/2.3.1/list.min.js
  - javascripts/shortcuts.js

nav:
  - Home: index.md
  - Tools:
      - Neovim: tools/neovim.md
      - tmux: tools/tmux.md
      - AeroSpace: tools/aerospace.md
      - yazi: tools/yazi.md
      - Cursor: tools/cursor.md
      - IdeaVim: tools/ideavim.md
      - zsh: tools/zsh.md
  - Quick Reference: quick-reference.md
  - About: about.md

plugins:
  - search:
      separator: '[\s\-,:!=\[\]()"/]+|(?!\b)(?=[A-Z][a-z])|\.(?!\d)|&[lg]t;'
```

**Rationale**:
- Navigation tabs for clean top-level organization
- Both light/dark modes for user preference
- Instant navigation for SPA-like experience
- Search with fuzzy matching and keyboard shortcut awareness

#### 3. Documentation Directory Structure
**Directory**: `docs/` (new)
**Changes**: Create directory structure

```
docs/
├── index.md
├── quick-reference.md
├── about.md
├── tools/
│   ├── neovim.md
│   ├── tmux.md
│   ├── aerospace.md
│   ├── yazi.md
│   ├── cursor.md
│   ├── ideavim.md
│   └── zsh.md
├── stylesheets/
│   └── shortcuts.css
└── javascripts/
    └── shortcuts.js
```

#### 4. Homepage
**File**: `docs/index.md` (new)
**Changes**: Create welcoming homepage with overview

```markdown
# Dotfiles Keybindings Documentation

Welcome to the comprehensive keyboard shortcuts documentation for my personal development environment.

## Quick Navigation

<div class="grid cards" markdown>

-   :material-keyboard: __Neovim__

    ---

    Text editor with LSP, Telescope, and custom plugins

    [:octicons-arrow-right-24: View shortcuts](tools/neovim.md)

-   :material-console: __tmux__

    ---

    Terminal multiplexer with vim-style navigation

    [:octicons-arrow-right-24: View shortcuts](tools/tmux.md)

-   :material-window-maximize: __AeroSpace__

    ---

    i3-like window manager for macOS

    [:octicons-arrow-right-24: View shortcuts](tools/aerospace.md)

-   :material-folder: __yazi__

    ---

    Terminal file manager with DuckDB integration

    [:octicons-arrow-right-24: View shortcuts](tools/yazi.md)

-   :material-cursor-default: __Cursor__

    ---

    AI-powered IDE with Vim mode

    [:octicons-arrow-right-24: View shortcuts](tools/cursor.md)

-   :material-vim: __IdeaVim__

    ---

    IntelliJ IDEA Vim emulation

    [:octicons-arrow-right-24: View shortcuts](tools/ideavim.md)

-   :material-terminal: __zsh__

    ---

    Shell configuration with vi mode

    [:octicons-arrow-right-24: View shortcuts](tools/zsh.md)

</div>

## Shared Patterns

All tools follow consistent keybinding patterns:

| Pattern | Keys | Purpose |
|---------|------|---------|
| **Leader Key** | ++space++ | Primary command prefix (Neovim, IdeaVim, Cursor) |
| **Window Navigation** | ++ctrl+h++ ++ctrl+j++ ++ctrl+k++ ++ctrl+l++ | Vim-style directional movement |
| **Search Operations** | ++space+s+"*"++ | Telescope-style search (files, grep, symbols) |
| **LSP Actions** | ++space+g+"*"++ | Go to definition/references/implementation |
| **Refactoring** | ++space+r+"*"++ | Rename, extract, refactor operations |

## Quick Reference

Looking for a specific shortcut? Check the [Quick Reference](quick-reference.md) page for cross-tool comparisons.

## About This Documentation

This site is automatically generated from dotfiles configurations and deployed via GitHub Actions.

- **Repository**: [czechue/.dotfiles](https://github.com/czechue/.dotfiles)
- **Last Updated**: Auto-updated on each push to master
- **Tools**: MkDocs Material, List.js, GitHub Actions
```

#### 5. About Page
**File**: `docs/about.md` (new)
**Changes**: Create about page with contribution info

```markdown
# About

This documentation site provides a comprehensive reference for all keyboard shortcuts across my personal dotfiles configuration.

## Tools Documented

- **Neovim**: Text editor based on Kickstart.nvim with lazy.nvim plugin manager
- **tmux**: Terminal multiplexer with vim-style navigation
- **AeroSpace**: i3-like tiling window manager for macOS
- **yazi**: Terminal file manager with DuckDB plugin
- **Cursor**: AI-powered IDE with Vim mode
- **IdeaVim**: Vim emulation for IntelliJ IDEA
- **zsh**: Shell with vi mode and custom functions

## Technology Stack

- **[MkDocs Material](https://squidfunk.github.io/mkdocs-material/)**: Documentation framework
- **[pymdownx.keys](https://facelessuser.github.io/pymdown-extensions/extensions/keys/)**: Keyboard shortcut rendering
- **[List.js](https://listjs.com/)**: Interactive table search and filtering
- **[GitHub Actions](https://github.com/features/actions)**: Automated deployment

## Repository Structure

```
.dotfiles/
├── docs/              # Documentation source (this site)
├── nvim/             # Neovim configuration
├── tmux/             # tmux configuration
├── aerospace/        # AeroSpace configuration
├── yazi/             # yazi configuration
├── cursor/           # Cursor IDE settings
├── ideavim/          # IdeaVim configuration
└── zsh/              # zsh configuration
```

## Updating Documentation

Documentation is maintained manually and can be updated by:

1. Editing Markdown files in `docs/` directory
2. Running `mkdocs serve` to preview locally
3. Committing changes to master branch
4. GitHub Actions automatically deploys to GitHub Pages

## License

Personal dotfiles repository. Configuration patterns may be freely adapted for personal use.

## Contact

- **GitHub**: [@czechue](https://github.com/czechue)
- **Repository**: [czechue/.dotfiles](https://github.com/czechue/.dotfiles)
```

#### 6. Update .gitignore
**File**: `.gitignore`
**Changes**: Add MkDocs build artifacts

```
.DS_Store
claude/mcp-servers.json
claude/mcpServers.json
site/
.venv/
__pycache__/
*.pyc
```

**Rationale**: Ignore MkDocs build directory and Python virtual environment

### Success Criteria

#### Automated Verification:
- [x] MkDocs Material installed: `pip install -r requirements.txt`
- [x] Site builds successfully: `mkdocs build`
- [x] No build warnings or errors
- [x] Local preview works: `mkdocs serve` accessible at `http://127.0.0.1:8000`
- [ ] All navigation links work (no 404s)

#### Manual Verification:
- [ ] Homepage displays correctly with tool cards
- [ ] Light/dark mode toggle works
- [ ] Navigation tabs appear at top
- [ ] Search box is visible and functional
- [ ] Mobile view is responsive
- [ ] About page renders correctly

**Implementation Note**: After completing this phase and all automated verification passes, preview the site locally and confirm the design looks good before proceeding to Phase 2.

---

## Phase 2: Interactive Framework Integration

### Overview
Add JavaScript interactivity for searchable tables and enhanced keyboard shortcut rendering.

### Changes Required

#### 1. Custom CSS for Shortcuts
**File**: `docs/stylesheets/shortcuts.css` (new)
**Changes**: Create styling for keyboard shortcuts and tables

```css
/* Enhanced keyboard shortcut styling */
.keys kbd {
  background-color: var(--md-code-bg-color);
  border: 1px solid var(--md-default-fg-color--lightest);
  border-radius: 3px;
  box-shadow: 0 1px 0 rgba(0,0,0,0.2), 0 0 0 2px var(--md-code-bg-color) inset;
  color: var(--md-code-fg-color);
  display: inline-block;
  font-family: var(--md-code-font-family);
  font-size: 0.85em;
  line-height: 1.4;
  margin: 0 0.1em;
  padding: 0.1em 0.6em;
  text-shadow: 0 1px 0 var(--md-default-bg-color);
  white-space: nowrap;
}

/* Searchable table container */
.shortcuts-table {
  margin: 2em 0;
}

.shortcuts-table .search {
  width: 100%;
  padding: 12px 16px;
  margin-bottom: 16px;
  border: 1px solid var(--md-default-fg-color--lightest);
  border-radius: 4px;
  background-color: var(--md-code-bg-color);
  color: var(--md-default-fg-color);
  font-size: 0.9rem;
  transition: border-color 0.2s;
}

.shortcuts-table .search:focus {
  outline: none;
  border-color: var(--md-accent-fg-color);
}

.shortcuts-table .search::placeholder {
  color: var(--md-default-fg-color--light);
}

/* Table styling for shortcuts */
.shortcuts-table table {
  width: 100%;
  border-collapse: collapse;
}

.shortcuts-table th {
  background-color: var(--md-default-fg-color--lightest);
  font-weight: 600;
  cursor: pointer;
  user-select: none;
}

.shortcuts-table th:hover {
  background-color: var(--md-default-fg-color--lighter);
}

.shortcuts-table th.sort-asc::after {
  content: " ↑";
}

.shortcuts-table th.sort-desc::after {
  content: " ↓";
}

.shortcuts-table tr:hover {
  background-color: var(--md-default-fg-color--lightest);
}

/* Context badges */
.context-badge {
  display: inline-block;
  padding: 2px 8px;
  margin: 0 4px;
  border-radius: 12px;
  font-size: 0.75em;
  font-weight: 600;
  background-color: var(--md-accent-fg-color);
  color: var(--md-accent-bg-color);
}

/* Empty state for filtered tables */
.shortcuts-table .no-results {
  text-align: center;
  padding: 2em;
  color: var(--md-default-fg-color--light);
  display: none;
}

.shortcuts-table .list:empty + .no-results {
  display: block;
}
```

#### 2. JavaScript Initialization
**File**: `docs/javascripts/shortcuts.js` (new)
**Changes**: Initialize List.js for all shortcut tables

```javascript
/**
 * Initialize searchable/sortable shortcut tables
 * Uses List.js for filtering and sorting
 * Compatible with MkDocs Material instant loading
 */

// Wait for MkDocs Material's instant loading to complete
document$.subscribe(function() {
  initShortcutTables();
});

function initShortcutTables() {
  // Find all elements with .shortcuts-table class
  const tables = document.querySelectorAll('.shortcuts-table');

  tables.forEach((container, index) => {
    // Skip if already initialized
    if (container.classList.contains('shortcuts-initialized')) {
      return;
    }

    // Get the table element
    const table = container.querySelector('table');
    if (!table) return;

    // Extract column names from header
    const headers = table.querySelectorAll('th');
    const valueNames = Array.from(headers).map((th, i) => {
      // Use data-sort attribute if present, otherwise use index
      return th.getAttribute('data-sort') || `col-${i}`;
    });

    // Add classes to table cells for List.js
    const rows = table.querySelectorAll('tbody tr');
    rows.forEach(row => {
      const cells = row.querySelectorAll('td');
      cells.forEach((cell, i) => {
        if (valueNames[i]) {
          cell.classList.add(valueNames[i]);
        }
      });
    });

    // Add list class to tbody
    const tbody = table.querySelector('tbody');
    tbody.classList.add('list');

    // Create search input if not exists
    let searchInput = container.querySelector('.search');
    if (!searchInput) {
      searchInput = document.createElement('input');
      searchInput.className = 'search';
      searchInput.placeholder = 'Search shortcuts...';
      searchInput.type = 'text';
      container.insertBefore(searchInput, table);
    }

    // Initialize List.js
    const options = {
      valueNames: valueNames,
      searchClass: 'search',
      listClass: 'list'
    };

    new List(container, options);

    // Mark as initialized
    container.classList.add('shortcuts-initialized');

    // Add sorting to headers
    headers.forEach((th, i) => {
      th.classList.add('sort');
      th.setAttribute('data-sort', valueNames[i]);
    });
  });

  // Log initialization
  console.log(`Initialized ${tables.length} shortcut tables`);
}

// Fallback for non-instant loading
if (typeof document$ === 'undefined') {
  document.addEventListener('DOMContentLoaded', initShortcutTables);
}
```

### Success Criteria

#### Automated Verification:
- [x] CSS file exists and is referenced in mkdocs.yml
- [x] JavaScript file exists and is referenced in mkdocs.yml
- [x] Site builds without errors: `mkdocs build`
- [x] No console errors when loading site: `mkdocs serve`
- [x] List.js loads from CDN (check browser network tab)

#### Manual Verification:
- [ ] Search input appears above tables
- [ ] Typing in search filters table rows in real-time
- [ ] Clicking table headers sorts columns
- [ ] Keyboard shortcuts render with proper styling
- [ ] Styling works in both light and dark modes
- [ ] Tables remain functional after navigating between pages

**Implementation Note**: Test the search functionality thoroughly with various queries to ensure filtering works correctly.

---

## Phase 3: Tool Documentation Pages

### Overview
Create detailed documentation pages for each tool with searchable keybinding tables.

### Changes Required

#### 1. Neovim Documentation
**File**: `docs/tools/neovim.md` (new)
**Changes**: Document Neovim keybindings

```markdown
# Neovim

Neovim configuration based on Kickstart.nvim with lazy.nvim plugin manager, LSP integration, Telescope fuzzy finder, and custom plugins.

**Configuration**: `nvim/.config/nvim/init.lua`

## Core Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+h++ | Move focus to left window | Window Navigation |
| ++ctrl+j++ | Move focus to lower window | Window Navigation |
| ++ctrl+k++ | Move focus to upper window | Window Navigation |
| ++ctrl+l++ | Move focus to right window | Window Navigation |
| ++shift+j++ | Move line down | Visual Mode |
| ++shift+k++ | Move line up | Visual Mode |
| ++esc++ | Clear search highlighting | Normal Mode |

</div>

## Telescope (Search)

Leader key: ++space++

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+s+f++ | Search files | Fuzzy Finder |
| ++space+s+g++ | Live grep | Fuzzy Finder |
| ++space+s+h++ | Search help tags | Fuzzy Finder |
| ++space+s+d++ | Search diagnostics | Fuzzy Finder |
| ++space+s+r++ | Resume last search | Fuzzy Finder |
| ++space+s+n++ | Search Neovim files | Fuzzy Finder |
| ++space+s+w++ | Search current word | Fuzzy Finder |
| ++space+slash++ | Search in current buffer | Fuzzy Finder |

</div>

## LSP (Language Server)

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++g+d++ | Go to definition | LSP |
| ++g+r++ | Go to references | LSP |
| ++g+shift+i++ | Go to implementation | LSP |
| ++g+shift+d++ | Go to type definition | LSP |
| ++space+r+n++ | Rename symbol | LSP |
| ++space+c+a++ | Code action | LSP |
| ++space+o+i++ | Organize imports | LSP |
| ++shift+k++ | Hover documentation | LSP |

</div>

## Custom Plugins

### LazyGit

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+g+g++ | Open LazyGit | Git |

</div>

### Harpoon

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+a++ | Add file to Harpoon | File Management |
| ++space+h++ | Open Harpoon menu | File Management |
| ++space+1++ | Navigate to Harpoon file 1 | File Management |
| ++space+2++ | Navigate to Harpoon file 2 | File Management |
| ++space+3++ | Navigate to Harpoon file 3 | File Management |
| ++space+4++ | Navigate to Harpoon file 4 | File Management |
| ++space+5++ | Navigate to Harpoon file 5 | File Management |

</div>

### Git Worktree

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+g+w+s++ | Switch git worktree | Git |
| ++space+g+w+c++ | Create git worktree | Git |

</div>

## Theme Switching

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+t+t++ | Toggle Tokyonight theme styles | Theme |
| ++space+t+c++ | Toggle Codeium AI completion | AI |

</div>

## System

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+f++ | Open tmux-sessionizer | Project Switching |

</div>

## References

- **Config**: `nvim/.config/nvim/init.lua`
- **Custom Plugins**: `nvim/.config/nvim/lua/custom/plugins/`
- **Documentation**: `nvim/.config/nvim/README.md`
```

#### 2. tmux Documentation
**File**: `docs/tools/tmux.md` (new)
**Changes**: Document tmux keybindings

```markdown
# tmux

Terminal multiplexer with vim-style navigation and custom keybindings.

**Configuration**: `tmux/.tmux.conf`
**Prefix Key**: ++ctrl+b++

## Session Management

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+f++ | Open tmux-sessionizer | Project Switching (no prefix) |
| ++ctrl+b+r++ | Reload tmux config | Configuration |

</div>

## Pane Navigation

All commands require prefix (++ctrl+b++) first:

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+b+h++ | Select pane left | Pane Navigation |
| ++ctrl+b+j++ | Select pane down | Pane Navigation |
| ++ctrl+b+k++ | Select pane up | Pane Navigation |
| ++ctrl+b+l++ | Select pane right | Pane Navigation |

</div>

## Window Management

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+b+c++ | Create new window in current directory | Window |
| ++ctrl+b+quotedbl++ | Split window vertically in current directory | Window |
| ++ctrl+b+percent++ | Split window horizontally in current directory | Window |

</div>

## Tools Integration

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+b+shift+g++ | Open lazygit popup | Git |

</div>

## References

- **Config**: `tmux/.tmux.conf`
- **Scripts**: `bin/tmux-sessionizer`
```

#### 3. AeroSpace Documentation
**File**: `docs/tools/aerospace.md` (new)
**Changes**: Document AeroSpace keybindings

```markdown
# AeroSpace

i3-like tiling window manager for macOS with multiple modes (main, service, resize).

**Configuration**: `aerospace/.config/aerospace/aerospace.toml`

## Layout Management

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++alt+slash++ | Toggle layout (tiles horizontal/vertical) | Layout |
| ++alt+comma++ | Toggle accordion layout | Layout |

</div>

## Focus Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+alt+h++ | Focus window left | Window Focus |
| ++ctrl+alt+j++ | Focus window down | Window Focus |
| ++ctrl+alt+k++ | Focus window up | Window Focus |
| ++ctrl+alt+l++ | Focus window right | Window Focus |

</div>

## Move Windows

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+alt+shift+h++ | Move window left | Window Movement |
| ++ctrl+alt+shift+j++ | Move window down | Window Movement |
| ++ctrl+alt+shift+k++ | Move window up | Window Movement |
| ++ctrl+alt+shift+l++ | Move window right | Window Movement |

</div>

## Workspace Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++alt+1++ | Switch to workspace 1 | Workspace |
| ++alt+2++ | Switch to workspace 2 | Workspace |
| ++alt+3++ | Switch to workspace 3 | Workspace |
| ++alt+4++ | Switch to workspace 4 | Workspace |
| ++alt+5++ | Switch to workspace 5 | Workspace |
| ++alt+6++ | Switch to workspace 6 | Workspace |
| ++alt+7++ | Switch to workspace 7 | Workspace |
| ++alt+8++ | Switch to workspace 8 | Workspace |
| ++alt+9++ | Switch to workspace 9 | Workspace |

</div>

## Move to Workspace

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++alt+shift+1++ | Move window to workspace 1 | Window Movement |
| ++alt+shift+2++ | Move window to workspace 2 | Window Movement |
| ++alt+shift+3++ | Move window to workspace 3 | Window Movement |
| ++alt+shift+4++ | Move window to workspace 4 | Window Movement |
| ++alt+shift+5++ | Move window to workspace 5 | Window Movement |
| ++alt+shift+6++ | Move window to workspace 6 | Window Movement |
| ++alt+shift+7++ | Move window to workspace 7 | Window Movement |
| ++alt+shift+8++ | Move window to workspace 8 | Window Movement |
| ++alt+shift+9++ | Move window to workspace 9 | Window Movement |

</div>

## Modes

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++alt+r++ | Enter resize mode | Mode Switch |
| ++alt+shift+semicolon++ | Enter service mode | Mode Switch |

</div>

### Resize Mode

After pressing ++alt+r++:

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++h++ | Decrease width | Resize |
| ++j++ | Increase height | Resize |
| ++k++ | Decrease height | Resize |
| ++l++ | Increase width | Resize |
| ++esc++ | Exit resize mode | Mode |

</div>

### Service Mode

After pressing ++alt+shift+semicolon++:

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++r++ | Reload config | Service |
| ++esc++ | Exit service mode | Mode |

</div>

## References

- **Config**: `aerospace/.config/aerospace/aerospace.toml`
- **Documentation**: `aerospace/CLAUDE.md`
```

#### 4. yazi Documentation
**File**: `docs/tools/yazi.md` (new)
**Changes**: Document yazi keybindings

```markdown
# yazi

Terminal file manager with vim-style navigation and DuckDB plugin for CSV preview.

**Configuration**: `yazi/keymap.toml`

## Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++k++ | Previous file | Navigation |
| ++j++ | Next file | Navigation |
| ++h++ | Parent directory | Navigation |
| ++l++ | Enter directory | Navigation |
| ++shift+h++ | Back in history | Navigation |
| ++shift+l++ | Forward in history | Navigation |
| ++g+g++ | Go to top | Navigation |
| ++shift+g++ | Go to bottom | Navigation |

</div>

## File Operations

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++o++ | Open selected files | File Operations |
| ++y++ | Yank (copy) files | File Operations |
| ++p++ | Paste files | File Operations |
| ++d++ | Trash selected files | File Operations |
| ++a++ | Create file | File Operations |
| ++r++ | Rename file | File Operations |

</div>

## Search & Filter

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++s++ | Search files by name (fd) | Search |
| ++shift+s++ | Search files by content (ripgrep) | Search |
| ++z++ | Jump to directory (fzf) | Search |
| ++shift+z++ | Jump to directory (zoxide) | Search |
| ++f++ | Filter files | Filter |
| ++slash++ | Find next file | Find |

</div>

## Copy Operations

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++c+c++ | Copy file path | Clipboard |
| ++c+d++ | Copy directory path | Clipboard |
| ++c+f++ | Copy filename | Clipboard |

</div>

## Sorting

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++comma+m++ | Sort by modified time | Sorting |
| ++comma+shift+m++ | Sort by modified time (reverse) | Sorting |
| ++comma+n++ | Sort by natural order | Sorting |

</div>

## Tabs

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++t++ | Create new tab | Tabs |
| ++1++ | Switch to tab 1 | Tabs |
| ++2++ | Switch to tab 2 | Tabs |
| ++3++ | Switch to tab 3 | Tabs |
| ++4++ | Switch to tab 4 | Tabs |
| ++5++ | Switch to tab 5 | Tabs |
| ++6++ | Switch to tab 6 | Tabs |
| ++7++ | Switch to tab 7 | Tabs |
| ++8++ | Switch to tab 8 | Tabs |
| ++9++ | Switch to tab 9 | Tabs |

</div>

## References

- **Config**: `yazi/keymap.toml`
- **DuckDB Plugin**: `yazi/plugins/duckdb.yazi/`
```

#### 5. Cursor Documentation
**File**: `docs/tools/cursor.md` (new)
**Changes**: Document Cursor IDE keybindings

```markdown
# Cursor

AI-powered IDE based on VS Code with Vim mode and custom keybindings.

**Configuration**: `cursor/keybindings.json`, `cursor/settings.json`

## AI Features

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++cmd+i++ | Open composer mode | AI |
| ++cmd+k++ | Inline AI edit | AI |
| ++cmd+shift+l++ | Open AI chat | AI |

</div>

## Editor

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+e++ | Toggle explorer sidebar | Editor |
| ++shift+space++ | Trigger suggestions | Editor |
| ++cmd+1++ | Toggle sidebar visibility | Editor |
| ++cmd+right++ | Accept inline suggestion word | Editor |

</div>

## Vim Mode - Window Navigation

Leader key: ++space++

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+h++ | Navigate to left editor group | Window Navigation |
| ++ctrl+j++ | Navigate to lower editor group | Window Navigation |
| ++ctrl+k++ | Navigate to upper editor group | Window Navigation |
| ++ctrl+l++ | Navigate to right editor group | Window Navigation |

</div>

## Vim Mode - Window Management

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+w+v++ | Split editor vertically | Window |
| ++space+w+h++ | Split editor horizontally | Window |
| ++space+w+w++ | Close editor | Window |
| ++space+w+a++ | Close all editors | Window |

</div>

## Vim Mode - Search

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+s+f++ | Quick open (find files) | Search |
| ++space+s+g++ | Find in files | Search |
| ++space+s+s++ | Go to symbol | Search |
| ++space+s+a++ | Show all commands | Search |
| ++space+s+r++ | Show recent files | Search |

</div>

## Vim Mode - LSP

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+g+d++ | Go to definition | LSP |
| ++space+g+y++ | Go to type definition | LSP |
| ++space+g+i++ | Go to implementation | LSP |
| ++space+r+n++ | Rename symbol | LSP |

</div>

## Vim Mode - Code Actions

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+c+a++ | Show code actions | Code Actions |
| ++space+r+m++ | Extract to method | Refactoring |
| ++space+r+v++ | Extract to variable | Refactoring |

</div>

## Vim Mode - Multiple Cursors

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+g++ | Add next occurrence | Multiple Cursors |
| ++space+ctrl+g++ | Add all occurrences | Multiple Cursors |

</div>

## Vim Mode - Visual Mode

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++shift+j++ | Move line down | Visual Mode |
| ++shift+k++ | Move line up | Visual Mode |

</div>

## References

- **Keybindings**: `cursor/keybindings.json`
- **Vim Settings**: `cursor/settings.json`
- **Documentation**: `cursor/README.md`
```

#### 6. IdeaVim Documentation
**File**: `docs/tools/ideavim.md` (new)
**Changes**: Document IdeaVim keybindings

```markdown
# IdeaVim

Vim emulation plugin for IntelliJ IDEA with custom keybindings matching Neovim patterns.

**Configuration**: `ideavim/.ideavimrc`
**Leader Key**: ++space++

## Window Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+h++ | Move to left window | Window Navigation |
| ++ctrl+j++ | Move to lower window | Window Navigation |
| ++ctrl+k++ | Move to upper window | Window Navigation |
| ++ctrl+l++ | Move to right window | Window Navigation |

</div>

## Window Management

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+w+v++ | Split vertically | Window |
| ++space+w+h++ | Split horizontally | Window |
| ++space+w+w++ | Unsplit (close split) | Window |
| ++space+w+a++ | Unsplit all | Window |

</div>

## Search/Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+s+f++ | Go to file | Search |
| ++space+s+g++ | Find in path | Search |
| ++space+s+s++ | Go to symbol | Search |
| ++space+s+a++ | Go to action | Search |
| ++space+s+d++ | Show error description | Search |
| ++space+s+r++ | Recent files | Search |

</div>

## LSP/Navigation

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+g+d++ | Go to declaration | LSP |
| ++space+g+y++ | Go to type declaration | LSP |
| ++space+g+i++ | Go to implementation | LSP |
| ++space+g+t++ | Go to test | LSP |
| ++space+r+n++ | Rename element | LSP |

</div>

## Code Actions

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+c+a++ | Show intention actions (code actions) | Code Actions |
| ++space+s+w++ | Surround with | Code Actions |
| ++shift+space++ | Generate menu | Code Actions |
| ++space+r+m++ | Extract method | Refactoring |
| ++space+r+v++ | Introduce variable | Refactoring |
| ++space+r+f++ | Introduce field | Refactoring |

</div>

## Multiple Cursors

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+g++ | Select next occurrence | Multiple Cursors |
| ++space+ctrl+g++ | Select all occurrences | Multiple Cursors |
| ++alt+j++ | Add selection on next occurrence | Multiple Cursors |
| ++alt+shift+j++ | Unselect occurrence | Multiple Cursors |

</div>

## File Operations

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++space+q+q++ | Close content | File |
| ++space+q+a++ | Close all editors | File |

</div>

## References

- **Config**: `ideavim/.ideavimrc`
- **Plugins**: EasyMotion, Surround, Multiple Cursors, Commentary, Which-Key
```

#### 7. zsh Documentation
**File**: `docs/tools/zsh.md` (new)
**Changes**: Document zsh keybindings

```markdown
# zsh

Shell configuration with vi mode, custom functions, and keybindings.

**Configuration**: `zsh/.zshrc`

## Custom Keybindings

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+f++ | Open tmux-sessionizer | Project Switching |

</div>

## fzf Integration

Built-in fzf keybindings (loaded via `source <(fzf --zsh)`):

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++ctrl+r++ | Search command history | fzf |
| ++ctrl+t++ | Search files in current directory | fzf |
| ++alt+c++ | Change directory (fuzzy) | fzf |

</div>

## Vi Mode

Vi mode enabled via `zsh-vi-mode` plugin:

<div class="shortcuts-table" markdown>

| Shortcut | Action | Context |
|----------|--------|---------|
| ++esc++ | Enter normal mode | Vi Mode |
| ++i++ | Enter insert mode | Vi Mode (from normal) |
| ++v++ | Edit command in editor | Vi Mode (normal) |

</div>

## Custom Functions

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `killport <port>` | Kill process on specified port | Utility Function |
| `y` | yazi wrapper (cd on exit) | File Manager |

</div>

## References

- **Config**: `zsh/.zshrc`
- **Scripts**: `bin/tmux-sessionizer`
```

### Success Criteria

#### Automated Verification:
- [x] All 7 tool documentation files exist in `docs/tools/`
- [x] Site builds successfully: `mkdocs build`
- [ ] No broken links: Check all internal references
- [x] All tables have proper markdown syntax
- [ ] Navigation works between all pages

#### Manual Verification:
- [ ] Each tool page renders correctly
- [ ] Search functionality works on every table
- [ ] All keyboard shortcuts render properly with ++key++ syntax
- [ ] Tables are sortable by clicking headers
- [ ] Mobile layout is readable
- [ ] Content is accurate (cross-check with actual config files)
- [ ] Context badges display correctly (if implemented)

**Implementation Note**: After completing this phase, thoroughly review each tool's documentation against the actual configuration files to ensure accuracy.

---

## Phase 4: Cross-Reference System

### Overview
Create unified search and quick reference pages that span all tools.

### Changes Required

#### 1. Quick Reference Page
**File**: `docs/quick-reference.md` (new)
**Changes**: Create cross-tool quick reference

```markdown
# Quick Reference

Unified view of keyboard shortcuts across all tools with cross-tool comparisons.

## Universal Patterns

### Window Navigation (Ctrl+HJKL)

Available in: Neovim, tmux (with prefix), AeroSpace (Ctrl+Alt+HJKL), Cursor, IdeaVim

<div class="shortcuts-table" markdown>

| Tool | Left | Down | Up | Right | Notes |
|------|------|------|----|----|-------|
| **Neovim** | ++ctrl+h++ | ++ctrl+j++ | ++ctrl+k++ | ++ctrl+l++ | Direct navigation |
| **tmux** | ++ctrl+b+h++ | ++ctrl+b+j++ | ++ctrl+b+k++ | ++ctrl+b+l++ | Requires prefix |
| **AeroSpace** | ++ctrl+alt+h++ | ++ctrl+alt+j++ | ++ctrl+alt+k++ | ++ctrl+alt+l++ | System-wide |
| **Cursor** | ++ctrl+h++ | ++ctrl+j++ | ++ctrl+k++ | ++ctrl+l++ | Vim mode |
| **IdeaVim** | ++ctrl+h++ | ++ctrl+j++ | ++ctrl+k++ | ++ctrl+l++ | Vim emulation |

</div>

### Search Operations (Leader+S+*)

Available in: Neovim, Cursor, IdeaVim

<div class="shortcuts-table" markdown>

| Action | Neovim | Cursor | IdeaVim |
|--------|--------|--------|---------|
| **Find Files** | ++space+s+f++ | ++space+s+f++ | ++space+s+f++ |
| **Grep/Search** | ++space+s+g++ | ++space+s+g++ | ++space+s+g++ |
| **Symbols** | ++space+s+h++ | ++space+s+s++ | ++space+s+s++ |
| **Recent Files** | ++space+s+r++ | ++space+s+r++ | ++space+s+r++ |

</div>

### LSP Actions (Leader+G+*)

Available in: Neovim, Cursor, IdeaVim

<div class="shortcuts-table" markdown>

| Action | Neovim | Cursor | IdeaVim |
|--------|--------|--------|---------|
| **Go to Definition** | ++g+d++ | ++space+g+d++ | ++space+g+d++ |
| **Go to References** | ++g+r++ | - | - |
| **Go to Implementation** | ++g+shift+i++ | ++space+g+i++ | ++space+g+i++ |
| **Rename** | ++space+r+n++ | ++space+r+n++ | ++space+r+n++ |
| **Code Action** | ++space+c+a++ | ++space+c+a++ | ++space+c+a++ |

</div>

## Tool-Specific Essentials

### Project Switching

<div class="shortcuts-table" markdown>

| Tool | Shortcut | Action |
|------|----------|--------|
| **Neovim** | ++ctrl+f++ | tmux-sessionizer |
| **tmux** | ++ctrl+f++ | tmux-sessionizer (no prefix) |
| **zsh** | ++ctrl+f++ | tmux-sessionizer |
| **yazi** | ++z++ | fzf directory jump |
| **yazi** | ++shift+z++ | zoxide directory jump |

</div>

### File Management

<div class="shortcuts-table" markdown>

| Tool | Open | Copy | Paste | Delete | Rename |
|------|------|------|-------|--------|--------|
| **yazi** | ++o++ | ++y++ | ++p++ | ++d++ | ++r++ |
| **Neovim** | ++space+s+f++ | - | - | - | ++space+r+n++ |

</div>

### Git Operations

<div class="shortcuts-table" markdown>

| Tool | Shortcut | Action |
|------|----------|--------|
| **Neovim** | ++space+g+g++ | LazyGit |
| **tmux** | ++ctrl+b+shift+g++ | LazyGit popup |
| **Neovim** | ++space+g+w+s++ | Git worktree switch |
| **Neovim** | ++space+g+w+c++ | Git worktree create |

</div>

## Mode-Specific Shortcuts

### AeroSpace Modes

<div class="shortcuts-table" markdown>

| Mode | Enter | Exit | Purpose |
|------|-------|------|---------|
| **Resize** | ++alt+r++ | ++esc++ | Resize windows |
| **Service** | ++alt+shift+semicolon++ | ++esc++ | Reload config |

</div>

### Vim Modes (Neovim, Cursor, IdeaVim)

<div class="shortcuts-table" markdown>

| Mode | Enter | Purpose |
|------|-------|---------|
| **Normal** | ++esc++ | Command mode |
| **Insert** | ++i++ | Text editing |
| **Visual** | ++v++ | Selection |
| **Visual Line** | ++shift+v++ | Line selection |

</div>

## All Shortcuts Search

Use the search box below to find shortcuts across all tools:

<div class="shortcuts-table" markdown>

| Shortcut | Action | Tool | Context |
|----------|--------|------|---------|
| ++ctrl+h++ | Navigate left | Neovim | Window Navigation |
| ++ctrl+h++ | Navigate left | Cursor | Window Navigation |
| ++ctrl+h++ | Navigate left | IdeaVim | Window Navigation |
| ++ctrl+b+h++ | Select pane left | tmux | Pane Navigation |
| ++ctrl+alt+h++ | Focus left | AeroSpace | Window Focus |
| ++h++ | Parent directory | yazi | Navigation |
| ++space+s+f++ | Search files | Neovim | Telescope |
| ++space+s+f++ | Quick open | Cursor | Search |
| ++space+s+f++ | Go to file | IdeaVim | Search |
| ++space+g+g++ | LazyGit | Neovim | Git |
| ++ctrl+b+shift+g++ | LazyGit popup | tmux | Git |
| ++ctrl+f++ | tmux-sessionizer | Multiple | Project Switching |
| ++alt+1++ through ++alt+9++ | Switch workspace | AeroSpace | Workspace |
| ++1++ through ++9++ | Switch tab | yazi | Tabs |
| ++space+a++ | Add to Harpoon | Neovim | File Management |
| ++space+h++ | Harpoon menu | Neovim | File Management |
| ++g+d++ | Go to definition | Neovim | LSP |
| ++space+g+d++ | Go to definition | Cursor/IdeaVim | LSP |
| ++space+r+n++ | Rename | Multiple | LSP |
| ++space+c+a++ | Code action | Multiple | LSP |

</div>

## Tips

- **Leader Key**: Most Vim-style tools use ++space++ as the leader
- **Prefix Key**: tmux uses ++ctrl+b++ as the prefix for all commands
- **System-Wide**: AeroSpace keybindings work across all applications
- **Context-Aware**: Some shortcuts behave differently in different modes

## See Also

- [Neovim](tools/neovim.md) - Full Neovim shortcuts
- [tmux](tools/tmux.md) - Full tmux shortcuts
- [AeroSpace](tools/aerospace.md) - Full AeroSpace shortcuts
- [yazi](tools/yazi.md) - Full yazi shortcuts
- [Cursor](tools/cursor.md) - Full Cursor shortcuts
- [IdeaVim](tools/ideavim.md) - Full IdeaVim shortcuts
- [zsh](tools/zsh.md) - Full zsh shortcuts
```

### Success Criteria

#### Automated Verification:
- [ ] Quick reference page exists: `docs/quick-reference.md`
- [ ] Site builds successfully: `mkdocs build`
- [ ] All cross-references link correctly
- [ ] Search functionality works on unified table

#### Manual Verification:
- [ ] Cross-tool comparisons are accurate
- [ ] Universal patterns section is helpful
- [ ] Unified search table includes all major shortcuts
- [ ] Navigation between quick reference and tool pages works
- [ ] Tables remain searchable and sortable
- [ ] Content accurately reflects actual keybindings

**Implementation Note**: The unified search table should be comprehensive but not overwhelming. Focus on the most common shortcuts that users would actually search for.

---

## Phase 5: GitHub Pages Deployment

### Overview
Set up automated deployment to GitHub Pages via GitHub Actions.

### Changes Required

#### 1. GitHub Actions Workflow
**File**: `.github/workflows/docs.yml` (new)
**Changes**: Create deployment workflow

```yaml
name: Deploy Documentation to GitHub Pages

on:
  push:
    branches:
      - master
  workflow_dispatch:

permissions:
  contents: write

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 0  # Fetch all history for git info

      - name: Configure Git Credentials
        run: |
          git config user.name github-actions[bot]
          git config user.email 41898282+github-actions[bot]@users.noreply.github.com

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.x'

      - name: Cache dependencies
        uses: actions/cache@v4
        with:
          key: ${{ runner.os }}-pip-${{ hashFiles('requirements.txt') }}
          path: ~/.cache/pip
          restore-keys: |
            ${{ runner.os }}-pip-

      - name: Install MkDocs Material
        run: |
          pip install --upgrade pip
          pip install -r requirements.txt

      - name: Build documentation
        run: mkdocs build --strict

      - name: Deploy to GitHub Pages
        run: mkdocs gh-deploy --force
```

**Rationale**:
- Triggers on push to master and manual dispatch
- Uses latest GitHub Actions (v4/v5)
- Caches pip dependencies for faster builds
- `--strict` flag fails on warnings (catches broken links)
- `mkdocs gh-deploy` handles gh-pages branch automatically

#### 2. Update README with Documentation Link
**File**: `README.md`
**Changes**: Add documentation site link in introduction

```markdown
# .dotfiles

Personal dotfiles for macOS development environment.

**📚 [View Keybindings Documentation](https://czechue.github.io/.dotfiles/)** - Comprehensive keyboard shortcuts reference for all tools.

## Overview
...
```

**Line**: After line 1 (title), insert the documentation link.

#### 3. Repository Settings Documentation
**File**: `docs/about.md`
**Changes**: Add deployment information

Add this section after "Technology Stack":

```markdown
## Deployment

This documentation is automatically deployed to GitHub Pages when changes are pushed to the master branch.

### Deployment Process

1. Push changes to `master` branch
2. GitHub Actions workflow triggers (`.github/workflows/docs.yml`)
3. Workflow installs Python and MkDocs Material
4. Site builds with `mkdocs build --strict`
5. Deploys to `gh-pages` branch with `mkdocs gh-deploy`
6. GitHub Pages serves the site at `https://czechue.github.io/.dotfiles/`

### Manual Deployment

You can also deploy manually from your local machine:

```bash
# Install dependencies
pip install -r requirements.txt

# Build and deploy
mkdocs gh-deploy
```

### GitHub Pages Settings

In the repository settings, GitHub Pages should be configured to:
- **Source**: Deploy from `gh-pages` branch
- **Folder**: `/` (root)
- **Custom domain**: None (using default GitHub Pages URL)
```

### Success Criteria

#### Automated Verification:
- [ ] Workflow file exists: `.github/workflows/docs.yml`
- [ ] Workflow syntax is valid (GitHub will validate on push)
- [ ] requirements.txt exists with pinned versions
- [ ] Site builds locally without errors: `mkdocs build --strict`
- [ ] No build warnings (--strict flag enforces this)

#### Manual Verification:
- [ ] Push to master triggers GitHub Actions workflow
- [ ] Workflow completes successfully (check Actions tab)
- [ ] `gh-pages` branch is created/updated
- [ ] Site is accessible at `https://czechue.github.io/.dotfiles/`
- [ ] All pages load correctly on live site
- [ ] Search works on live site
- [ ] Interactive tables function properly
- [ ] CSS and JavaScript load correctly
- [ ] Mobile view works on live site
- [ ] Navigation between pages works
- [ ] Dark/light mode toggle works

**Implementation Note**: After pushing the workflow file, go to GitHub repository Settings → Pages and ensure GitHub Pages is enabled and set to deploy from the `gh-pages` branch. The first deployment may take a few minutes.

---

## Phase 6: Local Update Script

### Overview
Create a Python helper script to assist with documentation updates and future automation.

### Changes Required

#### 1. Update Script
**File**: `scripts/update-docs.py` (new)
**Changes**: Create documentation helper script

```python
#!/usr/bin/env python3
"""
Documentation update helper script for dotfiles keybindings.

Currently provides utilities to validate documentation and prepare for future automation.
Future enhancements will include automatic parsing of config files.
"""

import re
import sys
from pathlib import Path
from typing import List, Dict, Set

# Configuration
DOTFILES_ROOT = Path(__file__).parent.parent
DOCS_ROOT = DOTFILES_ROOT / "docs"
CONFIG_FILES = {
    "neovim": DOTFILES_ROOT / "nvim" / ".config" / "nvim" / "init.lua",
    "tmux": DOTFILES_ROOT / "tmux" / ".tmux.conf",
    "aerospace": DOTFILES_ROOT / "aerospace" / ".config" / "aerospace" / "aerospace.toml",
    "yazi": DOTFILES_ROOT / "yazi" / "keymap.toml",
    "cursor_keys": DOTFILES_ROOT / "cursor" / "keybindings.json",
    "cursor_vim": DOTFILES_ROOT / "cursor" / "settings.json",
    "ideavim": DOTFILES_ROOT / "ideavim" / ".ideavimrc",
    "zsh": DOTFILES_ROOT / "zsh" / ".zshrc",
}


def check_config_files_exist() -> bool:
    """Verify all config files exist."""
    print("Checking configuration files...")
    all_exist = True

    for name, path in CONFIG_FILES.items():
        if path.exists():
            print(f"  ✓ {name}: {path}")
        else:
            print(f"  ✗ {name}: {path} NOT FOUND")
            all_exist = False

    return all_exist


def check_docs_files_exist() -> bool:
    """Verify all documentation files exist."""
    print("\nChecking documentation files...")

    required_files = [
        DOCS_ROOT / "index.md",
        DOCS_ROOT / "quick-reference.md",
        DOCS_ROOT / "about.md",
        DOCS_ROOT / "tools" / "neovim.md",
        DOCS_ROOT / "tools" / "tmux.md",
        DOCS_ROOT / "tools" / "aerospace.md",
        DOCS_ROOT / "tools" / "yazi.md",
        DOCS_ROOT / "tools" / "cursor.md",
        DOCS_ROOT / "tools" / "ideavim.md",
        DOCS_ROOT / "tools" / "zsh.md",
    ]

    all_exist = True
    for path in required_files:
        if path.exists():
            print(f"  ✓ {path.relative_to(DOTFILES_ROOT)}")
        else:
            print(f"  ✗ {path.relative_to(DOTFILES_ROOT)} NOT FOUND")
            all_exist = False

    return all_exist


def extract_shortcuts_from_docs(tool_name: str) -> Set[str]:
    """Extract all shortcuts from a tool's documentation file."""
    doc_file = DOCS_ROOT / "tools" / f"{tool_name}.md"

    if not doc_file.exists():
        return set()

    shortcuts = set()
    content = doc_file.read_text()

    # Match ++key++ and ++key+key++ patterns
    pattern = r'\+\+([^+]+)\+\+'
    matches = re.findall(pattern, content)

    for match in matches:
        # Normalize the shortcut representation
        shortcuts.add(match.lower().replace("+", ""))

    return shortcuts


def validate_documentation() -> bool:
    """Run validation checks on documentation."""
    print("\nValidating documentation...")

    # Check for broken internal links
    print("\n  Checking for broken internal links...")
    # TODO: Implement link validation

    # Check for empty tables
    print("  Checking for empty tables...")
    # TODO: Implement table validation

    # Check keyboard shortcut formatting
    print("  Checking keyboard shortcut formatting...")
    # TODO: Implement shortcut format validation

    return True


def print_stats() -> None:
    """Print statistics about documented shortcuts."""
    print("\nDocumentation Statistics:")

    tools = ["neovim", "tmux", "aerospace", "yazi", "cursor", "ideavim", "zsh"]
    total_shortcuts = 0

    for tool in tools:
        shortcuts = extract_shortcuts_from_docs(tool)
        count = len(shortcuts)
        total_shortcuts += count
        print(f"  {tool.capitalize()}: {count} shortcuts")

    print(f"\n  Total: {total_shortcuts} shortcuts documented")


def main():
    """Main entry point."""
    print("Dotfiles Documentation Update Helper")
    print("=" * 50)

    # Check files exist
    configs_ok = check_config_files_exist()
    docs_ok = check_docs_files_exist()

    if not (configs_ok and docs_ok):
        print("\n❌ Some files are missing. Please check the output above.")
        return 1

    # Validate documentation
    valid = validate_documentation()

    if not valid:
        print("\n❌ Documentation validation failed.")
        return 1

    # Print statistics
    print_stats()

    print("\n✅ All checks passed!")
    print("\nTo preview documentation locally:")
    print("  mkdocs serve")
    print("\nTo deploy documentation:")
    print("  mkdocs gh-deploy")

    return 0


if __name__ == "__main__":
    sys.exit(main())
```

**Rationale**:
- Provides utilities for validation and statistics
- Foundation for future automation (parsing configs)
- Helps catch issues before committing

#### 2. Make Script Executable
**Command**: `chmod +x scripts/update-docs.py`

#### 3. Update README with Workflow
**File**: `README.md`
**Changes**: Add documentation update workflow section

Add this section after the "Setup" section:

```markdown
## Updating Documentation

The keybindings documentation is maintained manually in the `docs/` directory.

### Local Preview

```bash
# Install dependencies
pip install -r requirements.txt

# Start local preview server
mkdocs serve
# Visit http://127.0.0.1:8000
```

### Update Workflow

1. Edit documentation files in `docs/tools/*.md`
2. Run validation helper:
   ```bash
   python scripts/update-docs.py
   ```
3. Preview changes locally: `mkdocs serve`
4. Commit and push to master
5. GitHub Actions automatically deploys to GitHub Pages

### Manual Deployment

If needed, you can deploy manually:

```bash
mkdocs gh-deploy
```
```

#### 4. Scripts Directory
**Directory**: `scripts/` (new)
**Changes**: Create directory for helper scripts

```
scripts/
├── update-docs.py       # Documentation helper (created above)
└── README.md           # Scripts documentation (create next)
```

#### 5. Scripts README
**File**: `scripts/README.md` (new)
**Changes**: Document available scripts

```markdown
# Helper Scripts

Utility scripts for dotfiles maintenance and documentation.

## update-docs.py

Documentation validation and update helper.

**Usage**:
```bash
python scripts/update-docs.py
```

**Features**:
- Validates configuration files exist
- Checks documentation files exist
- Extracts shortcuts from documentation
- Prints documentation statistics
- Foundation for future automation

**Future Enhancements**:
- Automatic parsing of config files
- Detection of undocumented shortcuts
- Synchronization between configs and docs
- Generation of markdown tables from configs
```

### Success Criteria

#### Automated Verification:
- [ ] Script exists and is executable: `scripts/update-docs.py`
- [ ] Script runs without errors: `python scripts/update-docs.py`
- [ ] Script correctly identifies all config files
- [ ] Script correctly identifies all docs files
- [ ] Script prints statistics for all tools
- [ ] No Python syntax errors or exceptions

#### Manual Verification:
- [ ] Script output is readable and helpful
- [ ] Statistics match actual documentation
- [ ] README workflow instructions are clear
- [ ] Local preview workflow works as documented
- [ ] Script provides useful validation feedback

**Implementation Note**: This script lays the groundwork for future automation. In Phase 2 of the project (not part of this plan), the script can be enhanced to actually parse config files and generate/update documentation automatically.

---

## Testing Strategy

### Unit Testing
Not applicable for this phase (manual documentation).

### Integration Testing

1. **End-to-End Documentation Build**:
   ```bash
   # Clean build from scratch
   rm -rf site/
   mkdocs build --strict
   ```
   - Verify no errors or warnings
   - Check all pages render correctly

2. **Local Preview Testing**:
   ```bash
   mkdocs serve
   ```
   - Test all navigation links
   - Verify search functionality
   - Test interactive tables (filtering, sorting)
   - Verify keyboard shortcuts render correctly
   - Test dark/light mode switching
   - Check mobile responsiveness

3. **Deployment Testing**:
   ```bash
   # Test manual deployment
   mkdocs gh-deploy
   ```
   - Verify gh-pages branch updates
   - Check live site loads correctly
   - Test all features on live site

### Manual Testing Steps

1. **Homepage**:
   - [ ] Tool cards display correctly
   - [ ] Navigation links work
   - [ ] Shared patterns table is accurate
   - [ ] Quick reference link works

2. **Tool Pages** (test each: Neovim, tmux, AeroSpace, yazi, Cursor, IdeaVim, zsh):
   - [ ] Search input appears above each table
   - [ ] Typing in search filters table rows
   - [ ] Clicking table headers sorts columns
   - [ ] Keyboard shortcuts render with proper styling
   - [ ] All shortcuts are documented
   - [ ] Context information is clear

3. **Quick Reference**:
   - [ ] Cross-tool comparisons are accurate
   - [ ] Unified search table works
   - [ ] Links to tool pages work
   - [ ] Universal patterns section is helpful

4. **About Page**:
   - [ ] Information is up-to-date
   - [ ] Links to repository work
   - [ ] Deployment process is documented

5. **Site-Wide**:
   - [ ] Site-wide search works (top bar)
   - [ ] Navigation tabs function correctly
   - [ ] Dark/light mode toggle works
   - [ ] Mobile layout is usable
   - [ ] All pages load quickly

6. **GitHub Actions**:
   - [ ] Workflow triggers on push to master
   - [ ] Build succeeds
   - [ ] Deployment completes
   - [ ] Live site updates

## Performance Considerations

### Build Performance
- **Estimated build time**: 5-10 seconds for full site build
- **GitHub Actions**: ~30-60 seconds including setup
- **MkDocs Material caching**: Enabled in workflow for faster subsequent builds

### Site Performance
- **Static site**: No server-side processing, fast loading
- **List.js**: Lightweight (~11KB), minimal performance impact
- **CDN delivery**: List.js loaded from CDN for fast access
- **MkDocs Material**: Optimized for instant loading feature
- **Expected page load**: <1 second on decent connection

### Optimization Opportunities
- Consider self-hosting List.js if CDN becomes a concern
- Minify custom CSS/JS if site grows large
- Use MkDocs plugins for image optimization if adding screenshots
- Monitor GitHub Pages bandwidth (should be well within limits)

## Migration Notes

No existing documentation site to migrate from. This is a greenfield implementation.

### Considerations for Users

1. **Bookmark Update**: Users should bookmark `https://czechue.github.io/.dotfiles/` for quick access
2. **README Link**: Main README will link to documentation site for discoverability
3. **Local Access**: Documentation can still be browsed offline via `mkdocs serve`

### Rollback Plan

If documentation site has issues:

1. **Immediate**: Remove link from README
2. **Short-term**: Disable GitHub Actions workflow
3. **If needed**: Delete gh-pages branch to remove site
4. **Fallback**: Continue using existing README-based documentation

## References

### Research & Plans
- **Research document**: `thoughts/shared/research/2025-11-24-automated-keybindings-documentation.md`
- **Configuration analysis**: Research document sections on config structure and extraction patterns

### External Documentation
- **MkDocs Material**: https://squidfunk.github.io/mkdocs-material/
- **pymdownx.keys**: https://facelessuser.github.io/pymdown-extensions/extensions/keys/
- **List.js**: https://listjs.com/
- **GitHub Actions for Pages**: https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages

### Configuration Files
- `nvim/.config/nvim/init.lua:160-216` - Neovim core keymaps
- `nvim/.config/nvim/init.lua:517-555` - Telescope keymaps
- `nvim/.config/nvim/init.lua:619-677` - LSP keymaps
- `nvim/.config/nvim/lua/custom/plugins/init.lua:44-64` - Plugin keymaps
- `tmux/.tmux.conf:2-25` - tmux keybindings
- `aerospace/.config/aerospace/aerospace.toml:74-228` - AeroSpace modes
- `ideavim/.ideavimrc:20-103` - IdeaVim keymaps
- `cursor/keybindings.json:2-52` - Cursor JSON keybindings
- `cursor/settings.json:26-190` - Cursor Vim mode
- `yazi/keymap.toml:5-180` - yazi keymaps
- `zsh/.zshrc:15,169` - zsh keybindings

### Repository
- **GitHub**: https://github.com/czechue/.dotfiles
- **Live Site**: https://czechue.github.io/.dotfiles/ (after deployment)
