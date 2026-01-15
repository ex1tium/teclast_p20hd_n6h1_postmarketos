#!/usr/bin/env bash
#
# clean_artifacts.sh - Remove all generated artifacts for clean testing
#
# Usage: ./scripts/clean_artifacts.sh [--dry-run]
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

# Directories to remove (relative to PROJECT_DIR)
DIRS_TO_CLEAN=(
  "AIK"
  "tools"
  "pmbootstrap"
  "pmaports"
  "backup"
  "extracted"
  "device-info"
  "reports"
  "logs"
  "work"
  "out"
  "firmware"
  "state"
  "modified"
  "output"
)

echo "[*] Cleaning generated artifacts from: $PROJECT_DIR"
[[ "$DRY_RUN" == "true" ]] && echo "[*] DRY RUN - no changes will be made"
echo

removed_count=0
for dir in "${DIRS_TO_CLEAN[@]}"; do
  target="${PROJECT_DIR}/${dir}"
  if [[ -d "$target" ]]; then
    if [[ "$DRY_RUN" == "true" ]]; then
      echo "    Would remove: $dir/"
    else
      rm -rf "$target"
      echo "    Removed: $dir/"
    fi
    removed_count=$((removed_count + 1))
  fi
done

if [[ "$removed_count" -eq 0 ]]; then
  echo "    Nothing to clean - workspace already clean."
else
  echo
  echo "[*] Cleaned $removed_count directories."
fi

echo
echo "[*] Workspace is ready for a fresh run_all.sh test."
