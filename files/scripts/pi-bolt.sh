#!/usr/bin/env bash
set -euo pipefail
PIBOLT_VERSION="bolt-v1.0.9"
PIBOLT_INSTALL_DIR="/usr/share/pi-bolt"
PIBOLT_VERSION_DIR="${PIBOLT_INSTALL_DIR}/${PIBOLT_VERSION}"
mkdir -p "${PIBOLT_VERSION_DIR}"
curl -fsSL "https://github.com/opensec-git/Pi-Bolt/releases/download/${PIBOLT_VERSION}/pi-bolt-linux-x64-jit.tar.gz" -o /tmp/pi-bolt.tgz
tar -xzf /tmp/pi-bolt.tgz -C "${PIBOLT_VERSION_DIR}" --strip-components=1
rm -f /tmp/pi-bolt.tgz
ln -sf "${PIBOLT_VERSION_DIR}/pi" /usr/bin/pi-bolt
ln -sf "${PIBOLT_VERSION_DIR}/pi" /usr/local/bin/pi-bolt
PLUGINS_DIR="/usr/share/pi-bolt/plugins"
mkdir -p "${PLUGINS_DIR}"
chmod -R 755 "${PIBOLT_INSTALL_DIR}"
chmod -R 755 "${PLUGINS_DIR}"
export HOME="${PLUGINS_DIR}"
export PIBOLT_HOME="${PLUGINS_DIR}"
/usr/local/bin/pi-bolt install --pi-bolt npm:billion-context
/usr/local/bin/pi-bolt install --pi-bolt npm:pi-powerline-footer
/usr/local/bin/pi-bolt install --pi-bolt npm:pi-open-tui
/usr/local/bin/pi-bolt install --pi-bolt npm:pi-cache-optimizer
/usr/local/bin/pi-bolt install --pi-bolt npm:pi-markdown-preview
/usr/local/bin/pi-bolt install --pi-bolt npm:pi-web-access
/usr/local/bin/pi-bolt install --pi-bolt npm:rea-agents
