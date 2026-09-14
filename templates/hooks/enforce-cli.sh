#!/usr/bin/env bash
set -uo pipefail
. "$(dirname "$0")/_json.sh"

INPUT=$(cat)
COMMAND=$(json_field "$INPUT" '.tool_input.command // empty' 'd.get("tool_input",{}).get("command","")')

# PreToolUse:Bash - force the project's package manager.
# Exit 0 allows. Exit 2 blocks and feeds stderr back to the agent, which adapts.
if printf '%s' "$COMMAND" | grep -qE '(^|[^a-zA-Z0-9_.-])(npm|yarn) '; then
  echo "Blocked: this repo uses pnpm. Rerun with pnpm." >&2
  exit 2
fi

exit 0
