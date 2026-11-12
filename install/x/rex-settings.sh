#!/usr/bin/env bash
# Sync Rex app settings (fonts, tab style, sidebar, themes...) through the dotfiles repo.
# The Mac app keeps them in the com.superlogical.rex defaults domain, not in ~/.config/rex/init.lua.
#
#   rex-settings.sh export   # this Mac's settings -> src/.config/rex/macos-settings.plist
#   rex-settings.sh apply    # repo plist -> this Mac's defaults (other keys are left alone)
#
# Only the portable keys travel: Workspace.* minus per-machine state, plus the few listed below.
# Window frames, server/tailnet settings, sync hosts and activity history stay on each machine.

set -euo pipefail

domain="com.superlogical.rex"
plist="$(cd "$(dirname "$0")/../.." && pwd)/src/.config/rex/macos-settings.plist"

case "${1:-}" in
  export|apply) ;;
  *) echo "usage: $0 export|apply" >&2; exit 1 ;;
esac

current="$(mktemp)"
trap 'rm -f "$current"' EXIT
defaults export "$domain" "$current" 2>/dev/null || plutil -create xml1 "$current"

/usr/bin/python3 - "$1" "$current" "$plist" <<'PY'
import plistlib, sys

mode, current_path, repo_path = sys.argv[1:]
EXTRA = {"rex.agents.names-sessions"}
SKIP = {"Workspace.lastFocusedSession", "Workspace.programActivitySeen"}

def portable(key):
    return (key.startswith("Workspace.") and key not in SKIP) or key in EXTRA

with open(current_path, "rb") as f:
    current = plistlib.load(f)

if mode == "export":
    settings = {k: v for k, v in sorted(current.items()) if portable(k)}
    with open(repo_path, "wb") as f:
        plistlib.dump(settings, f, sort_keys=True)
    print(f"Exported {len(settings)} settings to {repo_path}")
else:
    with open(repo_path, "rb") as f:
        settings = {k: v for k, v in plistlib.load(f).items() if portable(k)}
    current.update(settings)
    with open(current_path, "wb") as f:
        plistlib.dump(current, f)
    print(f"Applying {len(settings)} settings")
PY

if [ "$1" = apply ]; then
  defaults import "$domain" "$current"
  echo "Applied. Restart Rex if anything didn't update live."
fi
