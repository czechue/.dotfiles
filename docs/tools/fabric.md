# Fabric

AI-powered content processing CLI with 245+ reusable prompts ("patterns") for summarizing, analyzing, extracting, and creating content.

**Repository**: `~/personal/Fabric` | **Binary**: `~/go/bin/fabric` | **Patterns**: `~/.config/fabric/patterns/`

## Installation

```bash
# Build from local repo (preferred over go install)
cd ~/personal/Fabric && CGO_ENABLED=0 go build \
  -ldflags "-s -w -X main.version=$(git describe --tags --abbrev=0) -X main.commit=$(git rev-parse --short HEAD)" \
  -o ~/go/bin/fabric ./cmd/fabric

# First-time setup (configures API keys and downloads patterns)
fabric --setup

# Update patterns from upstream
fabric -U
```

## Core Usage

```bash
# Pipe content into a pattern
echo "some text" | fabric -p <pattern_name>

# Process a file
cat article.md | fabric -p summarize

# YouTube transcript (auto-fetches + processes)
fabric -y "https://youtube.com/watch?v=..." -p extract_wisdom

# Use a specific model
echo "text" | fabric -p summarize -m gpt-4o

# List all patterns
fabric -l

# Stream output (default)
echo "text" | fabric -p summarize -s
```

## Best Patterns by Category

### Content Summarization

```bash
# Quick summary - the everyday workhorse
cat article.md | fabric -p summarize

# Ultra-short 5-sentence summary
cat long_report.pdf | fabric -p create_5_sentence_summary

# Micro summary - one sentence + bullet points
cat notes.md | fabric -p summarize_micro

# YouTube video summary
fabric -y "https://youtube.com/watch?v=..." -p youtube_summary
```

### Wisdom Extraction

```bash
# Extract ideas, insights, quotes, habits, and recommendations
cat podcast_transcript.txt | fabric -p extract_wisdom

# Extract just the surprising/novel ideas
cat blog_post.md | fabric -p extract_ideas

# Pull out book recommendations from any content
cat interview.txt | fabric -p extract_book_recommendations

# Extract actionable instructions
cat tutorial.md | fabric -p extract_instructions
```

### Code & Engineering

```bash
# Comprehensive code review
cat pull_request.diff | fabric -p review_code

# Explain what code does
cat complex_module.py | fabric -p explain_code

# Generate conventional commit message from a diff
git diff --staged | fabric -p create_git_diff_commit

# Write a PR description
git diff main...HEAD | fabric -p write_pull-request

# Generate coding rules for AI assistants
cat project_guidelines.md | fabric -p generate_code_rules
```

### Security & Threat Modeling

```bash
# STRIDE-based threat model
cat architecture.md | fabric -p create_stride_threat_model

# Identify threat scenarios for a system
cat system_design.md | fabric -p create_threat_scenarios

# Analyze Terraform plans for security risks
terraform plan -no-color | fabric -p analyze_terraform_plan

# Analyze incident reports
cat breach_report.md | fabric -p analyze_incident
```

### Analysis & Critical Thinking

```bash
# Analyze claims for truth/validity
cat news_article.md | fabric -p analyze_claims

# Find logical fallacies in arguments
cat debate_transcript.txt | fabric -p find_logical_fallacies

# Analyze writing quality (Pinker style)
cat essay.md | fabric -p analyze_prose_pinker

# Rate content quality on multiple axes
cat blog_post.md | fabric -p rate_content
```

### Writing & Creation

```bash
# Improve writing clarity and style
cat draft.md | fabric -p improve_writing

# Write an essay (Paul Graham style)
echo "topic: why startups fail" | fabric -p write_essay_pg

# Create flashcards from any content
cat lecture_notes.md | fabric -p create_flash_cards

# Create a Mermaid diagram
cat process_description.md | fabric -p create_mermaid_visualization

# Create an Excalidraw diagram
cat architecture.md | fabric -p create_excalidraw_visualization
```

### Research & Learning

```bash
# Create a reading plan from a topic
echo "I want to learn about distributed systems" | fabric -p create_reading_plan

# Explain complex terms with analogies
cat paper.md | fabric -p explain_terms

# Summarize an academic paper
cat paper.pdf | fabric -p summarize_paper

# Extract algorithm recommendations
cat tech_review.md | fabric -p extract_algorithm_update_recommendations
```

## Power Combos

Chain patterns together for multi-step workflows:

```bash
# YouTube -> wisdom extraction
fabric -y "https://youtube.com/watch?v=..." -p extract_wisdom

# Summarize a meeting then extract action items
cat meeting.txt | fabric -p summarize_meeting | fabric -p extract_instructions

# Analyze a PR: review + threat model
git diff main...HEAD | tee >(fabric -p review_code > review.md) | fabric -p create_stride_threat_model > threats.md

# Research pipeline: summarize then create flashcards
cat article.md | fabric -p summarize | fabric -p create_flash_cards
```

## Finding the Right Pattern

```bash
# Let Fabric suggest a pattern for your task
echo "I need to analyze security risks in my AWS architecture" | fabric -p suggest_pattern

# List all patterns with fuzzy search
fabric -l | fzf

# Read a pattern's system prompt
cat ~/.config/fabric/patterns/extract_wisdom/system.md
```

## References

- **Local repo**: `~/personal/Fabric`
- **Config**: `~/.config/fabric/`
- **Patterns dir**: `~/.config/fabric/patterns/` (245+ patterns)
- **GitHub**: [danielmiessler/fabric](https://github.com/danielmiessler/fabric)
