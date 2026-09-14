# Templates

| File | Goes to | Notes |
| --- | --- | --- |
| `CLAUDE.md` | `<repo>/CLAUDE.md` | Delete every line that does not apply. Smaller is better. |
| `settings.json` | `<repo>/.claude/settings.json` | Team-shared, commit it. Personal overrides in `settings.local.json`. |
| `hooks/*.sh` | `<repo>/.claude/hooks/` | `chmod +x` them, `_json.sh` included. Uses `jq` if present, falls back to `python3`/`python`, then to raw-payload matching. |

Hook contract: exit 0 allows, exit 2 blocks and feeds stderr back to the agent. `UserPromptSubmit` stdout is injected into context before the agent answers.

Test a hook without a session:

```bash
echo '{"tool_input":{"command":"npm install"}}' | .claude/hooks/enforce-cli.sh; echo "exit=$?"
```
