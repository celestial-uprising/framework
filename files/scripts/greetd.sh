#!/usr/bin/env bash
set -euo pipefail
mkdir -p /etc/greetd
cat <<'EOF' >/etc/greetd/config.toml
[default_session]
command = "dms-greeter"
user = "greeter"
EOF
chmod 644 /etc/greetd/config.toml
usermod -aG video,input greeter
