#!/usr/bin/env bash
set -euo pipefail

dnf install -y \
    zig \
    curl \
    unzip \
    perl-Digest-SHA \
    tar \
    gzip

curl -fsSL https://bun.com/install | BUN_INSTALL=/usr/local bash

TAG="20261101T231906Z-adecbb191a40"
TARBALL_URL="https://github.com/tals/corgi/archive/refs/tags/${TAG}.tar.gz"

curl -sL "${TARBALL_URL}" | tar -xz -C /tmp/

cd "/tmp/corgi-${TAG}"

bun install --frozen-lockfile
bun build.ts

cp dist/corgi /tmp/bin/corgi
chmod +x /tmp/bin/corgi

rm -rf "/tmp/corgi-${TAG}" ~/.bun/install/cache

