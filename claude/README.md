# Claude Code Configuration

This directory contains Claude Code CLI global configuration files.

## Files

- **CLAUDE.md** - Global instructions for Claude Code (symlinked to `~/.claude/CLAUDE.md`)
- **settings.json** - Claude Code settings (symlinked to `~/.claude/settings.json`)
- **mcp-servers.json** - MCP servers configuration with real API keys (**gitignored**)
- **mcp-servers.json.template** - Template for MCP servers (without API keys, tracked in git)
- **sync-mcp.sh** - Script to sync MCP config from dotfiles to `~/.claude.json`

## MCP Server Configuration

MCP (Model Context Protocol) servers configuration is stored in `.dotfiles/claude/mcp-servers.json` and synced to `~/.claude.json` using a script.

**Why this approach?**
- `~/.claude.json` contains both MCP config AND runtime state (history, cache)
- We can't symlink the whole file (would cause git conflicts on every Claude Code run)
- Solution: keep MCP config in dotfiles, sync it to `~/.claude.json` when needed

**Current setup:**
- MCP servers are defined in `.dotfiles/claude/mcp-servers.json`
- Run `~/.dotfiles/claude/sync-mcp.sh` to sync them to `~/.claude.json`
- The file contains real API keys and is **gitignored**

**Configured servers:**
- `context7` - Context7 MCP server
- `mcp-sequentialthinking-tools` - Sequential thinking MCP server
- `mcp-omnisearch` - Omnisearch with Tavily, Brave, Perplexity, Jina AI, and Firecrawl APIs

## Setup Instructions

### Initial Setup

```bash
# Symlink CLAUDE.md and settings.json
ln -sf ~/.dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/.dotfiles/claude/settings.json ~/.claude/settings.json

# Sync MCP servers to ~/.claude.json
~/.dotfiles/claude/sync-mcp.sh
```

### Updating MCP Servers

When you add/modify MCP servers in `.dotfiles/claude/mcp-servers.json`:

```bash
# 1. Edit the config file
vim ~/.dotfiles/claude/mcp-servers.json

# 2. Sync changes to ~/.claude.json
~/.dotfiles/claude/sync-mcp.sh

# 3. Restart Claude Code to load new servers
```

The sync script will:
- Create a timestamped backup of `~/.claude.json`
- Merge MCP servers from dotfiles into `~/.claude.json`
- Preserve all runtime state (history, cache, etc.)
- Show a list of synced servers

## Important Notes

- **API keys are not tracked in git** - `mcp-servers.json` is gitignored
- The `~/.claude.json` file contains only runtime state (no MCP config anymore)
- All configuration files (CLAUDE.md, settings.json, mcp-servers.json) are now symlinked from `.dotfiles`
- Backups are available in `~/.claude/*.backup` files
