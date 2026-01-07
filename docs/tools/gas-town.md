# Gas Town

Multi-agent orchestrator for Claude Code enabling 20-30 parallel agents with git-backed state management.

**Configuration**: `~/gt/` (town workspace)  
**GitHub**: [steveyegge/gastown](https://github.com/steveyegge/gastown)  
**Dependency**: [Beads](https://github.com/steveyegge/beads) (required)

## Quick Start

```bash
# Install
go install github.com/steveyegge/gastown/cmd/gt@latest
go install github.com/steveyegge/beads/cmd/bd@latest

# Create workspace
gt install ~/gt --git
cd ~/gt

# Add project
gt rig add myproject https://github.com/you/repo.git
gt crew add yourname --rig myproject

# Start
gt start
gt mayor attach
```

## Core Concepts

| Concept | Description |
|---------|-------------|
| **Town** | Workspace (`~/gt/`) containing all rigs and configuration |
| **Rig** | Git project under Gas Town management |
| **Beads** | Git-backed issue tracker (`.beads/issues.jsonl`) |
| **Hook** | Work queue for each agent - agents run what's on their hook |
| **GUPP** | "If your hook has work, RUN IT" - propulsion principle |
| **Molecule** | Structured workflow (linked beads) surviving crashes |
| **Formula** | Reusable workflow template (TOML) |

## Seven Roles

<div class="shortcuts-table" markdown>

| Role | Scope | Purpose |
|------|-------|---------|
| 👤 **Overseer** | Human | Strategy, review, escalations |
| 🎩 **Mayor** | Town-wide | AI coordinator (primary interface) |
| 😺 **Polecats** | Per-task | Ephemeral workers (spin → work → disappear) |
| 🏭 **Refinery** | Per-rig | Merge queue processor |
| 🦉 **Witness** | Per-rig | Monitor polecats, lifecycle management |
| 🐺 **Deacon** | Town-wide | Daemon, patrols, heartbeats |
| 🐶 **Dogs** | Town-wide | Maintenance crew |

</div>

## Gas Town Commands (gt)

### Getting Started

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `gt install ~/gt --git` | Create workspace with git | Setup |
| `gt status` | Town overview | Monitoring |
| `gt doctor` | Health check | Diagnostics |
| `gt doctor --fix` | Auto-repair issues | Maintenance |

</div>

### Rig Management

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `gt rig add <name> <url>` | Add project from GitHub | Setup |
| `gt rig add <name> <path>` | Add local project | Setup |
| `gt rig list` | Show all rigs | Management |
| `gt rig remove <name>` | Remove rig | Cleanup |

</div>

### Session Management

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `gt start` | Start Gas Town + Mayor | Startup |
| `gt shutdown` | Graceful shutdown | Shutdown |
| `gt mayor attach` | Enter Mayor session (primary) | Coordination |
| `gt <role> attach` | Attach to any role session | Navigation |
| ++ctrl+b+n++ | Next crew member | tmux Navigation |
| ++ctrl+b+p++ | Previous crew member | tmux Navigation |
| ++ctrl+b+d++ | Detach from session | tmux Control |

</div>

### Convoy (Work Tracking)

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `gt convoy create "Name" <ids>` | Create work convoy | Planning |
| `gt convoy list` | Active work dashboard | Monitoring |
| `gt convoy status <id>` | Detailed progress | Tracking |

</div>

### Work Assignment

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `gt sling <bead-id> <rig>` | Assign work to polecat | Assignment |
| `gt peek <agent>` | Check agent health | Monitoring |
| `gt nudge <agent>` | Send GUPP trigger | Unsticking |
| `gt handoff` | Request session cycle | Lifecycle |

</div>

### Communication

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `gt mail inbox` | Check your inbox | Mail |
| `gt mail send <addr> -s "..." -m "..."` | Send message | Mail |
| `gt seance` | Talk to predecessor session | Recovery |

</div>

### Dashboard

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `gt dashboard --port 8080` | Start web UI | Monitoring |
| `open http://localhost:8080` | Open dashboard | Browser |

</div>

## Beads Commands (bd)

### Issue Management

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `bd create "Title" -d "Desc"` | Create issue | Planning |
| `bd list` | List all issues | Overview |
| `bd list --status=open` | Filter by status | Filtering |
| `bd ready` | Show ready-to-work issues | Work Queue |
| `bd show <id>` | Issue details | Details |
| `bd update <id> --status=in_progress` | Update status | Tracking |
| `bd close <id>` | Mark completed | Completion |
| `bd delete <id>` | Delete issue | Cleanup |

</div>

### Epic Management

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `bd epic create "Title"` | Create epic | Planning |
| `bd epic list` | List epics | Overview |
| `bd epic show <id>` | Epic + child issues | Details |
| `bd update <id> --parent=<epic>` | Link to epic | Organization |

</div>

### Formulas & Molecules

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `bd formula list` | Available formulas | Discovery |
| `bd cook <formula>` | Formula → Protomolecule | Preparation |
| `bd mol pour <proto> --var x=y` | Proto → Molecule | Instantiation |
| `bd mol list` | List molecules | Overview |
| `bd mol status <id>` | Execution status | Tracking |
| `bd wisp <proto>` | Create ephemeral workflow | Patrols |
| `bd burn <wisp-id>` | Discard without record | Cleanup |
| `bd squash <mol-id>` | Condense to record | Archival |

</div>

### Database Operations

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `bd sync` | Sync to git | Version Control |
| `bd cleanup --days=2` | Delete old issues | Maintenance |
| `bd rebuild` | Rebuild SQLite cache | Recovery |
| `bd validate` | Check consistency | Diagnostics |
| `bd doctor` | Health check | Diagnostics |
| `bd doctor --fix` | Auto-fix | Repair |

</div>

### Search & Query

<div class="shortcuts-table" markdown>

| Command | Action | Context |
|---------|--------|---------|
| `bd search "query"` | Full-text search | Search |
| `bd grep "pattern"` | Search descriptions | Search |
| `bd list --priority=high` | Filter by priority | Filtering |
| `bd list --assignee=alice` | Filter by assignee | Filtering |
| `bd list --tags=security` | Filter by tags | Filtering |

</div>

## Workflows

### Full Stack (Recommended)

Primary Gas Town experience with Mayor as AI coordinator.

```bash
# 1. Start & attach
gt start
gt mayor attach

# 2. In Mayor, create work
"Create a convoy for issues bd-123 and bd-456 in myproject"

# 3. Monitor
gt convoy list
gt dashboard
```

### Minimal (No Tmux)

Run agents manually, Gas Town tracks state.

```bash
# 1. Create & assign
gt convoy create "Fixes" bd-123
gt sling bd-123 myproject

# 2. Start agent
claude --resume

# 3. Track
gt convoy list
```

### Crew-Based

Long-lived named agents for design work.

```bash
# 1. Create crew
gt crew add alice --rig myproject
cd ~/gt/myproject/crew/alice

# 2. Work
claude
# Use gt handoff to cycle

# 3. Navigate
# C-b n/p to cycle between crew
```

### Swarm Development

Parallel agents on multiple issues.

```bash
# 1. Plan
bd epic create "Auth System"
bd create "OAuth" --parent=auth-epic
bd create "JWT" --parent=auth-epic

# 2. Convoy & swarm
gt convoy create "Auth" bd-101 bd-102
gt sling bd-101 myproject
gt sling bd-102 myproject

# 3. Monitor
gt convoy list
gt dashboard
```

## Best Practices

### Daily Hygiene

```bash
# Morning
cd ~/gt/myproject
bd doctor
bd sync
git pull

# Evening
bd cleanup --days=2
bd sync && git push
gt shutdown
```

### Rule of Five

**Always review work 5 times before considering done.**

```bash
"Review this design"
"Review again, broader perspective"
"Review for architecture fit"
"Review for YAGNI"
"Final polish - is it as good as it can get?"
```

### Code Health (40% of Time)

```bash
# Weekly session
"Review codebase for code smells, file beads"
bd list | grep "refactor"
gt convoy create "Code Health" bd-200 bd-201
```

### Issue Tracking

- Keep database <200-500 issues
- File beads for work >2 minutes
- Use short prefixes (bd-, wy-, gt-)
- Run `bd cleanup --days=2` regularly

### Agent Lifecycle

```bash
# Restart after each task
"Let's hand off"
gt handoff

# When stuck
gt nudge polecat-1
gt peek polecat-1
gt seance
```

## Troubleshooting

<div class="shortcuts-table" markdown>

| Problem | Solution |
|---------|----------|
| Gas Town won't start | `which gt && which bd && which tmux` |
| Agent not running hook | `gt nudge <agent>` or type anything in session |
| Beads database issues | `bd rebuild && bd validate` |
| Merge conflicts | `gt refinery attach` |
| Lost work | `git log .beads/issues.jsonl` (git-backed!) |
| Too many issues (slow) | `bd cleanup --days=2` |

</div>

## Environment Setup

```bash
# Add to ~/.zshrc
export PATH="$PATH:$HOME/go/bin"
source <(gt completion zsh)

# Optional aliases
alias gts='gt status'
alias gtc='gt convoy list'
alias bdr='bd ready'
alias bdl='bd list'
```

## MEOW Stack (Advanced)

**Molecular Expression of Work** - workflow algebra.

<div class="shortcuts-table" markdown>

| Phase | Name | Storage | Purpose |
|-------|------|---------|---------|
| ❄️ Ice-9 | Formula | `.beads/formulas/` | Source template |
| 🧊 Solid | Protomolecule | `.beads/` | Frozen template |
| 💧 Liquid | Mol | `.beads/` | Flowing work |
| 💨 Vapor | Wisp | `.beads/` | Ephemeral |

</div>

**Operators**: `cook` → `pour` → `execute` → `squash`

## Resources

- **GitHub**: [steveyegge/gastown](https://github.com/steveyegge/gastown)
- **Beads**: [steveyegge/beads](https://github.com/steveyegge/beads)
- **Book**: [Vibe Coding](https://www.amazon.com/Vibe-Coding/dp/1966280025)
- **Blog**: [steve-yegge.medium.com](https://steve-yegge.medium.com)

### Key Articles

1. [Welcome to Gas Town](https://steve-yegge.medium.com/welcome-to-gas-town-4f25ee16dd04)
2. [Six New Tips](https://steve-yegge.medium.com/six-new-tips-for-better-coding-with-agents-d4e9c86e42a9)
3. [Beads Best Practices](https://medium.com/@steve-yegge/beads-best-practices-2db636b9760c)

## Status Indicators

<div class="shortcuts-table" markdown>

| Status | Meaning |
|--------|---------|
| 🟢 `complete` | All tracked items done |
| 🟢 `active` | Recent activity (< 1 min) |
| 🟡 `stale` | Activity 1-5 min ago |
| 🔴 `stuck` | Activity > 5 min ago |
| ⚪ `waiting` | No assignee/activity |

</div>

---

**Philosophy**: Gas Town is a "late 1800s factory" - powerful but dangerous. Start small, learn gradually, scale when ready.
