#!/usr/bin/env bash

# Query current mode
CURRENT_MODE=$(envycontrol --query)

# If argument provided, open menu
if [ "$1" == "menu" ]; then
  # Choose your menu tool (e.g., wofi or rofi)
  CHOICE=$(echo -e "hybrid\nintegrated\nnvidia" | wofi --dmenu --prompt "Select GPU Mode:")

  if [ -n "$CHOICE" ] && [ "$CHOICE" != "$CURRENT_MODE" ]; then
    # Use pkexec so a graphical password prompt pops up
    pkexec envycontrol -s "$CHOICE" && reboot
  fi
else
  # Output JSON format for Waybar
  case "$CURRENT_MODE" in
  "hybrid") echo '{"text": "   Hybrid", "class": "hybrid"}' ;;
  "integrated") echo '{"text": "   Intel/AMD", "class": "integrated"}' ;;
  "nvidia") echo '{"text": "   NVIDIA", "class": "nvidia"}' ;;
  *) echo '{"text": "   Unknown", "class": "unknown"}' ;;
  esac
fi
