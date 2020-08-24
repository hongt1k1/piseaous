
# tiki profile
# ~luk4hn @ Jul 2017

### history
shopt -s histappend
export HISTCONTROL=ignoreboth  # don't log duplicate lines or lines starting with space
export HISTSIZE=65535
export HISTFILESIZE=102400
# export HISTTIMEFORMAT="[$(tput setaf 6)%F %T$(tput sgr0)]: "

### env
shopt -s autocd
export EDITOR='vim'
export PATH="$PATH:/usr/local/bin"

### prompt
_WHITE='\e[1;37m'
_GRAY='\e[1;30m'
_GREEN='\e[1;32m'
_RED='\e[1;31m'
_CYAN='\e[1;34m'
_YELLOW='\e[1;33m'
_ORANGE='\e[38;5;130m'
_TXTRST='\e[0m'

_parse_git_branch() {
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
        printf " (%s) " "${b##refs/heads/}";
    fi
}

_prompt_ps1() {
    local _cl_char="$_GRAY"
    local _cl_user="$_GREEN"
    local _cl_host="$_GREEN"
    local _cl_pwd="$_CYAN"

    [[ $(id -u) -eq 0 ]] && _cl_user="$_RED"

    case "$(uname -n)" in
        *crescent*)     _cl_host="$_GREEN" ;;
        *dev-*)         _cl_host="$_WHITE" ;;
        *)              _cl_host="$_YELLOW" ;;
    esac

    export PS1="\[$_cl_char\]» \[$_cl_user\]\u \[$_cl_char\][at] \[$_cl_host\]\H \[$_cl_pwd\]\w ${_GRAY}[{% raw %}\D{%T}{% endraw %}]\n\[$_ORANGE\]\$(_parse_git_branch)\[$_GREEN\]\\$ \[$_TXTRST\]"
}

_prompt_ps1

wanip() {
    dig +short myip.opendns.com @resolver1.opendns.com
}

## docker helper
dk-bash() {
    local _container=$1
    docker exec -ti $_container /bin/bash
}

dk-ps() {
    docker ps -a
}

dk-img() {
    docker images --format "{% raw %}{{.Repository}}:{{.Tag}}{% endraw %}"
}

dk-rmi-dangling() {
    docker rmi $(docker images -f dangling=true -q)
}

## alias
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias grep='grep --color=auto'
