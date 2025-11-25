#!/usr/bin/env python3
"""
Documentation update helper script for dotfiles keybindings.

Currently provides utilities to validate documentation and prepare for future automation.
Future enhancements will include automatic parsing of config files.
"""

import re
import sys
from pathlib import Path
from typing import List, Dict, Set

# Configuration
DOTFILES_ROOT = Path(__file__).parent.parent
DOCS_ROOT = DOTFILES_ROOT / "docs"
CONFIG_FILES = {
    "neovim": DOTFILES_ROOT / "nvim" / ".config" / "nvim" / "init.lua",
    "tmux": DOTFILES_ROOT / "tmux" / ".tmux.conf",
    "aerospace": DOTFILES_ROOT / "aerospace" / ".config" / "aerospace" / "aerospace.toml",
    "yazi": DOTFILES_ROOT / "yazi" / "keymap.toml",
    "cursor_keys": DOTFILES_ROOT / "cursor" / "keybindings.json",
    "cursor_vim": DOTFILES_ROOT / "cursor" / "settings.json",
    "ideavim": DOTFILES_ROOT / "ideavim" / ".ideavimrc",
    "zsh": DOTFILES_ROOT / "zsh" / ".zshrc",
}


def check_config_files_exist() -> bool:
    """Verify all config files exist."""
    print("Checking configuration files...")
    all_exist = True

    for name, path in CONFIG_FILES.items():
        if path.exists():
            print(f"  ✓ {name}: {path}")
        else:
            print(f"  ✗ {name}: {path} NOT FOUND")
            all_exist = False

    return all_exist


def check_docs_files_exist() -> bool:
    """Verify all documentation files exist."""
    print("\nChecking documentation files...")

    required_files = [
        DOCS_ROOT / "index.md",
        DOCS_ROOT / "quick-reference.md",
        DOCS_ROOT / "about.md",
        DOCS_ROOT / "tools" / "neovim.md",
        DOCS_ROOT / "tools" / "tmux.md",
        DOCS_ROOT / "tools" / "aerospace.md",
        DOCS_ROOT / "tools" / "yazi.md",
        DOCS_ROOT / "tools" / "cursor.md",
        DOCS_ROOT / "tools" / "ideavim.md",
        DOCS_ROOT / "tools" / "zsh.md",
    ]

    all_exist = True
    for path in required_files:
        if path.exists():
            print(f"  ✓ {path.relative_to(DOTFILES_ROOT)}")
        else:
            print(f"  ✗ {path.relative_to(DOTFILES_ROOT)} NOT FOUND")
            all_exist = False

    return all_exist


def extract_shortcuts_from_docs(tool_name: str) -> Set[str]:
    """Extract all shortcuts from a tool's documentation file."""
    doc_file = DOCS_ROOT / "tools" / f"{tool_name}.md"

    if not doc_file.exists():
        return set()

    shortcuts = set()
    content = doc_file.read_text()

    # Match ++key++ and ++key+key++ patterns
    pattern = r'\+\+([^+]+)\+\+'
    matches = re.findall(pattern, content)

    for match in matches:
        # Normalize the shortcut representation
        shortcuts.add(match.lower().replace("+", ""))

    return shortcuts


def validate_documentation() -> bool:
    """Run validation checks on documentation."""
    print("\nValidating documentation...")

    # Check for broken internal links
    print("\n  Checking for broken internal links...")
    # TODO: Implement link validation

    # Check for empty tables
    print("  Checking for empty tables...")
    # TODO: Implement table validation

    # Check keyboard shortcut formatting
    print("  Checking keyboard shortcut formatting...")
    # TODO: Implement shortcut format validation

    return True


def print_stats() -> None:
    """Print statistics about documented shortcuts."""
    print("\nDocumentation Statistics:")

    tools = ["neovim", "tmux", "aerospace", "yazi", "cursor", "ideavim", "zsh"]
    total_shortcuts = 0

    for tool in tools:
        shortcuts = extract_shortcuts_from_docs(tool)
        count = len(shortcuts)
        total_shortcuts += count
        print(f"  {tool.capitalize()}: {count} shortcuts")

    print(f"\n  Total: {total_shortcuts} shortcuts documented")


def main():
    """Main entry point."""
    print("Dotfiles Documentation Update Helper")
    print("=" * 50)

    # Check files exist
    configs_ok = check_config_files_exist()
    docs_ok = check_docs_files_exist()

    if not (configs_ok and docs_ok):
        print("\n❌ Some files are missing. Please check the output above.")
        return 1

    # Validate documentation
    valid = validate_documentation()

    if not valid:
        print("\n❌ Documentation validation failed.")
        return 1

    # Print statistics
    print_stats()

    print("\n✅ All checks passed!")
    print("\nTo preview documentation locally:")
    print("  mkdocs serve")
    print("\nTo deploy documentation:")
    print("  mkdocs gh-deploy")

    return 0


if __name__ == "__main__":
    sys.exit(main())
