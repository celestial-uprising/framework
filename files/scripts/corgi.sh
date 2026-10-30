#!/usr/bin/env bash
set -euo pipefail
REPO_URL="https://github.com/tals/corgi.git"
WORK_DIR="/tmp/corgi"
BINARY_DEST="/tmp/bin/corgi"
git clone --depth 1 "$REPO_URL" "$WORK_DIR"
cd "$WORK_DIR"
dnf install -y zig nodejs npm curl unzip perl-Digest-SHA
curl -fsSL https://bun.com/install | BUN_INSTALL=/usr/local bash
if [ ! -d "node_modules" ]; then
  bun install --frozen-lockfile
fi
bun build.ts
mkdir -p "$(dirname "$BINARY_DEST")"
cp dist/corgi "$BINARY_DEST"
chmod +x "$BINARY_DEST"
cp /tmp/corgi/dist/corgi /usr/bin/corgi
rm -rf /tmp/corgi
