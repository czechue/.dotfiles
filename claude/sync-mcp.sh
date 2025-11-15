#!/bin/bash
# Sync MCP servers configuration from .dotfiles to ~/.claude.json

set -e  # Exit on error

DOTFILES_MCP="$HOME/.dotfiles/claude/mcp-servers.json"
CLAUDE_CONFIG="$HOME/.claude.json"
BACKUP_CONFIG="$HOME/.claude.json.backup-$(date +%Y%m%d-%H%M%S)"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Syncing MCP servers from .dotfiles to ~/.claude.json${NC}"

# Check if source file exists
if [ ! -f "$DOTFILES_MCP" ]; then
    echo -e "${RED}Error: $DOTFILES_MCP not found${NC}"
    exit 1
fi

# Check if target file exists
if [ ! -f "$CLAUDE_CONFIG" ]; then
    echo -e "${RED}Error: $CLAUDE_CONFIG not found${NC}"
    exit 1
fi

# Backup current config
echo -e "Creating backup: ${BACKUP_CONFIG}"
cp "$CLAUDE_CONFIG" "$BACKUP_CONFIG"

# Extract mcpServers from dotfiles
MCP_SERVERS=$(jq '.mcpServers' "$DOTFILES_MCP")

# Merge into ~/.claude.json
jq --argjson mcpServers "$MCP_SERVERS" '.mcpServers = $mcpServers' "$CLAUDE_CONFIG" > "${CLAUDE_CONFIG}.tmp"

# Replace original file
mv "${CLAUDE_CONFIG}.tmp" "$CLAUDE_CONFIG"

echo -e "${GREEN}✓ MCP servers synced successfully!${NC}"
echo -e "Backup saved to: ${BACKUP_CONFIG}"
echo -e "\nSynced servers:"
jq -r '.mcpServers | keys[]' "$CLAUDE_CONFIG" | sed 's/^/  - /'
