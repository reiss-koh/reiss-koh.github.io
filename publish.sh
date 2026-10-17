#!/usr/bin/env bash
# Publishes the site: checks that Hugo can build it, then commits every change
# and pushes to main (GitHub Actions deploys from there).
#
#   ./publish.sh                      commit message lists the changed files
#   ./publish.sh "Add NeurIPS paper"  your own commit message
#
# If the build fails (usually a YAML typo), nothing is committed or pushed.
set -uo pipefail
cd "$(dirname "$0")" || exit 1

if [[ "$(git branch --show-current)" != "main" ]]; then
  echo "Not on main, so nothing was pushed."; exit 1
fi

if ! out="$(hugo build --renderToMemory --panicOnWarning 2>&1)"; then
  sed -nE '/ERROR|WARN|panic/,$p' <<<"$out"
  echo "Build failed, so nothing was pushed. Fix the file above and run it again."; exit 1
fi

git add -A
if git diff --cached --quiet; then
  echo "No changes to commit."
else
  files="$(git diff --cached --name-only)"
  count="$(wc -l <<<"$files" | tr -d ' ')"
  msg="Update $(head -3 <<<"$files" | paste -sd ',' - | sed 's/,/, /g')"
  (( count > 3 )) && msg+=" (+$((count - 3)) more)"
  git commit -q -m "${1:-$msg}" || exit 1
  echo "Committed: ${1:-$msg}"
fi

# pick up anything committed elsewhere (e.g. edits made on GitHub) first
if ! git pull -q --rebase; then
  git rebase --abort 2>/dev/null
  echo "Couldn't merge with GitHub. Your commit is saved locally; run git pull, fix the conflict, then git push."; exit 1
fi
git push -q || { echo "Push failed. Your commit is saved locally; run ./publish.sh again."; exit 1; }
echo "Pushed. The site updates in about a minute."
