if [ -n "$PS1" ] && [ -n "$TERM" ]; then

    set_kitty_title() {
        local space_station_symbol="󱓞"
        local cwd="${PWD/#$HOME/$space_station_symbol}"
        
        printf "\033]0;%s : %s\007" "$(hostname)" "$cwd"
    }

    set_bash_prompt() {
        local space_station_symbol="󱓞"
        local cwd="${PWD/#$HOME/$space_station_symbol}"
        local purple="\[\e[36m\]"
        local coral="\[\e[33m\]"
        local reset="\[\e[0m\]"
        
        PS1="${purple}\h${reset} : ${coral}${cwd}${reset} \$ "
    }

    prompt_runner() {
        set_kitty_title
        set_bash_prompt
    }

    if [[ -z "$PROMPT_COMMAND" ]]; then
        PROMPT_COMMAND="prompt_runner"
    elif [[ "$PROMPT_COMMAND" != *"prompt_runner"* ]]; then
        PROMPT_COMMAND="${PROMPT_COMMAND%;}; prompt_runner"
    fi
fi
