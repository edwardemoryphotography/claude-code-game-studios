#!/bin/bash
# Claude Code SessionStart hook: Remote environment setup + session context
#
# Input schema (SessionStart): No stdin input

# --- Remote environment setup (only runs on Claude Code on the web) ---
if [ "${CLAUDE_CODE_REMOTE:-}" = "true" ]; then
    # Run async so apt-get install doesn't block the session from starting.
    # The 5-minute window is ample; installs typically finish in <30 seconds.
    echo '{"async": true, "asyncTimeout": 300000}'

    echo "=== Remote Environment Setup ==="

    # Refresh package cache once if either tool is missing (required on fresh containers)
    if ! command -v jq >/dev/null 2>&1 || ! command -v python3 >/dev/null 2>&1; then
        apt-get update >/dev/null 2>&1
    fi

    # jq is used by validate-commit.sh, validate-assets.sh, and agent audit hooks
    if ! command -v jq >/dev/null 2>&1; then
        echo "Installing jq..."
        apt-get install -y jq >/dev/null 2>&1 || echo "WARNING: jq install failed — hook validation will be degraded"
    fi
    command -v jq >/dev/null 2>&1 && echo "jq: $(jq --version)"

    # python3 is used for JSON validation in commit and asset hooks
    if ! command -v python3 >/dev/null 2>&1; then
        echo "Installing python3..."
        apt-get install -y python3 >/dev/null 2>&1 || echo "WARNING: python3 install failed — JSON validation will be skipped"
    fi
    command -v python3 >/dev/null 2>&1 && echo "python3: $(python3 --version 2>&1)"

    echo "=== Remote Setup Complete ==="
    echo ""
fi

echo "=== Claude Code Game Studios — Session Context ==="

# Current branch
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ -n "$BRANCH" ]; then
    echo "Branch: $BRANCH"

    # Recent commits
    echo ""
    echo "Recent commits:"
    git log --oneline -5 2>/dev/null | while read -r line; do
        echo "  $line"
    done
fi

# Current sprint (find most recent sprint file)
LATEST_SPRINT=$(ls -t production/sprints/sprint-*.md 2>/dev/null | head -1)
if [ -n "$LATEST_SPRINT" ]; then
    echo ""
    echo "Active sprint: $(basename "$LATEST_SPRINT" .md)"
fi

# Current milestone
LATEST_MILESTONE=$(ls -t production/milestones/*.md 2>/dev/null | head -1)
if [ -n "$LATEST_MILESTONE" ]; then
    echo "Active milestone: $(basename "$LATEST_MILESTONE" .md)"
fi

# Open bug count
BUG_COUNT=0
for dir in tests/playtest production; do
    if [ -d "$dir" ]; then
        count=$(find "$dir" -name "BUG-*.md" 2>/dev/null | wc -l)
        BUG_COUNT=$((BUG_COUNT + count))
    fi
done
if [ "$BUG_COUNT" -gt 0 ]; then
    echo "Open bugs: $BUG_COUNT"
fi

# Code health quick check
if [ -d "src" ]; then
    TODO_COUNT=$(grep -r "TODO" src/ 2>/dev/null | wc -l)
    FIXME_COUNT=$(grep -r "FIXME" src/ 2>/dev/null | wc -l)
    if [ "$TODO_COUNT" -gt 0 ] || [ "$FIXME_COUNT" -gt 0 ]; then
        echo ""
        echo "Code health: ${TODO_COUNT} TODOs, ${FIXME_COUNT} FIXMEs in src/"
    fi
fi

# --- Active session state recovery ---
STATE_FILE="production/session-state/active.md"
if [ -f "$STATE_FILE" ]; then
    echo ""
    echo "=== ACTIVE SESSION STATE DETECTED ==="
    echo "A previous session left state at: $STATE_FILE"
    echo "Read this file to recover context and continue where you left off."
    echo ""
    echo "Quick summary:"
    head -20 "$STATE_FILE" 2>/dev/null
    TOTAL_LINES=$(wc -l < "$STATE_FILE" 2>/dev/null)
    if [ "$TOTAL_LINES" -gt 20 ]; then
        echo "  ... ($TOTAL_LINES total lines — read the full file to continue)"
    fi
    echo "=== END SESSION STATE PREVIEW ==="
fi

echo "==================================="
exit 0
