#!/bin/bash
set -euo pipefail

# Only run in remote Claude Code sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

echo "Session start hook running..."

# This is a documentation repository with no package dependencies.
# Verify node is available for any JS tooling
if command -v node &> /dev/null; then
  echo "Node.js available: $(node --version)"
fi

echo "Session start hook complete."
