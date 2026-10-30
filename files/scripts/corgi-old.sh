#!/usr/bin/env bash
set -euo pipefail
REPO_URL="https://github.com/tals/corgi.git"
WORK_DIR="/tmp/corgi"
BINARY_DEST="/tmp/bin/corgi"
echo "=== Corgi build script for Fedora rawhide ==="
echo "[1/4] Cloning repository..."
git clone --depth 1 "$REPO_URL" "$WORK_DIR"
cd "$WORK_DIR"
echo "[2/4] Checking dependencies..."
install_if_missing() {
  local cmd="$1"
  if ! command -v "$cmd" &>/dev/null; then
    echo "  -> Installing $cmd"
    sudo dnf install -y "$cmd"
  fi
}
install_if_missing zig
install_if_missing nodejs npm
if [ ! -d "node_modules" ]; then
  echo "  -> Running bun install"
  bun install --frozen-lockfile
fi
echo "[3/4] Building..."
bun build.ts
echo "[4/4] Installing binary to $BINARY_DEST"
mkdir -p "$(dirname "$BINARY_DEST")"
cp dist/corgi "$BINARY_DEST"
chmod +x "$BINARY_DEST"
echo "=== Done: $BINARY_DEST ==="
