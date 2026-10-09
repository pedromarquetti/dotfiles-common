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

print_red() {
	echo -e "${COLORS[RED]}${1}${COLORS[OFF]}\n"
}

print_yellow() {
	echo -e "${COLORS[YELLOW]}${1}${COLORS[OFF]}\n"
	sleep 1
}

print_green() {
	echo -e "${COLORS[GREEN]}${1}${COLORS[OFF]}\n"
	sleep 1
}

print_cyan() {
	echo -e "${COLORS[CYAN]}${1}${COLORS[OFF]}\n"
}

backup_dconf() {
	if [[ ! -n "${1+x}" ]]; then
		echo -e "Path Not set $1"
	else
		dconf dump / >"$HOME"/.backup/"$1"
	fi
}

restore_dconf() {
	if [[ ! -n "${1+x}" ]]; then
		echo -e "Path Not set $1"
	else
		dconf load / <"$HOME"/.backup/"$1"
	fi
}
