# Dotfiles

Personal development environment configuration for macOS with support for terminal tools, text editors, and IDE integrations.

**📚 [View Keybindings Documentation](https://czechue.github.io/.dotfiles/)** - Comprehensive keyboard shortcuts reference for all tools.

## Overview

This repository contains configurations for:
- **Shell**: Zsh with Oh-My-Zsh, fzf, zoxide
- **Terminal**: tmux with TPM plugins
- **Editors**: Neovim (Kickstart-based), IdeaVim, Cursor IDE
- **Tools**: yazi file manager, AeroSpace window manager (macOS)
- **AI**: Claude Code CLI with MCP servers
- **Version Management**: Mise for Node.js, Ruby, Python, Go, and more

## Quick Start (macOS)

### Prerequisites

1. **Install Xcode Command Line Tools**
   ```bash
   xcode-select --install
   ```

2. **Install Homebrew**
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

### Installation

1. **Clone this repository**
   ```bash
   git clone https://github.com/yourusername/.dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Install core tools**
   ```bash
   brew install git make unzip gcc jq ripgrep fd fzf zoxide \
                tmux neovim yazi duckdb lazygit mise

   # macOS-specific
   brew install --cask aerospace
   ```

3. **Install Oh-My-Zsh**
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

4. **Install zsh-vi-mode plugin**
   ```bash
   git clone https://github.com/jeffreytse/zsh-vi-mode \
     ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
   ```

5. **Install TPM (Tmux Plugin Manager)**
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

6. **Install tmuxifier**
   ```bash
   git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
   ```

7. **Setup Mise for language runtimes**
   ```bash
   # Mise is already installed via Homebrew in step 2
   # Create global configuration
   mkdir -p ~/.config/mise
   cat > ~/.config/mise/config.toml <<EOF
   [tools]
   node = "lts"
   ruby = "3.3"
   python = "3.12"
   go = "latest"
   EOF

   # Install runtimes
   mise install
   ```

8. **Create symlinks**

   ```bash
   # Zsh
   ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc

   # Tmux
   ln -sf ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

   # Neovim
   ln -sf ~/.dotfiles/nvim/.config/nvim ~/.config/nvim

   # Yazi
   ln -sf ~/.dotfiles/yazi ~/.config/yazi

   # IdeaVim
   ln -sf ~/.dotfiles/ideavim/.ideavimrc ~/.ideavimrc

   # AeroSpace
   mkdir -p ~/.config/aerospace
   ln -sf ~/.dotfiles/aerospace/.config/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml

   # Cursor IDE
   mkdir -p ~/Library/Application\ Support/Cursor/User
   ln -sf ~/.dotfiles/cursor/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
   ln -sf ~/.dotfiles/cursor/keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json

   # Claude Code CLI
   mkdir -p ~/.claude
   ln -sf ~/.dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
   ln -sf ~/.dotfiles/claude/settings.json ~/.claude/settings.json

   # Make bin scripts executable
   chmod +x ~/.dotfiles/bin/tmux-sessionizer
   ```

9. **Setup Claude Code MCP servers** (optional)

   Create `~/.dotfiles/claude/mcp-servers.json` with your API keys:
   ```bash
   cp ~/.dotfiles/claude/mcp-servers.json.template ~/.dotfiles/claude/mcp-servers.json
   # Edit the file and add your API keys
   nano ~/.dotfiles/claude/mcp-servers.json
   ```

   Then sync:
   ```bash
   ~/.dotfiles/claude/sync-mcp.sh
   ```

10. **Install yazi DuckDB plugin**
    ```bash
    ya pack -a wylie102/duckdb
    ```

11. **Restart your shell**
    ```bash
    exec zsh
    ```

12. **Install tmux plugins**

    Open tmux and press `Ctrl+b` then `I` (capital I) to install plugins.

13. **Launch Neovim for first-time setup**
    ```bash
    nvim
    ```

    Neovim will automatically:
    - Install lazy.nvim plugin manager
    - Install all plugins
    - Mason will install LSP servers on first file open

    Verify with `:checkhealth`

## Configuration Structure

```
.dotfiles/
├── aerospace/          # AeroSpace window manager (macOS)
├── bin/                # Utility scripts (tmux-sessionizer)
├── claude/             # Claude Code CLI configuration
├── cursor/             # Cursor IDE settings
├── ideavim/            # IntelliJ IDEA Vim plugin
├── nvim/               # Neovim configuration
├── tmux/               # Tmux configuration
├── yazi/               # Yazi file manager
├── zsh/                # Zsh shell configuration
├── .dotfiles-personal/ # Personal git context
└── .dotfiles-fourthwall/ # Work git context
```

## Key Features

### Shell (Zsh)
- Oh-My-Zsh framework with minimal plugins
- Vi mode with `zsh-vi-mode` plugin
- fzf for fuzzy finding
- zoxide for smart directory jumping
- Mise for unified runtime version management
- Custom keybindings (`Ctrl+F` for tmux-sessionizer)

### Tmux
- Vim-style navigation with `Ctrl+hjkl`
- Catppuccin Mocha theme
- TPM plugin manager
- lazygit integration (`Ctrl+b G`)
- tmux-sessionizer for quick project switching

### Neovim
- Based on Kickstart.nvim
- lazy.nvim plugin manager with auto-bootstrap
- Mason for LSP server management
- Telescope for fuzzy finding
- Tree-sitter for syntax highlighting
- nvim-cmp for autocompletion
- Codeium AI integration (toggleable)
- Harpoon for quick file navigation
- LazyGit integration

### Yazi
- Terminal file manager with DuckDB plugin
- CSV/Parquet/JSON data file preview
- Catppuccin Mocha theme
- fzf and zoxide integration

### Claude Code CLI
- Global instructions in CLAUDE.md
- MCP servers for web search, documentation, and reasoning
- Special sync workflow for configuration

## Important Commands

### Tmux
```bash
# Reload config
tmux source-file ~/.tmux.conf
# or inside tmux: Ctrl+b r

# Open lazygit
Ctrl+b G

# Switch/create project session
Ctrl+F  # (or from shell)
```

### Neovim
```bash
# Check health
:checkhealth

# Update plugins
:Lazy sync

# Manage LSP servers
:Mason

# Open LazyGit
<leader>gg  # (Space+g+g)

# Harpoon file navigation
<leader>a   # Add file
<leader>h   # Show menu
<leader>1-5 # Jump to file
```

### Mise
```bash
# List installed runtimes
mise list

# Install runtime
mise install node@20

# Use specific version in project
cd ~/my-project
echo 'node = "20.0.0"' > .mise.toml
mise install

# Check setup
mise doctor
```

### Yazi
```bash
# Launch (with cd-on-exit wrapper)
y

# Inside yazi:
z  # fzf jump
Z  # zoxide jump
s  # search by name (fd)
S  # search by content (ripgrep)
```

### Claude Code MCP
```bash
# Sync MCP servers after updating config
~/.dotfiles/claude/sync-mcp.sh
# Then restart Claude Code
```

## Updating Configurations

1. **Pull latest changes**
   ```bash
   cd ~/.dotfiles
   git pull
   ```

2. **Reload configurations**
   ```bash
   # Zsh
   source ~/.zshrc

   # Tmux (inside tmux)
   # Ctrl+b r

   # Neovim - restart or :source %

   # Claude Code MCP
   ~/.dotfiles/claude/sync-mcp.sh
   ```

## Platform Support

### macOS (Primary)
- Full support for all configurations
- AeroSpace window manager
- Cursor IDE with native paths

### Linux (Partial)
Most tools work on Linux with minor adjustments:
- Replace AeroSpace with i3/sway/awesome
- Adjust Cursor paths to `~/.config/Code/User/`
- Install `xclip` or `xsel` for clipboard
- Use system package manager instead of Homebrew

See `thoughts/shared/research/2025-11-23-ansible-setup-requirements.md` for detailed cross-platform analysis.

## Troubleshooting

### Neovim issues
```bash
# Check dependencies
:checkhealth

# Clear plugin cache
rm -rf ~/.local/share/nvim
# Restart Neovim to reinstall
```

### Tmux plugins not loading
```bash
# Reinstall TPM
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Inside tmux: Ctrl+b I
```

### Mise not finding runtimes
```bash
# Check doctor
mise doctor

# Verify PATH
echo $PATH | grep mise

# Reinstall activation
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
```

### Claude Code MCP servers not working
```bash
# Verify Node.js is installed
node --version

# Check MCP config
cat ~/.claude.json | jq '.mcpServers'

# Re-sync
~/.dotfiles/claude/sync-mcp.sh
```

## Contributing

This is a personal dotfiles repository, but feel free to:
- Fork for your own use
- Open issues for bugs
- Submit PRs for improvements

## License

MIT License - feel free to use and modify as needed.

## Additional Resources

- [CLAUDE.md](./CLAUDE.md) - Project-specific instructions for Claude Code
- [Research Document](./thoughts/shared/research/2025-11-23-ansible-setup-requirements.md) - Detailed analysis for Ansible automation
- [Neovim Kickstart](https://github.com/nvim-lua/kickstart.nvim) - Base configuration
- [Mise Documentation](https://mise.jdx.dev/) - Runtime version manager
