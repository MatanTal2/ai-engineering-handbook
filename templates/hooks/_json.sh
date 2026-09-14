# Sourced by the hooks. Extracts one field from the hook payload, using
# whatever the machine has. Last resort returns the raw payload, which still
# contains the text the callers grep for, so a missing jq degrades to "slightly
# less precise" rather than "hook is dead".
json_field() { # $1 = payload, $2 = jq filter, $3 = python expression over `d`
  local payload="$1" filter="$2" pyexpr="$3" py
  if command -v jq >/dev/null 2>&1; then
    printf '%s' "$payload" | jq -r "$filter" 2>/dev/null || printf '%s' "$payload"
    return
  fi
  for py in python3 python; do
    if command -v "$py" >/dev/null 2>&1; then
      printf '%s' "$payload" | "$py" -c "import json,sys;d=json.load(sys.stdin);print($pyexpr)" 2>/dev/null || printf '%s' "$payload"
      return
    fi
  done
  printf '%s' "$payload"
}
