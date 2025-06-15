# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Codebase Overview

This is an AeroSpace configuration - AeroSpace is an i3-like tiling window manager for macOS that automatically arranges windows without requiring System Integrity Protection (SIP) to be disabled.

## Architecture

The configuration follows the XDG Base Directory specification:

- **`.config/aerospace/aerospace.toml`**: Main configuration file in TOML format
- Configuration is organized into sections:
  - Startup settings and auto-start behavior
  - Layout defaults (tiling, padding, orientation)
  - Normalization settings for window arrangement
  - Key bindings for window management
  - Workspace configurations
  - Binding modes (main and service modes)

## Common Commands

### Window Management
- `alt-[hjkl]` - Focus windows in vim-style directions
- `alt-shift-[hjkl]` - Move windows in vim-style directions
- `alt-shift-minus/equal` - Resize windows (decrease/increase)
- `alt-slash` - Toggle between horizontal and vertical split
- `alt-comma` - Switch to accordion layout

### Workspace Navigation
- `alt-[1-9]` - Switch to workspace 1-9
- `alt-shift-[1-9]` - Move focused window to workspace 1-9
- `alt-tab` - Switch between current and previous workspace
- `alt-shift-tab` - Move workspace to next monitor

### Service Mode Commands
Access with `alt-shift-semicolon`:
- `esc` - Reload config and return to main mode
- `r` - Reset workspace layout (flatten containers)
- `f` - Toggle floating/tiling for focused window
- `backspace` - Close all windows except focused

## Configuration Style

When modifying:
1. Follow TOML syntax and existing formatting
2. Keep related key bindings grouped together
3. Comment new bindings to explain their purpose
4. Test configuration with service mode reload (`alt-shift-semicolon` then `esc`)
5. Be careful with workspace assignments - they affect window placement

## External Dependencies

- AeroSpace installed via Homebrew: `brew install --cask aerospace`
- No SIP disabling required
- Works with macOS native features

## Key Concepts

- **Tiling**: Windows automatically arrange in non-overlapping grid
- **Workspaces**: Virtual desktops numbered 1-9 (A-Z available but commented)
- **Accordion Layout**: Special layout with configurable padding
- **Normalization**: Automatic flattening of nested window containers
- **Focus Follows Mouse**: Optional setting for monitor switching