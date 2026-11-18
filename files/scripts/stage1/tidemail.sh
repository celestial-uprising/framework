#!/usr/bin/env bash
set -oue pipefail

URL="https://github.com/allisonhere/tidemail/releases/latest/download/tidemail-linux-x86_64.tar.gz"

cd /tmp
curl -fsSL "${URL}" -o "/tmp/tidemail.tar.gz"
tar xzf tidemail.tar.gz
cp tidemail-linux-x86_64 /tmp/bin/tidemail
chmod +x /tmp/bin/tidemail
