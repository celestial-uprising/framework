if [ -n "$PS1" ] && [ -n "$TERM" ]; then

    set_kitty_title() {
        local space_station_symbol="󱓞"
        local cwd="${PWD/#$HOME/$space_station_symbol}"
        
        printf "\033]0;%s : %s\007" "$(hostname)" "$cwd"
    }

    if [[ -z "$PROMPT_COMMAND" ]]; then
        PROMPT_COMMAND="set_kitty_title"
    elif [[ "$PROMPT_COMMAND" != *"set_kitty_title"* ]]; then
        PROMPT_COMMAND="${PROMPT_COMMAND%;}; set_kitty_title"
    fi
fi
