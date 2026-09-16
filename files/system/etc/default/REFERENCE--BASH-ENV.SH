# --- GLOBAL ENVIRONMENT VARS ---
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"

# Ensure XDG compliance so configuration caches do not clutter your raw home directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Enable Wayland backend engine scaling across heavy toolkits natively
export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1

