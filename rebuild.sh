#!/usr/bin/env bash
# Wrapper around darwin-rebuild switch that logs system preference changes.
# Usage: ./rebuild.sh [extra darwin-rebuild args]

set -euo pipefail

DOMAINS=(
  "NSGlobalDomain"
  "com.apple.dock"
  "com.apple.finder"
  "com.apple.AppleMultitouchTrackpad"
)

CURRENTHOST_DOMAINS=(
  "com.apple.AppleMultitouchTrackpad"
)

SUDO_DOMAINS=(
  "/Library/Preferences/com.apple.loginwindow"
)

LOG_DIR="${HOME}/.local/share/nix-darwin-rebuilds"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
SNAPSHOT_DIR="${LOG_DIR}/${TIMESTAMP}"

mkdir -p "${SNAPSHOT_DIR}/before" "${SNAPSHOT_DIR}/after"

snapshot() {
  local phase="$1"

  for domain in "${DOMAINS[@]}"; do
    local safe="${domain//\//_}"
    defaults read "${domain}" > "${SNAPSHOT_DIR}/${phase}/${safe}.txt" 2>/dev/null \
      || echo "(empty)" > "${SNAPSHOT_DIR}/${phase}/${safe}.txt"
  done

  for domain in "${CURRENTHOST_DOMAINS[@]}"; do
    local safe="currentHost_${domain//\//_}"
    defaults -currentHost read "${domain}" > "${SNAPSHOT_DIR}/${phase}/${safe}.txt" 2>/dev/null \
      || echo "(empty)" > "${SNAPSHOT_DIR}/${phase}/${safe}.txt"
  done

  for domain in "${SUDO_DOMAINS[@]}"; do
    local safe="${domain//\//_}"
    sudo defaults read "${domain}" > "${SNAPSHOT_DIR}/${phase}/${safe}.txt" 2>/dev/null \
      || echo "(empty)" > "${SNAPSHOT_DIR}/${phase}/${safe}.txt"
  done
}

echo "==> Snapshotting preferences before rebuild..."
snapshot before

echo "==> Running darwin-rebuild switch..."
darwin-rebuild switch --flake "${FLAKE:-.}" "$@"

echo "==> Snapshotting preferences after rebuild..."
snapshot after

CHANGES_LOG="${SNAPSHOT_DIR}/changes.log"
printf "Rebuild: %s\n%s\n" "${TIMESTAMP}" "$(printf '=%.0s' {1..40})" > "${CHANGES_LOG}"

any_changes=false

check_diff() {
  local label="$1" before="$2" after="$3"
  if ! diff -q "${before}" "${after}" > /dev/null 2>&1; then
    any_changes=true
    printf "\nDomain: %s\n---\n" "${label}" >> "${CHANGES_LOG}"
    diff "${before}" "${after}" >> "${CHANGES_LOG}" || true
  fi
}

for domain in "${DOMAINS[@]}"; do
  safe="${domain//\//_}"
  check_diff "${domain}" \
    "${SNAPSHOT_DIR}/before/${safe}.txt" \
    "${SNAPSHOT_DIR}/after/${safe}.txt"
done

for domain in "${CURRENTHOST_DOMAINS[@]}"; do
  safe="currentHost_${domain//\//_}"
  check_diff "-currentHost ${domain}" \
    "${SNAPSHOT_DIR}/before/${safe}.txt" \
    "${SNAPSHOT_DIR}/after/${safe}.txt"
done

for domain in "${SUDO_DOMAINS[@]}"; do
  safe="${domain//\//_}"
  check_diff "${domain}" \
    "${SNAPSHOT_DIR}/before/${safe}.txt" \
    "${SNAPSHOT_DIR}/after/${safe}.txt"
done

echo ""
if [ "${any_changes}" = true ]; then
  echo "==> Preference changes detected:"
  cat "${CHANGES_LOG}"
else
  echo "==> No preference changes detected."
fi

echo ""
echo "Full snapshots saved to: ${SNAPSHOT_DIR}"
