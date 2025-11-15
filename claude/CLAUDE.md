# Global Instructions for Claude Code

**IMPORTANT: Current date is 2025-11-15** (Claude Code doesn't know today's date)

## Language & Communication

- **ALWAYS use English** in all code, comments, documentation, commit messages, and file names
- Exception: Polish is allowed ONLY in user-facing UI strings and documentation for Polish users

## MCP Tools Usage

### Web Search & Research

**YOU MUST follow these rules when searching for information:**

#### For General Web Search:
- **ALWAYS use `mcp__mcp-omnisearch__web_search`** with providers: `tavily`, `brave`, or `kagi`
- Use `tavily` for factual information with citations
- Use `brave` for privacy-focused searches with query operators (`site:`, `filetype:`, etc.)

#### For Complex Questions Requiring Reasoning:
- **YOU MUST use `mcp__mcp-omnisearch__ai_search`** with provider `perplexity`
- **NEVER use `web_search` with `perplexity`** - it will fail
- Examples: architectural decisions, best practices, comparing approaches

#### For Library/Framework Documentation:
- **ALWAYS use Context7 MCP** (`context7` server) when questions involve:
  - Specific library APIs or methods
  - Framework-specific patterns
  - Official documentation lookup
  - Technical specifications

**Pattern to follow:**
```
If [searching for facts] → use web_search (tavily/brave)
If [complex reasoning needed] → use ai_search (perplexity)
If [library documentation] → use context7
```

## Git Workflow & Version Control

### Branch Strategy
- **ALWAYS create a new branch** for each task/feature before making changes
- Branch naming: `feature/description` or `fix/description` or `refactor/description`
- This provides a safety net to easily discard changes if needed

### Commit Practices
- Use conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`
- Keep commits **atomic and focused** - one logical change per commit
- Write meaningful commit messages explaining **why**, not what
- **NEVER use `--no-verify`** to bypass commit hooks
- **NEVER commit code that doesn't compile or breaks tests**

### Review Process
- Always show diffs for review before applying major changes
- Prefer **incremental changes** over monolithic rewrites
- Create a **plan first**, then execute step by step

## Code Quality Standards

### General Principles
- Follow existing codebase patterns and conventions
- Use ES modules (`import/export`) over CommonJS when possible
- Prefer functional programming patterns where appropriate
- Write code that is **readable and maintainable** over clever

### Testing
- Write tests for new functionality (aim for meaningful coverage)
- Tests should be **deterministic** and **behavior-focused**
- Use existing test utilities and patterns from the project
- **Fix failing tests**, never disable them

### Quality Gates - Definition of Done
- [ ] Code follows project conventions
- [ ] Tests written and passing
- [ ] No linter/formatter warnings
- [ ] Implementation matches the plan
- [ ] No TODOs without tracking issue numbers

## Development Process

### Plan Before Execute
**IMPORTANT:** For complex tasks:
1. First create a **detailed plan** with steps
2. Show the plan for review
3. Execute incrementally
4. Avoid monolithic rewrites that are hard to debug

### Learning the Codebase
- Find 3 similar features/components first
- Identify common patterns and conventions
- Use same libraries/utilities when possible
- **Don't introduce new tools** without strong justification

### Error Handling
- **Stop after 3 failed attempts** and reassess approach
- Never make assumptions - verify with existing code
- Log meaningful error messages, not just stack traces

## Personal Preferences

- Use `make install` for project setup when Makefile is present
- Prefer clarity over brevity in variable names
- Keep functions small and focused (single responsibility)

## Important Reminders

**YOU MUST:**
- Commit working code incrementally
- Update plan documentation as you progress
- Learn from existing implementations before creating new ones

**NEVER:**
- Disable tests instead of fixing them
- Use `--no-verify` on git commands
- Make breaking changes without discussing first
- Leave debugging code (console.logs, etc.) in commits