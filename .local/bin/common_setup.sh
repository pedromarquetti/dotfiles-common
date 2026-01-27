#!/bin/bash

declare -rA COLORS=(
    [RED]=$'\033[0;31m'
    [GREEN]=$'\033[0;32m'
    [BLUE]=$'\033[0;34m'
    [PURPLE]=$'\033[0;35m'
    [CYAN]=$'\033[0;36m'
    [WHITE]=$'\033[0;37m'
    [YELLOW]=$'\033[0;33m'
    [BOLD]=$'\033[1m'
    [OFF]=$'\033[0m'
)

print_red () {
     echo -e "${COLORS[RED]}${1}${COLORS[OFF]}\n"
}

print_yellow () {
    echo -e "${COLORS[YELLOW]}${1}${COLORS[OFF]}\n"
    sleep 1
}

print_green () {
    echo -e "${COLORS[GREEN]}${1}${COLORS[OFF]}\n"
    sleep 1
}

print_cyan () {
    echo -e "${COLORS[CYAN]}${1}${COLORS[OFF]}\n"
}

config_common(){ # alias used to make it easier to work with these files
    /usr/bin/git --git-dir="$HOME/.dotfiles-common.git" --work-tree="$HOME" "$@"
}

main () {
    cd ~ || exit
    print_cyan "Let's import common files"

		if [[ ! -x /usr/bin/git ]]; then
			print_red "Git Not installed! Please install GIT!"
			exit 1
		fi

	
}

main
