#!/usr/bin/env bash
set -uo pipefail
. "$(dirname "$0")/_json.sh"

INPUT=$(cat)
PROMPT=$(json_field "$INPUT" '.prompt // empty' 'd.get("prompt","")' | tr '[:upper:]' '[:lower:]')

# UserPromptSubmit - stdout is added to the agent's context before it answers.
# Flow steering belongs here, not in CLAUDE.md: it costs nothing on the turns
# where it does not fire.
case "$PROMPT" in
  *"build "*|*"add "*|*"implement "*|*"create "*)
    echo "Team flow: if no spec or ticket exists for this yet, propose /grill-with-docs before writing code."
    ;;
  *broken*|*failing*|*"doesn't work"*|*slow*|*regress*)
    echo "Team flow: this reads like a defect. Use the diagnosing-bugs skill (red loop, minimise, hypothesise, instrument, fix, regression-test) rather than patching the first guess."
    ;;
  *review*|*" pr "*)
    echo "Team flow: /code-review needs an explicit fixed point (commit, branch, tag, or merge-base). Ask for it if not given."
    ;;
esac

exit 0
