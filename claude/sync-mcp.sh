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
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
echo -e "${YELLOW}  Syncing MCP servers from .dotfiles${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════${NC}\n"

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo -e "${RED}Error: jq is not installed${NC}"
    echo -e "Install with: brew install jq"
    exit 1
fi

# Check if source file exists
if [ ! -f "$DOTFILES_MCP" ]; then
    echo -e "${RED}Error: Source file not found${NC}"
    echo -e "Expected: ${DOTFILES_MCP}"
    exit 1
fi

# Check if target file exists
if [ ! -f "$CLAUDE_CONFIG" ]; then
    echo -e "${RED}Error: Target file not found${NC}"
    echo -e "Expected: ${CLAUDE_CONFIG}"
    exit 1
fi

# Validate source file has mcpServers key
if ! jq -e '.mcpServers' "$DOTFILES_MCP" > /dev/null 2>&1; then
    echo -e "${RED}Error: ${DOTFILES_MCP} missing 'mcpServers' key${NC}"
    exit 1
fi

# Extract mcpServers from both files
DOTFILES_SERVERS=$(jq '.mcpServers' "$DOTFILES_MCP")
CURRENT_SERVERS=$(jq '.mcpServers // {}' "$CLAUDE_CONFIG")

# Check if there are any changes
if [ "$DOTFILES_SERVERS" == "$CURRENT_SERVERS" ]; then
    echo -e "${GREEN}✓ MCP servers already up to date - no sync needed${NC}"
    exit 0
fi

# Show what will be synced
echo -e "${YELLOW}Servers to sync:${NC}"
jq -r '.mcpServers | keys[]' "$DOTFILES_MCP" | sed 's/^/  ✓ /'
echo ""

# Backup current config
echo -e "Creating backup: ${BLUE}${BACKUP_CONFIG}${NC}"
cp "$CLAUDE_CONFIG" "$BACKUP_CONFIG"

# Merge into ~/.claude.json
jq --argjson mcpServers "$DOTFILES_SERVERS" '.mcpServers = $mcpServers' "$CLAUDE_CONFIG" > "${CLAUDE_CONFIG}.tmp"

# Verify the output is valid JSON
if ! jq empty "${CLAUDE_CONFIG}.tmp" 2>/dev/null; then
    echo -e "${RED}Error: Generated invalid JSON${NC}"
    rm "${CLAUDE_CONFIG}.tmp"
    exit 1
fi

# Replace original file
mv "${CLAUDE_CONFIG}.tmp" "$CLAUDE_CONFIG"

echo -e "\n${GREEN}✓ MCP servers synced successfully!${NC}"
echo -e "${BLUE}Backup saved to: ${BACKUP_CONFIG}${NC}"
echo -e "\n${GREEN}Synced ${BOLD}$(jq '.mcpServers | length' "$CLAUDE_CONFIG")${NC}${GREEN} servers${NC}"
echo -e "\n${YELLOW}Remember to restart Claude Code to load new configuration${NC}"
