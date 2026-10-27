#!/usr/bin/env bash
set -euo pipefail

# 1. Setup isolated build homes
export HOME=/tmp/build-home
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Ensure binary target path exists in our temporary home
mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

# ==========================================
# 2. LAZYVIM SETUP
# ==========================================
echo "=== Bootstrapping LazyVim ==="
mkdir -p "$XDG_CONFIG_HOME"
git clone https://github.com/LazyVim/starter "$XDG_CONFIG_HOME/nvim"
rm -rf "$XDG_CONFIG_HOME/nvim/.git"

# Run sync AND force Neovim to wait long enough for Tree-sitter compilers to finish
nvim --headless "+Lazy! sync" +TSUpdateSync +qa

# ==========================================
# 3. PI-BOLT SETUP
# ==========================================
echo "=== Bootstrapping Pi-Bolt ==="
mkdir -p "$XDG_CONFIG_HOME/pi-bolt" "$XDG_DATA_HOME/pi-bolt"

# Download the installer script locally to review its behavior or handle variables cleanly
curl -fsSL https://pi-bolt.opensec.in/install.sh -o /tmp/pi-bolt-install.sh
chmod +x /tmp/pi-bolt-install.sh
/tmp/pi-bolt-install.sh

# Fallback check: Did it install to our isolated $HOME or the root system?
if [ -f "$HOME/.local/bin/pi-bolt" ]; then
  mv "$HOME/.local/bin/pi-bolt" /usr/bin/pi-bolt
elif [ -f "/root/.local/bin/pi-bolt" ]; then
  mv "/root/.local/bin/pi-bolt" /usr/bin/pi-bolt
else
  echo "ERROR: pi-bolt binary location could not be determined." && exit 1
fi
chmod 755 /usr/bin/pi-bolt

# ==========================================
# 4. CORGI SETUP
# ==========================================
echo "=== Bootstrapping Corgi ==="
mkdir -p "$XDG_CONFIG_HOME/corgi" "$XDG_DATA_HOME/corgi"

curl -fsSL https://corgi.computer -o /tmp/corgi-install.sh
chmod +x /tmp/corgi-install.sh
/tmp/corgi-install.sh

# Fallback check for binary placement
if [ -f "$HOME/.local/bin/corgi" ]; then
  mv "$HOME/.local/bin/corgi" /usr/bin/corgi
elif [ -f "/root/.local/bin/corgi" ]; then
  mv "/root/.local/bin/corgi" /usr/bin/corgi
else
  echo "ERROR: corgi binary location could not be determined." && exit 1
fi
chmod 755 /usr/bin/corgi

# ==========================================
# 5. UNIVERSAL USER SEEDING
# ==========================================
echo "=== Transferring Build Blueprints ==="

# Define targets
FACTORIES=("/usr/share/factory/lazyvim" "/usr/share/factory/pibolt" "/usr/share/factory/corgi")
SKELS=("/etc/skel/.config/nvim" "/etc/skel/.config/pi-bolt" "/etc/skel/.config/corgi")

for dir in "${FACTORIES[@]}"; do mkdir -p "$dir/config" "$dir/share"; done
for skel in "${SKELS[@]}"; do
  mkdir -p "$skel"
  mkdir -p "${skel//.config/.local\/share}"
done

# Helper logic to copy folder contents safely if they exist
safe_copy_config() {
  local src="$1"
  local factory_dest="$2"
  local skel_dest="$3"

  if [ -d "$src" ] && [ "$(ls -A "$src")" ]; then
    cp -r "$src"/* "$factory_dest/"
    cp -r "$src"/* "$skel_dest/"
  fi
}

# Distribute LazyVim
safe_copy_config "$XDG_CONFIG_HOME/nvim" "/usr/share/factory/lazyvim/config" "/etc/skel/.config/nvim"
safe_copy_config "$XDG_DATA_HOME/nvim" "/usr/share/factory/lazyvim/share" "/etc/skel/.local/share/nvim"

# Distribute Pi-Bolt
safe_copy_config "$XDG_CONFIG_HOME/pi-bolt" "/usr/share/factory/pibolt/config" "/etc/skel/.config/pi-bolt"
safe_copy_config "$XDG_DATA_HOME/pi-bolt" "/usr/share/factory/pibolt/share" "/etc/skel/.local/share/pi-bolt"

# Distribute Corgi
safe_copy_config "$XDG_CONFIG_HOME/corgi" "/usr/share/factory/corgi/config" "/etc/skel/.config/corgi"
safe_copy_config "$XDG_DATA_HOME/corgi" "/usr/share/factory/corgi/share" "/etc/skel/.local/share/corgi"

echo "=== Universal installation successfully completed ==="
