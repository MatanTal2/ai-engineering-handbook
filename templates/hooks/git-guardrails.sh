#!/usr/bin/env bash
set -uo pipefail
. "$(dirname "$0")/_json.sh"

INPUT=$(cat)
COMMAND=$(json_field "$INPUT" '.tool_input.command // empty' 'd.get("tool_input",{}).get("command","")')

# PreToolUse:Bash - block destructive git before it runs.
# Generated equivalent: run /git-guardrails-claude-code.
block() {
  echo "Blocked: $1 Ask the human to run it if it is genuinely wanted." >&2
  exit 2
}

case "$COMMAND" in
  *"git push --force"*|*"git push -f"*) block "force push." ;;
  *"git reset --hard"*)                 block "hard reset discards uncommitted work." ;;
  *"git clean -"*)                      block "git clean deletes untracked files." ;;
  *"git checkout -- "*)                 block "checkout -- discards local changes." ;;
  *"git branch -D"*)                    block "force branch delete." ;;
  *"git rebase --abort"*|*"git merge --abort"*) block "aborting throws away conflict resolution work." ;;
esac

exit 0
