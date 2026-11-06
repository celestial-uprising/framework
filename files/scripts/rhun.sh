#!/usr/bin/env bash
set -euo pipefail
RELEASES="https://github.com/vshvedov/rhun/releases"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT
VERSION=$(curl -fsSL "${RELEASES}/latest/download/VERSION" | tr -d ' \r\n')
NAME="rhun-${VERSION}-linux-x86_64.tar.gz"
curl -fsSL "${RELEASES}/download/v${VERSION}/${NAME}" -o "${TMP_DIR}/${NAME}"
curl -fsSL "${RELEASES}/download/v${VERSION}/SHA256SUMS" -o "${TMP_DIR}/SHA256SUMS"
WANT=$(awk -v f="$NAME" '$2 == f || $2 == "*" f { print $1 }' "${TMP_DIR}/SHA256SUMS")
GOT=$(sha256sum "${TMP_DIR}/${NAME}" | awk '{ print $1 }')
if [ "$GOT" != "$WANT" ]; then
  echo "Checksum verification failed for ${NAME}"
  exit 1
fi
mkdir -p "${TMP_DIR}/x"
tar -xzf "${TMP_DIR}/${NAME}" -C "${TMP_DIR}/x"
install -Dm755 "${TMP_DIR}/x/rhun-${VERSION}/bin/rhun" /usr/bin/rhun
