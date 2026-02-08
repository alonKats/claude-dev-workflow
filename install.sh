#!/usr/bin/env bash
set -euo pipefail

# Claude Dev Workflow — Interactive Installer
# Copies workflow templates into a target project and configures them.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/templates"

# Colors
BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

header() { echo -e "\n${BOLD}${CYAN}$1${NC}"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}!${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1"; }

echo -e "${BOLD}╔══════════════════════════════════════╗${NC}"
echo -e "${BOLD}║   Claude Dev Workflow — Installer     ║${NC}"
echo -e "${BOLD}╚══════════════════════════════════════╝${NC}"

# --- Target directory ---
header "Target Project"
if [ -n "${1:-}" ]; then
  TARGET_DIR="$1"
else
  read -rp "Project directory (absolute path): " TARGET_DIR
fi

TARGET_DIR="${TARGET_DIR%/}"
if [ ! -d "$TARGET_DIR" ]; then
  error "Directory not found: $TARGET_DIR"
  exit 1
fi
success "Target: $TARGET_DIR"

# --- Project info ---
header "Project Configuration"

read -rp "Project name: " PROJECT_NAME
read -rp "Short description: " PROJECT_DESC

# --- Developers ---
header "Developer Setup"
echo "Enter developer names (these appear in coordination docs)."
echo "Press Enter with empty name to finish."

DEVELOPERS=()
i=1
while true; do
  read -rp "Developer $i name (empty to finish): " dev_name
  [ -z "$dev_name" ] && break
  DEVELOPERS+=("$dev_name")
  ((i++))
done

if [ ${#DEVELOPERS[@]} -eq 0 ]; then
  warn "No developers specified — using placeholder"
  DEVELOPERS=("Developer 1")
fi

# Build developers section for CLAUDE.md
if [ ${#DEVELOPERS[@]} -eq 1 ]; then
  DEV_SECTION="One developer works on this project:
- **${DEVELOPERS[0]}**"
else
  DEV_SECTION="Multiple developers work in parallel — each can take any task:
$(for dev in "${DEVELOPERS[@]}"; do echo "- **$dev**"; done)"
fi

# --- Tech stack (optional) ---
header "Tech Stack (optional)"
echo "Enter tech stack entries (e.g., 'Frontend: React 19, TypeScript')."
echo "Press Enter with empty line to finish."

TECH_LINES=()
while true; do
  read -rp "> " tech_line
  [ -z "$tech_line" ] && break
  TECH_LINES+=("$tech_line")
done

if [ ${#TECH_LINES[@]} -eq 0 ]; then
  TECH_STACK="_TODO: Add your tech stack_"
else
  TECH_STACK="| Layer | Technology |
|-------|------------|
$(for line in "${TECH_LINES[@]}"; do
    layer="${line%%:*}"
    tech="${line#*:}"
    echo "| $layer | $tech |"
  done)"
fi

# --- Code standards (optional) ---
header "Code Standards (optional)"
echo "Enter code standards (e.g., 'TypeScript: camelCase for variables')."
echo "Press Enter with empty line to finish."

STANDARDS_LINES=()
while true; do
  read -rp "> " std_line
  [ -z "$std_line" ] && break
  STANDARDS_LINES+=("$std_line")
done

if [ ${#STANDARDS_LINES[@]} -eq 0 ]; then
  CODE_STANDARDS="- _TODO: Add your code standards_"
else
  CODE_STANDARDS="$(for line in "${STANDARDS_LINES[@]}"; do echo "- $line"; done)"
fi

# --- Key directories (optional) ---
header "Key Directories (optional)"
echo "Enter key directories (e.g., 'src/app/ — Next.js pages')."
echo "Press Enter with empty line to finish."

DIR_LINES=()
while true; do
  read -rp "> " dir_line
  [ -z "$dir_line" ] && break
  DIR_LINES+=("$dir_line")
done

if [ ${#DIR_LINES[@]} -eq 0 ]; then
  KEY_DIRS="\`\`\`
_TODO: Add your key directories_
\`\`\`"
else
  KEY_DIRS="\`\`\`
$(for line in "${DIR_LINES[@]}"; do echo "$line"; done)
\`\`\`"
fi

# --- Install files ---
header "Installing Workflow Files"

# Create directories
mkdir -p "$TARGET_DIR/.claude/commands"
mkdir -p "$TARGET_DIR/docs"

# Copy commands
for cmd in start status claim-task complete-task sync; do
  src="$TEMPLATES_DIR/.claude/commands/$cmd.md"
  dest="$TARGET_DIR/.claude/commands/$cmd.md"
  if [ -f "$dest" ]; then
    warn "Skipping $cmd.md (already exists)"
  else
    cp "$src" "$dest"
    success "Installed .claude/commands/$cmd.md"
  fi
done

# Copy/merge settings.local.json
SETTINGS_DEST="$TARGET_DIR/.claude/settings.local.json"
if [ -f "$SETTINGS_DEST" ]; then
  warn "Skipping settings.local.json (already exists — merge manually if needed)"
  echo "  Template at: $TEMPLATES_DIR/.claude/settings.local.json"
else
  cp "$TEMPLATES_DIR/.claude/settings.local.json" "$SETTINGS_DEST"
  success "Installed .claude/settings.local.json"
fi

# Copy docs (only if they don't exist)
for doc in dev-log progress; do
  src="$TEMPLATES_DIR/docs/$doc.md"
  dest="$TARGET_DIR/docs/$doc.md"
  if [ -f "$dest" ]; then
    warn "Skipping docs/$doc.md (already exists)"
  else
    cp "$src" "$dest"
    success "Installed docs/$doc.md"
  fi
done

# Generate CLAUDE.md from template
CLAUDE_MD_DEST="$TARGET_DIR/CLAUDE.md"
if [ -f "$CLAUDE_MD_DEST" ]; then
  warn "CLAUDE.md already exists — writing to CLAUDE.md.new instead"
  CLAUDE_MD_DEST="$TARGET_DIR/CLAUDE.md.new"
fi

# Read template and replace placeholders
TEMPLATE=$(<"$TEMPLATES_DIR/CLAUDE.md")
TEMPLATE="${TEMPLATE//\{\{PROJECT_NAME\}\}/$PROJECT_NAME}"
TEMPLATE="${TEMPLATE//\{\{PROJECT_DESCRIPTION\}\}/$PROJECT_DESC}"
TEMPLATE="${TEMPLATE//\{\{DEVELOPERS_SECTION\}\}/$DEV_SECTION}"
TEMPLATE="${TEMPLATE//\{\{TECH_STACK\}\}/$TECH_STACK}"
TEMPLATE="${TEMPLATE//\{\{CODE_STANDARDS\}\}/$CODE_STANDARDS}"
TEMPLATE="${TEMPLATE//\{\{KEY_DIRECTORIES\}\}/$KEY_DIRS}"

echo "$TEMPLATE" > "$CLAUDE_MD_DEST"
success "Generated $(basename "$CLAUDE_MD_DEST")"

# --- Summary ---
header "Installation Complete"
echo ""
echo -e "Files installed in: ${BOLD}$TARGET_DIR${NC}"
echo ""
echo "  .claude/commands/start.md"
echo "  .claude/commands/status.md"
echo "  .claude/commands/claim-task.md"
echo "  .claude/commands/complete-task.md"
echo "  .claude/commands/sync.md"
echo "  .claude/settings.local.json"
echo "  docs/dev-log.md"
echo "  docs/progress.md"
echo "  $(basename "$CLAUDE_MD_DEST")"
echo ""
echo -e "${BOLD}Next steps:${NC}"
echo "  1. Review and customize CLAUDE.md for your project"
echo "  2. Fill in docs/progress.md with your actual tasks"
echo "  3. Update docs/dev-log.md shared files table"
echo "  4. Commit the workflow files to your project"
echo ""
echo -e "${BOLD}Recommended global plugins:${NC}"
echo "  claude plugins install fullstack-dev-skills@fullstack-dev-skills"
echo "  claude plugins install context7@claude-plugins-official"
echo ""
success "Done! Open Claude Code in your project and use /start to begin."
