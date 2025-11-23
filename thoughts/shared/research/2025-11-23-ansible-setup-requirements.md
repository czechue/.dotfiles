---
date: 2025-11-23T12:34:07+0000
researcher: michallester
git_commit: 2d87d799b30b29b324d3f97aca1277504d0c5edd
branch: master
repository: .dotfiles
topic: "Analysis of dotfiles project for Ansible setup requirements (macOS and Linux)"
tags: [research, codebase, ansible, automation, dotfiles, macos, linux, configuration-management]
status: complete
last_updated: 2025-11-23
last_updated_by: michallester
---

# Research: Dotfiles Project Analysis for Ansible Setup Requirements

**Date**: 2025-11-23T12:34:07+0000
**Researcher**: michallester
**Git Commit**: 2d87d799b30b29b324d3f97aca1277504d0c5edd
**Branch**: master
**Repository**: .dotfiles

## Research Question
Analyze the entire dotfiles project to gather information needed for creating an Ansible setup that can run on any new computer (both macOS and Linux).

## Summary
This dotfiles repository manages development tool configurations primarily for macOS, using a modular structure with manual symlinks and minimal automation. The repository contains configurations for 11 major tools: AeroSpace window manager, Neovim, tmux, yazi file manager, Zsh shell, IdeaVim, Cursor IDE, Claude Code CLI, and utility scripts. The setup requires extensive dependencies including Homebrew, **Mise unified runtime version manager** (for Node.js, Ruby, Python, Go, Zig), terminal tools (fzf, ripgrep, zoxide), and various application-specific plugins. While most tools are cross-platform compatible, some (AeroSpace, Cursor with macOS paths) are macOS-specific, requiring platform conditionals in Ansible automation.

## Detailed Findings

### Project Structure and Components

The repository follows a modular architecture with each tool in its own directory:

**Core Components** ([CLAUDE.md:9-21](CLAUDE.md:9-21)):
- **aerospace/** - AeroSpace window manager (macOS-only, i3-like)
- **nvim/** - Neovim config based on Kickstart.nvim with lazy.nvim
- **tmux/** - Terminal multiplexer with vim-style navigation
- **yazi/** - Terminal file manager with DuckDB plugin for data files
- **zsh/** - Zsh shell with zoxide and yazi wrapper
- **ideavim/** - IntelliJ IDEA Vim emulation
- **cursor/** - Cursor IDE with Vim mode and IntelliJ keybindings
- **claude/** - Claude Code CLI global configuration
- **bin/** - Utility scripts (tmux-sessionizer)
- **.dotfiles-personal/** - Personal git configuration context
- **.dotfiles-fourthwall/** - Work git configuration context

### Configuration Files and Locations

**Symlink Structure** ([CLAUDE.md:34-40](CLAUDE.md:34-40)):
```bash
# Standard Unix locations (cross-platform)
ln -s ~/.dotfiles/ideavim/.ideavimrc ~/.ideavimrc
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/yazi ~/.config/yazi
ln -sf ~/.dotfiles/nvim/.config/nvim ~/.config/nvim

# macOS-specific locations
ln -s ~/.dotfiles/aerospace/.config/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
ln -sf ~/.dotfiles/cursor/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
ln -sf ~/.dotfiles/cursor/keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json

# Claude Code (special handling)
ln -sf ~/.dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/.dotfiles/claude/settings.json ~/.claude/settings.json
# MCP servers cannot be symlinked - uses sync script
```

### Dependencies and Required Tools

#### Package Managers
- **Homebrew** (macOS primary) - Referenced in [zsh/.zshrc:13](zsh/.zshrc:13), [claude/sync-mcp.sh:24](claude/sync-mcp.sh:24)
- **npm/npx** - Required for MCP servers ([claude/mcp-servers.json.template:4-23](claude/mcp-servers.json.template:4-23))

#### Programming Languages (Managed via Mise)
- **Mise** - Unified runtime version manager ([zsh/.zshrc:171](zsh/.zshrc:171))
  - Replaces: chruby (Ruby), fnm (Node), asdf
  - Manages: Node.js, Ruby, Python, Go, and 100+ other runtimes
  - Configuration: `.mise.toml` or `.tool-versions` files
  - Installation: `curl https://mise.run | sh` or via package manager
- **Node.js** - MCP servers, JavaScript tooling (via Mise)
- **Ruby** - Development (via Mise, replaces chruby)
- **Python** - Development (via Mise)
- **Go** - Air live reload tool [zsh/.zshrc:10](zsh/.zshrc:10) (can be managed via Mise)
- **Zig** - [zsh/.zshrc:26,149](zsh/.zshrc:26,149) (can be managed via Mise)

#### Core Command-Line Tools
- **git** - Version control, plugin installation
- **make** - Build tool (Neovim, Telescope)
- **unzip** - Archive extraction
- **gcc/clang** - C compiler (Tree-sitter parsers)
- **jq** - JSON processor ([claude/sync-mcp.sh:22-26](claude/sync-mcp.sh:22-26))
- **ripgrep** - Fast searching ([nvim/.config/nvim/init.lua:486-496](nvim/.config/nvim/init.lua:486-496))
- **fd** - File finding ([yazi/keymap.toml:82](yazi/keymap.toml:82))
- **fzf** - Fuzzy finder ([zsh/.zshrc:148](zsh/.zshrc:148), [bin/tmux-sessionizer:23](bin/tmux-sessionizer:23))
- **zoxide** - Smart cd ([zsh/.zshrc:192](zsh/.zshrc:192))

#### Terminal Applications
- **tmux** - Multiplexer with TPM plugin manager ([tmux/.tmux.conf:32-41](tmux/.tmux.conf:32-41))
- **Neovim** - Text editor with Mason LSP installer
- **yazi** - File manager with DuckDB plugin
- **lazygit** - Git TUI ([tmux/.tmux.conf:19](tmux/.tmux.conf:19))

#### Platform-Specific Tools
- **AeroSpace** (macOS only) - Tiling window manager
- **Cursor IDE** - Uses macOS paths `~/Library/Application Support/`

### Setup Process and Scripts

The repository uses manual symlinks with only two automation scripts:

#### 1. MCP Sync Script ([claude/sync-mcp.sh](claude/sync-mcp.sh))
- Merges MCP server config from dotfiles into `~/.claude.json`
- Preserves runtime state while updating configuration
- Creates timestamped backups
- Requires `jq` for JSON processing

#### 2. Tmux Sessionizer ([bin/tmux-sessionizer](bin/tmux-sessionizer))
- Fuzzy-finds directories for project switching
- Creates/switches tmux sessions
- Bound to `Ctrl+F` in both shell and tmux

### Platform-Specific Configurations

#### macOS-Only Components
- **AeroSpace** - Window manager ([aerospace/CLAUDE.md:55](aerospace/CLAUDE.md:55))
- **Cursor paths** - `~/Library/Application Support/Cursor/User/`
- **Dropbox path** - `~/Library/CloudStorage/Dropbox` ([bin/tmux-sessionizer:23](bin/tmux-sessionizer:23))

#### Cross-Platform Tools
- **tmux**, **Neovim**, **Zsh** - Work on all Unix-like systems
- **yazi** - Has explicit platform conditionals ([yazi/yazi.toml:33-57](yazi/yazi.toml:33-57)):
  - `for = "unix"`: nvim, extract, mpv
  - `for = "macos"`: open commands
  - `for = "linux"`: xdg-open
  - `for = "windows"`: explorer, start
  - `for = "android"`: termux-open

### Special Configurations

#### Claude Code MCP Servers
**Architecture** ([claude/README.md:17-20](claude/README.md:17-20)):
- Cannot symlink `~/.claude.json` (contains runtime state)
- Uses sync script to merge `mcpServers` key only
- API keys in gitignored `mcp-servers.json`
- Template file tracks structure

**Configured Servers**:
- **context7** - Library documentation
- **mcp-sequentialthinking-tools** - Task breakdown
- **mcp-omnisearch** - Web search with 5 API keys

#### Neovim Configuration
**Based on Kickstart.nvim** ([nvim/.config/nvim/init.lua:254-264](nvim/.config/nvim/init.lua:254-264)):
- Auto-bootstraps lazy.nvim plugin manager
- Mason auto-installs LSP servers
- Tree-sitter auto-compiles parsers
- No manual installation required

**Key Dependencies**:
- git, make, unzip, C compiler
- ripgrep for Telescope grep
- Clipboard tool (pbcopy on macOS, xclip on Linux)
- Optional: Nerd Font for icons

#### Tmux Plugin Management
**TPM Setup** ([tmux/.tmux.conf:32-41](tmux/.tmux.conf:32-41)):
- Requires manual TPM installation: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
- Plugins install with `Ctrl+b I`
- 7 plugins including Catppuccin theme, vim-navigator

## Ansible Implementation Requirements

### Installation Order
1. **System Prerequisites**
   - Xcode Command Line Tools (macOS: `xcode-select --install`)
   - Build essentials (Linux: `build-essential`)

2. **Package Managers**
   - Homebrew (macOS) / apt/dnf/pacman (Linux)

3. **Core Tools** (via package manager)
   - git, make, unzip, gcc/clang, jq
   - ripgrep, fd, fzf, zoxide
   - tmux, neovim, yazi, lazygit

4. **Mise - Unified Runtime Version Manager**
   - Install Mise: `curl https://mise.run | sh` or `brew install mise` (macOS) / `apt install mise` (Ubuntu)
   - Initialize in shell: `mise activate zsh`
   - Configure global runtimes in `~/.config/mise/config.toml`:
     ```toml
     [tools]
     node = "lts"
     ruby = "3.3"
     python = "3.12"
     go = "latest"
     ```
   - Install runtimes: `mise install`
   - **Benefits over separate managers:**
     - Single tool replaces: chruby, fnm, asdf, pyenv, goenv
     - Unified configuration format
     - Faster than asdf (written in Rust)
     - Per-project version management via `.mise.toml`

5. **Shell Setup**
   - Oh-My-Zsh framework
   - zsh-vi-mode plugin

6. **Plugin Managers**
   - TPM for tmux
   - tmuxifier

7. **Symlink Creation**
   - Create required directories
   - Establish all symlinks
   - Set executable permissions on scripts

8. **Post-Installation**
   - Run MCP sync script (requires Node.js via Mise)
   - Install tmux plugins
   - First Neovim launch (auto-bootstrap)

### Platform Conditionals Needed

```yaml
# Example Ansible conditions
- name: Install AeroSpace (macOS only)
  when: ansible_os_family == 'Darwin'

- name: Set Cursor IDE path
  set_fact:
    cursor_path: "{{ '~/Library/Application Support/Cursor/User' if ansible_os_family == 'Darwin' else '~/.config/Code/User' }}"

- name: Adjust Dropbox path
  set_fact:
    dropbox_path: "{{ '~/Library/CloudStorage/Dropbox' if ansible_os_family == 'Darwin' else '~/Dropbox' }}"
```

### Secret Management
- Store API keys in Ansible Vault
- Template `claude/mcp-servers.json` with encrypted values
- Ensure proper permissions (600) on sensitive files

### Idempotency Considerations
- MCP sync script has built-in change detection
- Use `state: link` with `force: yes` for symlinks
- Check for existing installations before cloning repos
- Preserve existing backups and runtime state

## Architecture Documentation

### Design Patterns
1. **Modular Tool Structure** - Each tool isolated in its directory
2. **Manual Symlinks** - No monolithic install script, explicit control
3. **Split Configuration** - Runtime state separate from config (Claude)
4. **Auto-bootstrapping** - Neovim self-installs dependencies
5. **Platform Conditionals** - Tools handle their own OS detection (yazi)

### Configuration Synchronization
- Vim configurations kept similar across Neovim, IdeaVim, and Cursor
- Shared keybindings: Space leader, Ctrl+hjkl navigation
- Common prefixes: Space+s (search), Space+g (git), Space+r (refactor)

## Key Differences for Linux

### Path Adjustments
- Cursor: `~/.config/Code/User/` instead of `~/Library/Application Support/`
- Dropbox: `~/Dropbox` instead of `~/Library/CloudStorage/Dropbox`
- No AeroSpace (use i3/sway/awesome instead)

### Package Manager Translations
- Replace `brew install` with `apt/dnf/pacman install`
- Some package names differ (e.g., `ripgrep` vs `rg`)
- Build tools: `build-essential` (Debian) vs `base-devel` (Arch)

### Clipboard Tools
- Linux: Install `xclip` or `xsel`
- macOS: Use built-in `pbcopy/pbpaste`

## Open Questions

1. **Git Context Switching** - Mechanism for personal/work configs not documented
2. **Version Pinning** - No versions specified for most tools
3. **Backup Retention** - MCP sync creates unlimited backups
4. **Network Dependencies** - MCP servers download on first run via npx
5. **Font Installation** - Nerd Fonts installation process varies by platform

## Related Research
- No existing research documents found in thoughts/ directory for this topic

## Recommendations for Ansible Playbook

1. **Use Role Structure**
   ```
   roles/
   ├── common/          # Cross-platform tools
   ├── macos/           # AeroSpace, macOS paths
   ├── linux/           # Linux-specific adjustments
   ├── mise/            # Runtime version management
   ├── dotfiles/        # Symlink management
   └── secrets/         # API key handling
   ```

2. **Variable Files per Platform**
   - `vars/Darwin.yml` - macOS paths and packages
   - `vars/Debian.yml` - apt packages and paths
   - `vars/RedHat.yml` - dnf/yum packages

3. **Mise Configuration Management**
   - Create `~/.config/mise/config.toml` with global tool versions
   - Use `.mise.toml` in project directories for per-project versions
   - Template configuration with desired versions:
     ```yaml
     - name: Configure Mise global tools
       template:
         src: mise/config.toml.j2
         dest: ~/.config/mise/config.toml

     - name: Install Mise-managed runtimes
       shell: mise install
       args:
         creates: ~/.local/share/mise/installs
     ```

4. **Migration from Existing Version Managers**
   - Remove chruby references from `.zshrc`
   - Remove fnm initialization
   - Keep Mise activation at top of shell config
   - Verify tools work: `mise doctor`

5. **Tags for Selective Installation**
   - `--tags "minimal"` - Just shell and tmux
   - `--tags "development"` - Add Neovim, git tools, Mise runtimes
   - `--tags "complete"` - Everything including IDEs

6. **Handlers for Service Reloads**
   - Reload tmux config
   - Restart Claude Code after MCP sync
   - Source zsh configuration
   - Reshim Mise after installing new tools

7. **Validation Tasks**
   - Check symlinks point correctly
   - Verify tool installations
   - Validate Mise doctor output
   - Confirm runtime versions: `mise list`
   - Run health checks (`:checkhealth` in Neovim)