#!/usr/bin/env bash
set -euo pipefail

# 1. Define temporary home paths inside the build environment
export HOME=/tmp/build-home
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# ==========================================
# 2. BOOTSTRAP LAZYVIM
# ==========================================
echo "=== Bootstrapping LazyVim ==="
mkdir -p "$XDG_CONFIG_HOME"
git clone https://github.com "$XDG_CONFIG_HOME/nvim"
rm -rf "$XDG_CONFIG_HOME/nvim/.git"
# Force Neovim to run headlessly to sync and compile all Lazy plugins/parsers
nvim --headless "+Lazy! sync" +qa

# ==========================================
# 3. BOOTSTRAP PI-BOLT
# ==========================================
echo "=== Bootstrapping Pi-Bolt ==="
mkdir -p "$XDG_CONFIG_HOME/pi-bolt" "$XDG_DATA_HOME/pi-bolt"
curl -fsSL https://opensec.in | sh
# Move the binary out of the build home into global system path
mv "$HOME/.local/bin/pi-bolt" /usr/bin/pi-bolt
chmod 755 /usr/bin/pi-bolt

# ==========================================
# 4. BOOTSTRAP CORGI
# ==========================================
echo "=== Bootstrapping Corgi ==="
mkdir -p "$XDG_CONFIG_HOME/corgi" "$XDG_DATA_HOME/corgi"
curl -fsSL https://corgi.computer | sh
# Move the binary out of the build home into global system path
mv "$HOME/.local/bin/corgi" /usr/bin/corgi
chmod 755 /usr/bin/corgi

# ==========================================
# 5. ORCHESTRATE SYSTEM FACTORIES & SKEL
# ==========================================
echo "=== Stashing Profiles Into Factory Pools and System Skel ==="

# 5a. Staging directories for factories (keeps system updates tracked)
mkdir -p /usr/share/factory/lazyvim/config /usr/share/factory/lazyvim/share
mkdir -p /usr/share/factory/pibolt/config /usr/share/factory/pibolt/share
mkdir -p /usr/share/factory/corgi/config /usr/share/factory/corgi/share

# 5b. Staging directories for /etc/skel (provisions every newly created user)
mkdir -p /etc/skel/.config/nvim /etc/skel/.local/share/nvim
mkdir -p /etc/skel/.config/pi-bolt /etc/skel/.local/share/pi-bolt
mkdir -p /etc/skel/.config/corgi /etc/skel/.local/share/corgi

# Copy artifacts safely to Factories
cp -r "$XDG_CONFIG_HOME/nvim"/* /usr/share/factory/lazyvim/config/
cp -r "$XDG_DATA_HOME/nvim"/* /usr/share/factory/lazyvim/share/
cp -r "$XDG_CONFIG_HOME/pi-bolt"/* /usr/share/factory/pibolt/config/ 2>/dev/null || true
cp -r "$XDG_DATA_HOME/pi-bolt"/* /usr/share/factory/pibolt/share/ 2>/dev/null || true
cp -r "$XDG_CONFIG_HOME/corgi"/* /usr/share/factory/corgi/config/ 2>/dev/null || true
cp -r "$XDG_DATA_HOME/corgi"/* /usr/share/factory/corgi/share/ 2>/dev/null || true

# Copy artifacts safely to Skeleton (Universal User Seed)
cp -r "$XDG_CONFIG_HOME/nvim"/* /etc/skel/.config/nvim/
cp -r "$XDG_DATA_HOME/nvim"/* /etc/skel/.local/share/nvim/
cp -r "$XDG_CONFIG_HOME/pi-bolt"/* /etc/skel/.config/pi-bolt/ 2>/dev/null || true
cp -r "$XDG_DATA_HOME/pi-bolt"/* /etc/skel/.local/share/pi-bolt/ 2>/dev/null || true
cp -r "$XDG_CONFIG_HOME/corgi"/* /etc/skel/.config/corgi/ 2>/dev/null || true
cp -r "$XDG_DATA_HOME/corgi"/* /etc/skel/.local/share/corgi/ 2>/dev/null || true

echo "=== All systems successfully baked universally ==="

