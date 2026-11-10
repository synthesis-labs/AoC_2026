#!/usr/bin/env bash
# Mirror my personal AoC project into this folder.
# Usage: ./sync.sh [source-dir]   (default: ../../../advent_of_code/2026)
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
src="${1:-$here/../../../advent_of_code/2026}"

[ -d "$src" ] || { echo "source not found: $src" >&2; exit 1; }

# Honours the source's .gitignore (data/, dist-newstyle/, ...), and never
# copies the session cookie even if that ignore file changes.
rsync -a --delete \
    --exclude=cookie.txt \
    --exclude=.git \
    --exclude=sync.sh \
    --filter=':- .gitignore' \
    "$src"/ "$here"/

echo "synced $(cd "$src" && pwd) -> $here"
