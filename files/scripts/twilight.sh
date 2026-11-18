#!/usr/bin/env bash
set -euo pipefail

cd /tmp

curl -fsSL "https://github.com/zen-browser/desktop/releases/download/twilight-1/zen.linux-x86_64.tar.xz" -o "/tmp/twilight.tar.xz"
tar -xf /tmp/twilight.tar.xz
cp -r /tmp/zen /opt/zen

cd /opt/zen
[ -e zen ] || ln -sf zen-bin zen
[ -e zen-bin ] || ln -sf zen zen-bin
update-desktop-database /usr/share/applications 2>/dev/null || true
update-mime-database /usr/share/mime 2>/dev/null || true
