# Claude Code Configuration

This directory contains Claude Code CLI global configuration files.

## Files

- **CLAUDE.md** - Global instructions for Claude Code (symlinked to `~/.claude/CLAUDE.md`)
- **settings.json** - Claude Code settings (symlinked to `~/.claude/settings.json`)
- **mcp-servers.json.template** - Template for MCP servers configured via `~/.claude/mcp-servers.json`
- **mcpServers.json.template** - Template for MCP servers configured via `~/.claude.json`

## MCP Server Configuration

MCP (Model Context Protocol) servers are now configured in `~/.dotfiles/claude/mcp-servers.json` (symlinked to `~/.claude/mcp-servers.json`).

**Current setup:**
- MCP servers are defined in `.dotfiles/claude/mcp-servers.json`
- This file is **symlinked** to `~/.claude/mcp-servers.json`
- The file contains real API keys and is **gitignored** for security

**Configured servers:**
- `mcp-sequentialthinking-tools` - Sequential thinking MCP server
- `mcp-omnisearch` - Omnisearch with Tavily, Brave, Perplexity, Jina AI, and Firecrawl APIs

## Setup Instructions

```bash
# Symlink CLAUDE.md and settings.json
ln -sf ~/.dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/.dotfiles/claude/settings.json ~/.claude/settings.json

# MCP servers are already symlinked:
# ~/.claude/mcp-servers.json -> ~/.dotfiles/claude/mcp-servers.json
```

## Important Notes

- **API keys are not tracked in git** - `mcp-servers.json` is gitignored
- The `~/.claude.json` file contains only runtime state (no MCP config anymore)
- All configuration files (CLAUDE.md, settings.json, mcp-servers.json) are now symlinked from `.dotfiles`
- Backups are available in `~/.claude/*.backup` files
