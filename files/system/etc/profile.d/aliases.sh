# System
alias ll="ls -lAsSh"
alias l='ls -A'
alias grep='grep --color=auto'

# Distrobox
alias db='distrobox enter'
alias dbc='distrobox create'
alias dbn='distrobox create --nvidia'

# Bluebuild
alias bb="bluebuild"
alias bbb="bluebuild build --build-driver podman"

# Podman
alias pmls='podman ps'
alias pmll='podman ps -a'
alias pmr='podman run'
alias pmrun='podman run'
alias pms='podman stop'
alias pmstop='podman stop'
alias pmd='podman rm'
alias pmrm='podman rm'
alias pmri='podman rmi'
alias pmrmi='podman rmi'
alias pmi='podman images'
alias pmimages='podman images'
alias pmli='podman images'
alias pmp='podman pull'
alias pmpull='podman pull'
alias psh='podman push'
alias pmpush='podman push'
alias pmt='podman tag'
alias pmtag='podman tag'

# Git
alias gcl='git clone'
alias gs='git status'
alias gf='git fetch --tags --all'
alias gpl='git pull'
alias gc='git commit -m'
alias gp='git push'
