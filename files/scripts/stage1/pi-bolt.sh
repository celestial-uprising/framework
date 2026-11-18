#!/usr/bin/env bash
set -euo pipefail

PIBOLT_VERSION="bolt-v1.2.1"
BUILD_BIN="/tmp/bin"
SKEL_DIR="/tmp/skel/.pi/agent"

mkdir -p "${BUILD_BIN}"
mkdir -p "${SKEL_DIR}/agents"
mkdir -p "${SKEL_DIR}/extensions"
mkdir -p "${SKEL_DIR}/skills"

echo "Downloading Pi-Bolt ${PIBOLT_VERSION} binary..."
RELEASE_URL="https://github.com/opensec-git/Pi-Bolt/releases/download/${PIBOLT_VERSION}/pi-bolt-linux-x64-jit.tar.gz"

curl -fsSL "${RELEASE_URL}" -o /tmp/pi-bolt.tgz
mkdir -p /tmp/pi-extract
tar -xzf /tmp/pi-bolt.tgz -C /tmp/pi-extract --strip-components=1
cp /tmp/pi-extract/pi "${BUILD_BIN}/pi-bolt"
chmod +x "${BUILD_BIN}/pi-bolt"
rm -rf /tmp/pi-bolt.tgz /tmp/pi-extract

cat << 'EOF' > "${SKEL_DIR}/mcp.json"
{
  "mcpServers": {
    "rea-agents": {
      "command": "npx",
      "args": ["-y", "rea-agents"]
    }
  }
}
EOF

cat << 'EOF' > "${SKEL_DIR}/agents/reviewer.md"
---
name: reviewer
description: Read-only code reviewer that checks code safety and logic
tools: read, grep, find, ls
---
You are a strict code reviewer. Analyze requested files or git diffs and report bugs, security vulnerabilities, and edge cases concisely. Do not modify files.
EOF

export PIBOLT_HOME="${SKEL_DIR}"
export HOME="/tmp"

EXTENSIONS=(
    "billion-context"
    "pi-powerline-footer"
    "pi-open-tui"
    "pi-cache-optimizer"
    "pi-markdown-preview"
    "pi-web-access"
    "opensec-pi-subagents"
)

for ext in "${EXTENSIONS[@]}"; do
    echo "Installing extension: ${ext}..."
    "${BUILD_BIN}/pi-bolt" install "npm:${ext}" || {
        echo "Warning: Extension ${ext} failed to install during build, skipping..."
    }
done

echo "Pi-Bolt ${PIBOLT_VERSION} and extensions staged successfully."
