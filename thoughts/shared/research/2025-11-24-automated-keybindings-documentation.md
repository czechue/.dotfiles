---
date: 2025-11-24T00:00:00+01:00
researcher: Michal Lester
git_commit: de498b835f18b3069f714369c9474df005609ad3
branch: master
repository: .dotfiles
topic: "Automated Keybindings Documentation and GitHub Pages Deployment"
tags: [research, documentation, keybindings, github-pages, automation, dotfiles]
status: complete
last_updated: 2025-11-24
last_updated_by: Michal Lester
---

# Research: Automated Keybindings Documentation and GitHub Pages Deployment

**Date**: 2025-11-24T00:00:00+01:00
**Researcher**: Michal Lester
**Git Commit**: de498b835f18b3069f714369c9474df005609ad3
**Branch**: master
**Repository**: .dotfiles

## Research Question

How to automatically generate documentation for all keyboard shortcuts across multiple development tools (Neovim, tmux, AeroSpace, yazi, Cursor, IdeaVim, zsh) from their configuration files, and deploy it to GitHub Pages on push to master?

## Summary

There is **no turnkey solution** for automatically parsing keybindings from multi-format dotfiles (Lua, TOML, VimScript, JSON, Shell). However, a practical hybrid approach exists:

**Recommended Solution: MkDocs Material + Partial Automation**

1. **Documentation Framework**: MkDocs Material with `pymdownx.keys` extension for beautiful keyboard shortcut rendering
2. **Partial Automation**:
   - Use Dotfyle for Neovim plugin documentation
   - Write simple regex parsers for tmux/AeroSpace (straightforward formats)
   - Manual documentation for Cursor/IdeaVim/yazi (smaller config surface)
3. **GitHub Actions Deployment**: One workflow file deploys to GitHub Pages on push to master
4. **Future Enhancement**: Build custom parsers using tree-sitter (Lua), TOML libraries, and JSON parsing

## Detailed Findings

### Current Configuration Structure

The dotfiles repository contains 7 tools with distinct configuration formats:

| Tool | Config Format | File Path | Keybinding Pattern | Complexity |
|------|--------------|-----------|-------------------|------------|
| **Neovim** | Lua | `nvim/.config/nvim/init.lua` | `vim.keymap.set()` | HIGH - multiple patterns |
| **tmux** | Shell Config | `tmux/.tmux.conf` | `bind-key <key>` | LOW - single pattern |
| **AeroSpace** | TOML | `aerospace/.config/aerospace/aerospace.toml` | `key = 'command'` | MEDIUM - TOML sections |
| **IdeaVim** | VimScript | `ideavim/.ideavimrc` | `map <key> <Action>()` | LOW - single pattern |
| **Cursor** | JSON + Vim Config | `cursor/keybindings.json`, `cursor/settings.json` | JSON + Vim bindings | MEDIUM - two formats |
| **yazi** | TOML | `yazi/keymap.toml` | `{ on = "key", run = "cmd" }` | MEDIUM - array of tables |
| **zsh** | Shell Script | `zsh/.zshrc` | `bindkey` | LOW - minimal bindings |

#### Shared Keybinding Patterns Across Tools

All configurations maintain consistent vim-style patterns:
- **Leader key**: Space (across Neovim, IdeaVim, Cursor)
- **Window navigation**: Ctrl+hjkl (Neovim, IdeaVim, Cursor, AeroSpace via Ctrl-Alt-hjkl)
- **Search prefix**: `<leader>s*` (Neovim, IdeaVim, Cursor)
- **LSP prefix**: `<leader>g*` for goto operations, `<leader>r*` for refactoring

#### Keybinding Extraction Examples

**Neovim (nvim/.config/nvim/init.lua)**
```lua
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>sf', function()
  builtin.find_files { cwd = cwd }
end, { desc = '[S]earch [F]iles' })
```
Lines 199-202, 517-555

**tmux (tmux/.tmux.conf)**
```bash
bind-key h select-pane -L
bind-key -n C-f run-shell "tmux neww tmux-sessionizer"
```
Lines 10-13, 16

**AeroSpace (aerospace/.config/aerospace/aerospace.toml)**
```toml
[mode.main.binding]
ctrl-alt-h = 'focus left'
alt-slash = 'layout tiles horizontal vertical'
```
Lines 105-108, 101-102

**IdeaVim (ideavim/.ideavimrc)**
```vim
let mapleader = ' '
map <C-h> <C-w>h
map <leader>sf <Action>(GotoFile)
```
Lines 20, 28-31, 40-45

### Documentation Generation Tools

#### 1. MkDocs Material (Recommended) ⭐

**Link**: https://squidfunk.github.io/mkdocs-material/

**Why it's recommended**:
- Built-in keyboard shortcut rendering via `pymdownx.keys` extension
- Beautiful, searchable interface with dark mode
- Simple YAML configuration
- Mature, actively developed (2024-2025)
- Perfect for technical documentation

**Keyboard Keys Extension**:
- Documentation: https://facelessuser.github.io/pymdown-extensions/extensions/keys/
- Supports 100+ keys including modifiers, function keys, navigation, media controls
- Syntax: `Press ++ctrl+alt+del++ to restart`

**Setup**:
```yaml
# mkdocs.yml
markdown_extensions:
  - pymdownx.keys
```

#### 2. VitePress (Modern Alternative)

**Link**: https://vitepress.dev/

**Features**:
- Vue.js-based, extremely fast builds (Vite-powered)
- Modern interface with hot module replacement
- Built-in search, dark mode
- Great for developers familiar with Vue

#### 3. Fumadocs (React/Next.js, 2024)

**Links**:
- https://fumadocs.dev/
- https://github.com/fuma-nama/fumadocs

**Features**:
- Beautiful React.js documentation framework
- Launched October 2024, actively developed
- MDX with syntax highlighting (Shiki)
- Multiple search options (Orama, Algolia)
- Used by Vercel, Unkey, Orama

#### 4. Specialized Tools

**keymap-drawer** (for visual keyboard layouts)
- **Link**: https://github.com/caksoylar/keymap-drawer
- Generates beautiful SVG visualizations of keymaps
- Originally for QMK/ZMK keyboard firmware
- Could potentially be extended for dotfiles

**cheatsheet-generator** (YAML to HTML)
- **Link**: https://github.com/nathanlesage/cheatsheet-generator
- Transforms keyboard shortcuts into interactive HTML cheatsheets
- Requires manual YAML input

**Dotfyle** (Neovim-specific)
- **Link**: https://dotfyle.com/
- **Guide**: https://dotfyle.com/guides/auto-generated-readme
- Automatically generates README for Neovim configs
- Detects plugins, LSP servers, leader key
- **Limitation**: Focuses on plugins, not comprehensive keybinding docs

### GitHub Pages Deployment

#### Recommended Workflow: MkDocs Material + GitHub Actions

**Official Documentation**: https://squidfunk.github.io/mkdocs-material/publishing-your-site/

**Complete GitHub Actions Workflow** (`.github/workflows/ci.yml`):
```yaml
name: ci
on:
  push:
    branches:
      - master
      - main
permissions:
  contents: write
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Configure Git Credentials
        run: |
          git config user.name github-actions[bot]
          git config user.email 41898282+github-actions[bot]@users.noreply.github.com
      - uses: actions/setup-python@v5
        with:
          python-version: 3.x
      - run: echo "cache_id=$(date --utc '+%V')" >> $GITHUB_ENV
      - uses: actions/cache@v4
        with:
          key: mkdocs-material-${{ env.cache_id }}
          path: .cache
          restore-keys: |
            mkdocs-material-
      - run: pip install mkdocs-material
      - run: mkdocs gh-deploy --force
```

**Configuration**: Simple `mkdocs.yml` in project root

**Process**:
1. On push to master, GitHub Actions triggers
2. Workflow installs Python and MkDocs Material
3. `mkdocs gh-deploy` builds site and pushes to `gh-pages` branch
4. GitHub Pages serves from `gh-pages` branch automatically

#### Alternative: Official GitHub Actions

**Documentation**: https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages

**Required Actions**:
- `actions/configure-pages@v5`
- `actions/upload-pages-artifact@v4`
- `actions/deploy-pages@v4`

**Pattern**: Separate build and deploy jobs for flexibility

#### Third-Party Action: peaceiris/actions-gh-pages

**Link**: https://github.com/peaceiris/actions-gh-pages

**Features**:
- Most popular third-party action (4.6k+ stars)
- Simplest deployment (3 lines of config)
- Automatic `GITHUB_TOKEN` authentication
- Compatible with all static site generators

**Example**:
```yaml
- name: Deploy
  uses: peaceiris/actions-gh-pages@v4
  if: github.ref == 'refs/heads/main'
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: ./public
```

### Configuration Parsing Approaches

#### Option 1: Manual Documentation (Start Here)
- Create markdown files per tool
- Use MkDocs Material's `pymdownx.keys` for rendering
- Organize by functionality (navigation, window management, etc.)
- **Pros**: Quick start, maintainable, professional output
- **Cons**: Requires manual updates when configs change

#### Option 2: Partial Automation
- **Dotfyle** for Neovim plugin documentation
- **Regex parsers** for simple formats (tmux, AeroSpace)
- **Manual** for complex/small configs (Cursor, IdeaVim, yazi)
- **Pros**: Reduces manual work for largest configs
- **Cons**: Still requires some manual maintenance

#### Option 3: Full Custom Parser (Future Enhancement)
- **Tree-sitter** for Lua parsing (Neovim)
  - Link: https://github.com/nvim-treesitter/nvim-treesitter
  - Lua grammar: https://github.com/tjdevries/tree-sitter-lua
- **TOML libraries** for AeroSpace/yazi
  - Python: built-in `tomllib`
  - Rust: https://github.com/toml-rs/toml
- **Regex** for tmux/zsh
- **JSON parsing** for Cursor
- **Pros**: Fully automated, stays in sync
- **Cons**: Significant development effort

### Extraction Patterns

**Neovim (Lua)**:
```regex
vim\.keymap\.set\('([^']+)',\s*'([^']+)',\s*([^,]+),\s*\{[^}]*desc\s*=\s*'([^']+)'
```

**tmux (Shell Config)**:
```regex
^bind(?:-key)?\s+(-n\s+)?([^ ]+)\s+(.+)$
```

**AeroSpace (TOML)**:
```regex
^([a-z0-9-]+(?:-[a-z0-9]+)*)\s*=\s*(?:'([^']+)'|\[([^\]]+)\])
```

**IdeaVim (VimScript)**:
```regex
^[nviox]?map\s+(<[^>]+>|[^ ]+)\s+<Action>\(([^)]+)\)
```

**Cursor (JSON)**:
```regex
"key":\s*"([^"]+)",\s*"command":\s*"([^"]+)"
```

**yazi (TOML)**:
```regex
\{\s*on\s*=\s*(?:"([^"]+)"|\[([^\]]+)\]),\s*run\s*=\s*"([^"]+)",\s*desc\s*=\s*"([^"]+)"\s*\}
```

**zsh (Shell Script)**:
```regex
bindkey\s+(?:-s\s+)?'([^']+)'\s+"([^"]+)"
```

## Code References

Configuration file locations:
- `nvim/.config/nvim/init.lua:160-216` - Core keymaps
- `nvim/.config/nvim/init.lua:517-555` - Telescope keymaps
- `nvim/.config/nvim/init.lua:619-677` - LSP keymaps
- `nvim/.config/nvim/lua/custom/plugins/init.lua:44-64` - Plugin keymaps
- `tmux/.tmux.conf:2-25` - tmux keybindings
- `aerospace/.config/aerospace/aerospace.toml:74-228` - AeroSpace modes and bindings
- `ideavim/.ideavimrc:20-103` - IdeaVim keymaps and descriptions
- `cursor/keybindings.json:2-52` - Cursor JSON keybindings
- `cursor/settings.json:26-190` - Cursor Vim mode keybindings
- `yazi/keymap.toml:5-180` - yazi keymaps
- `zsh/.zshrc:15,169` - zsh keybindings

## Proposed Solution

### Phase 1: Quick Start (Manual Documentation)

**Tools**:
- MkDocs Material for site generation
- `pymdownx.keys` extension for keyboard rendering
- GitHub Actions for deployment

**Setup Steps**:
1. Install: `pip install mkdocs-material`
2. Create `mkdocs.yml`:
```yaml
site_name: Dotfiles Keybindings
theme:
  name: material
  features:
    - navigation.instant
    - navigation.tabs
    - search.suggest
  palette:
    - scheme: default
      toggle:
        icon: material/brightness-7
        name: Switch to dark mode
    - scheme: slate
      toggle:
        icon: material/brightness-4
        name: Switch to light mode

markdown_extensions:
  - pymdownx.keys
  - pymdownx.tabbed:
      alternate_style: true
  - tables

nav:
  - Home: index.md
  - Neovim: neovim.md
  - tmux: tmux.md
  - AeroSpace: aerospace.md
  - yazi: yazi.md
  - Cursor: cursor.md
  - IdeaVim: ideavim.md
  - zsh: zsh.md
```

3. Create `docs/` directory with markdown files
4. Document keybindings using `++key++` syntax:
```markdown
## Window Navigation

| Keybinding | Action |
|------------|--------|
| ++ctrl+h++ | Move focus left |
| ++ctrl+j++ | Move focus down |
| ++ctrl+k++ | Move focus up |
| ++ctrl+l++ | Move focus right |
```

5. Add GitHub Actions workflow (`.github/workflows/ci.yml` - see above)
6. Push to master → automatic deployment

**Estimated Time**: 2-4 hours for initial setup + documentation

### Phase 2: Partial Automation (Optional)

**After Phase 1 is working**, consider automation:

1. **Neovim**: Use Dotfyle for plugin documentation
2. **tmux/AeroSpace**: Write simple Python scripts with regex parsing
3. **Cursor/IdeaVim/yazi**: Keep manual (smaller config surface)

**Automation Script Structure**:
```bash
docs/
├── generate.py          # Parser script
├── templates/           # Jinja2 templates for each tool
│   ├── neovim.md.j2
│   ├── tmux.md.j2
│   └── aerospace.md.j2
└── generated/           # Output markdown files
```

**Benefits**:
- Configs stay in sync with documentation
- One command updates all docs: `python docs/generate.py`

### Phase 3: Full Automation (Future)

**When manual maintenance becomes burdensome**:

1. Build tree-sitter-based Lua parser for Neovim
2. Implement TOML parser for AeroSpace/yazi
3. Add JSON parser for Cursor
4. Create unified data format (YAML/JSON)
5. Generate documentation from unified format
6. Run parser in GitHub Actions before MkDocs build

**Estimated Effort**: 10-20 hours of development

## Architecture Documentation

### Documentation Site Structure

```
.dotfiles/
├── docs/                          # MkDocs source
│   ├── index.md                  # Homepage with overview
│   ├── neovim.md                 # Neovim keybindings
│   ├── tmux.md                   # tmux keybindings
│   ├── aerospace.md              # AeroSpace keybindings
│   ├── yazi.md                   # yazi keybindings
│   ├── cursor.md                 # Cursor keybindings
│   ├── ideavim.md                # IdeaVim keybindings
│   └── zsh.md                    # zsh keybindings
├── mkdocs.yml                    # MkDocs configuration
└── .github/
    └── workflows/
        └── ci.yml                # GitHub Actions deployment
```

### Deployment Flow

```
1. git push origin master
   ↓
2. GitHub Actions triggered
   ↓
3. Workflow installs Python + MkDocs Material
   ↓
4. mkdocs gh-deploy builds site
   ↓
5. Pushes to gh-pages branch
   ↓
6. GitHub Pages serves site
   ↓
7. Site available at https://username.github.io/.dotfiles/
```

### Content Organization Strategy

**Organize by tool** (not by keybinding type) because:
- Easier to maintain alongside tool configs
- Users typically work within one tool at a time
- Allows tool-specific context and explanations

**Within each tool page**:
- **Overview** - Tool description and leader key
- **Navigation** - Movement and window management
- **Search** - File/content search operations
- **LSP** - Language server actions (where applicable)
- **Code Actions** - Refactoring and transformations
- **File Operations** - Open, save, delete, rename
- **Advanced** - Less common but powerful features

## Related Research

No previous research documents found in `thoughts/shared/research/`.

This is the first research document in this repository focusing on dotfiles documentation automation.

## Links and Resources

### Documentation Frameworks
- [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) - Recommended framework
- [pymdownx.keys Extension](https://facelessuser.github.io/pymdown-extensions/extensions/keys/) - Keyboard rendering
- [VitePress](https://vitepress.dev/) - Modern alternative
- [Fumadocs](https://fumadocs.dev/) - React-based alternative
- [Docusaurus](https://docusaurus.io/) - React with versioning

### Specialized Tools
- [keymap-drawer](https://github.com/caksoylar/keymap-drawer) - Visual keymap SVGs
- [cheatsheet-generator](https://github.com/nathanlesage/cheatsheet-generator) - YAML to HTML cheatsheets
- [Dotfyle](https://dotfyle.com/) - Neovim config documentation
- [Dotfyle Auto-README Guide](https://dotfyle.com/guides/auto-generated-readme)

### Parsers and Tools
- [luaparse](https://github.com/fstirlitz/luaparse) - Lua to AST in JavaScript
- [tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter) - Parsing library
- [toml.lua](https://github.com/LebJe/toml.lua) - TOML parser for Lua
- [toml-rs](https://github.com/toml-rs/toml) - TOML parser for Rust

### GitHub Pages Deployment
- [GitHub Pages Docs](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages)
- [MkDocs Material Publishing Guide](https://squidfunk.github.io/mkdocs-material/publishing-your-site/)
- [peaceiris/actions-gh-pages](https://github.com/peaceiris/actions-gh-pages) - Deployment action
- [VitePress Deploy Guide](https://vitepress.dev/guide/deploy)
- [Simon Willison's Minimal Example](https://til.simonwillison.net/github-actions/github-pages)

### Example Dotfiles
- [Lissy93/dotfiles](https://github.com/Lissy93/dotfiles) - Well-documented manual approach
- [mattorb/dotfiles](https://github.com/mattorb/dotfiles) - Interactive cheatsheets
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles) - Curated resources

### Community Resources
- [Dotfiles.github.io](https://dotfiles.github.io/) - Unofficial guide
- [GitHub Actions Starter Workflows](https://github.com/actions/starter-workflows/tree/main/pages)
- [Just-the-Docs Template](https://github.com/just-the-docs/just-the-docs-template) - Ready-to-use Jekyll template

## Next Steps

1. **Immediate** (1-2 hours):
   - Install MkDocs Material: `pip install mkdocs-material`
   - Create `mkdocs.yml` with configuration above
   - Create `docs/index.md` with overview
   - Test locally: `mkdocs serve`

2. **Short-term** (2-4 hours):
   - Document keybindings for 2-3 tools manually
   - Add GitHub Actions workflow
   - Test deployment to GitHub Pages
   - Refine design and organization

3. **Medium-term** (1-2 weeks):
   - Complete documentation for all tools
   - Add cross-references between tools
   - Consider adding screenshots/GIFs
   - Implement partial automation for tmux/AeroSpace

4. **Long-term** (when needed):
   - Build full automation with parsers
   - Add tree-sitter-based Neovim parser
   - Create unified keybinding data format
   - Integrate automation into GitHub Actions

## Open Questions

1. **Documentation Style**:
   - Should we group shared keybindings (e.g., all Ctrl+hjkl) across tools?
   - Or keep strictly organized by tool?
   - **Recommendation**: Start with by-tool, add cross-references later

2. **Update Frequency**:
   - How often do keybindings change?
   - Is manual sync acceptable, or is automation critical?
   - **Observation**: Keybindings change infrequently, manual maintenance likely acceptable

3. **Audience**:
   - Personal reference only?
   - Or public sharing/teaching?
   - **Impact**: Affects level of detail and explanation needed

4. **Custom Domain**:
   - Keep at `username.github.io/.dotfiles/`?
   - Or configure custom domain for cleaner URLs?
   - **Note**: Can configure custom domain in GitHub Pages settings

5. **Mobile Experience**:
   - Important to view on mobile?
   - **MkDocs Material**: Excellent mobile support out of the box
