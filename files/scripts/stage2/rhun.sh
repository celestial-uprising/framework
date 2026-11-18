#!/usr/bin/env bash
set -euo pipefail

cd /tmp

VERSION=$(curl -fsSL "https://github.com/vshvedov/rhun/releases/latest/download/VERSION" | tr -d ' \r\n')

curl -fsSL "https://github.com/vshvedov/rhun/releases/download/v${VERSION}/rhun-${VERSION}-linux-x86_64.tar.gz" -o "/tmp/rhun.tar.gz"
tar xzf /tmp/rhun.tar.gz
mv /tmp/rhun-${VERSION} /tmp/rhun
cp /tmp/rhun/bin/rhun /tmp/bin
chmod +x /tmp/bin/rhun

