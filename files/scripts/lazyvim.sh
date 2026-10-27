#!/usr/bin/env bash
set -euo pipefail
export TARGET_DIR="/usr/etc/skel/.config/nvim"
if [ -d "$TARGET_DIR" ]; then
  rm -rf "$TARGET_DIR"
fi
git clone https://github.com/LazyVim/starter "$TARGET_DIR"
rm -rf "$TARGET_DIR/.git"
