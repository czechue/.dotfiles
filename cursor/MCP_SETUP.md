# MCP Servers Configuration

Model Context Protocol (MCP) servers installed for Cursor and Claude.

## Installed Servers

### 1. **Context7** 📚
- **Purpose:** Up-to-date documentation for libraries and frameworks
- **Usage:** `@context7 find React hooks documentation`
- **Libraries:** React, Next.js, MongoDB, TypeScript, Tailwind, etc.

### 2. **Figma Dev Mode** 🎨
- **Purpose:** Access Figma designs and generate code from mockups
- **Usage:** Share Figma link and ask AI to generate components
- **Features:** Get metadata, screenshots, design specs

### 3. **GitHub** 🐙
- **Purpose:** Repository management, PR, issues, commits
- **Usage:** `@github create issue`, `@github list PRs`
- **Setup Required:**
  ```bash
  # Generate token at: https://github.com/settings/tokens
  # Add to ~/.cursor/mcp.json and ~/.claude/mcp-servers.json
  # Replace: "<your-github-token>" with actual token
  ```

### 4. **Filesystem** 📁
- **Purpose:** Direct file system access for AI
- **Usage:** `@filesystem read /path/to/file`
- **Scope:** `/Users/michallester` (can be adjusted)

### 5. **Sequential Thinking** 🧠
- **Purpose:** Break down complex tasks into logical steps
- **Usage:** Automatically activated for complex prompts
- **Best For:** Architecture design, system decomposition, planning

### 6. **PostgreSQL** 🗄️
- **Purpose:** Natural language database queries
- **Usage:** `@postgres show users table schema`
- **Setup Required:** Update connection string in config
- **Default:** `postgresql://localhost/postgres`

### 7. **Playwright** 🎭
- **Purpose:** Browser automation, web scraping, UI testing
- **Usage:** `@playwright scrape https://example.com`
- **Features:** Screenshots, form filling, navigation

## Configuration Files

**Cursor:** `~/.cursor/mcp.json`
**Claude:** `~/.claude/mcp-servers.json`

## Setup Instructions

### 1. GitHub Token Setup

Generate a Personal Access Token:
1. Go to: https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Select scopes: `repo`, `read:org`, `workflow`
4. Copy token
5. Replace `<your-github-token>` in both config files

### 2. PostgreSQL Connection

If you have PostgreSQL installed locally:
```bash
# Test connection
psql postgresql://localhost/postgres

# Update connection string in configs if needed
# Format: postgresql://username:password@host:port/database
```

### 3. Restart Editors

After configuration changes:
- **Cursor:** Fully restart the app
- **Claude Desktop:** Quit and reopen

## Usage Examples

### Context7
```
Find the latest Next.js App Router documentation
Show me React useEffect examples
Get Tailwind CSS grid documentation
```

### GitHub
```
Create an issue titled "Fix login bug"
List all open PRs in this repository
Show recent commits by author
```

### Filesystem
```
Read all markdown files in the docs folder
Create a new file at /path/to/file.txt
List files in the current directory
```

### Sequential Thinking
```
Plan the architecture for a new e-commerce feature
Break down this complex refactoring task
Design a system for real-time notifications
```

### PostgreSQL
```
Show me the schema for the users table
Query all orders from last month
Explain the relationship between products and categories
```

### Playwright
```
Scrape product data from https://example.com/products
Take a screenshot of the homepage
Test the login form at https://myapp.com
```

## Troubleshooting

### MCP Server Not Found
```bash
# Verify npx works
npx --version

# Manually install a server
npx -y @modelcontextprotocol/server-github
```

### Connection Errors

1. Check config syntax (valid JSON)
2. Verify network connection
3. Check server logs in Cursor/Claude settings

### GitHub Authentication Failed

- Verify token has correct permissions
- Check token hasn't expired
- Ensure no extra spaces in config

## Resources

- [MCP Documentation](https://modelcontextprotocol.io)
- [Cursor MCP Directory](https://cursor.directory/mcp)
- [Claude MCP Servers](https://github.com/modelcontextprotocol/servers)
- [MCP Index](https://mcpindex.net)

## Statistics

- **40%** reduction in tool switching (Anthropic 2025 data)
- **6280+** available MCP servers
- **12k** stars on GitHub MCP server repository
