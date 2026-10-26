#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="/opt/lazyvim"

echo "==> Cloning LazyVim starter config to $TARGET_DIR..."

if [ -d "$TARGET_DIR" ]; then
  rm -rf "$TARGET_DIR"
fi

if ! command -v git &>/dev/null; then
  echo "Error: 'git' is required to clone the repository." >&2
  exit 1
fi

git clone https://github.com/LazyVim/starter "$TARGET_DIR"

rm -rf "$TARGET_DIR/.git"

echo "==> LazyVim template successfully installed to $TARGET_DIR"
