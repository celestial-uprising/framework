#!/usr/bin/env bash
set -euo pipefail
RELEASE="https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz"
TAR="zen.linux-x86_64.tar.xz"
DIR=$(mktemp -d)
trap 'rm -rf "$DIR"' EXIT
DOWNLOAD_FILE="${DIR}/${TAR}"
curl -fsSL "${RELEASE}" -o "${DOWNLOAD_FILE}"
mkdir -p "${DIR}/zen-extracted"
tar -xf "${DOWNLOAD_FILE}" -C "${DIR}/zen-extracted"
rm -rf /opt/zen
cp -r "${DIR}/zen-extracted/zen" /opt/zen/
cd /opt/zen
[ -e zen ] || ln -sf zen-bin zen
[ -e zen-bin ] || ln -sf zen zen-bin
update-desktop-database /usr/share/applications 2>/dev/null || true
update-mime-database /usr/share/mime 2>/dev/null || true
