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
