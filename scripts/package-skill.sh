#!/usr/bin/env bash
# Собирает архивы скилла: <скилл>.skill для claude.ai и <скилл>.zip для ChatGPT, Codex, Cursor и других агентов.
# Внутри оба одинаковые: zip с папкой скилла в корне.
# Использование: scripts/package-skill.sh consilium
set -euo pipefail
name="${1:?укажите имя скилла, например consilium}"
root="$(cd "$(dirname "$0")/.." && pwd)"
src="$root/plugins/$name/skills/$name"
[ -f "$src/SKILL.md" ] || { echo "не найден $src/SKILL.md" >&2; exit 1; }
mkdir -p "$root/dist"
out="$root/dist/$name.skill"
rm -f "$out" "$root/dist/$name.zip"
( cd "$root/plugins/$name/skills" && zip -rqX "$out" "$name" -x '*.DS_Store' )
cp "$out" "$root/dist/$name.zip"
echo "$out"
echo "$root/dist/$name.zip"
