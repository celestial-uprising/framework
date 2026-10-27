#!/usr/bin/env bash
set -euo pipefail

export HOME=/tmp/build-home
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"
mkdir -p "$XDG_CONFIG_HOME"
git clone https://github.com/LazyVim/starter "$XDG_CONFIG_HOME/nvim"
rm -rf "$XDG_CONFIG_HOME/nvim/.git"
nvim --headless "+Lazy! sync" +qa
nvim --headless "+lua pcall(vim.cmd, 'TSUpdateSync')" -c "sleep 10" +qa
FACTORIES=("/usr/share/factory/lazyvim")
SKELS=("/etc/skel/.config/nvim")
for dir in "${FACTORIES[@]}"; do mkdir -p "$dir/config" "$dir/share"; done
for skel in "${SKELS[@]}"; do
  mkdir -p "$skel"
  mkdir -p "${skel//.config/.local\/share}"
done
safe_copy_config() {
  local src="$1"
  local factory_dest="$2"
  local skel_dest="$3"
  if [ -d "$src" ] && [ "$(ls -A "$src")" ]; then
    cp -r "$src"/* "$factory_dest/"
    cp -r "$src"/* "$skel_dest/"
  fi
}
safe_copy_config "$XDG_CONFIG_HOME/nvim" "/usr/share/factory/lazyvim/config" "/etc/skel/.config/nvim"
safe_copy_config "$XDG_DATA_HOME/nvim" "/usr/share/factory/lazyvim/share" "/etc/skel/.local/share/nvim"
