if [ -n "$PS1" ] && [ -n "$TERM" ]; then

    set_kitty_title() {
        local space_station_symbol=$'\xf3\xb1\x93\x9e' # safer hex representation of 󱓞
        local cwd="${PWD/#$HOME/$space_station_symbol}"
        printf "\033]0;%s : %s\007" "$(hostname)" "$cwd"
    }

    set_bash_prompt() {
        local space_station_symbol=$'\xf3\xb1\x93\x9e'
        local cwd="${PWD/#$HOME/$space_station_symbol}"
        
        # Define color shortcuts wrapped in non-printable escape markers
        local purple="\[\e[36m\]"
        local coral="\[\e[33m\]"
        local reset="\[\e[0m\]"

        # Explicitly wrap the entire prompt construction
        PS1="${purple}\h${reset} : ${coral}${cwd}${reset} \$ "
    }

    prompt_runner() {
        set_kitty_title
        set_bash_prompt
    }

    # Safely append or set PROMPT_COMMAND
    if [[ -z "$PROMPT_COMMAND" ]]; then
        PROMPT_COMMAND="prompt_runner"
    elif [[ "$PROMPT_COMMAND" != *"prompt_runner"* ]]; then
        PROMPT_COMMAND="${PROMPT_COMMAND%;}; prompt_runner"
    fi
fi
