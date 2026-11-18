#!/usr/bin/env bash
set -oue pipefail

curl -fsSL "https://github.com/errorware/crow/releases/latest/download/crow-linux-x86_64.tar.gz" -o "/tmp/crow.tar.gz"
tar xzf /tmp/crow.tar.gz -C /tmp/
cp /tmp/crow*/crow /tmp/bin/crow
chmod +x /tmp/bin/crow

