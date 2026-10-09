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

tags=("master (Latest)" "0.11 (Neovim 0.11)" "nv0.12 (Neovim 0.12)")
execs=("git" "wget" "curl" "gcc" "python3")
all_executable=true

for i in "${execs[@]}"; do
	if ! command -v "$i" &>/dev/null; then
		print_red "$i is not executable"
		all_executable=false
	fi
done

if [[ "$all_executable" == false ]]; then
	print_red "not all files are executable! Exiting"
	exit 2
else
	print_green "Checks ok! Continuing"
fi

print_cyan "checking if Fast Node Manager is installed!"
if command -v fnm &>/dev/null; then
	print_green "fnm installed, installing node"
	fnm install --latest && fnm use "$(fnm list-remote --latest)"
else
	print_red "FNM not installed! installing... "
	curl -fsSL https://fnm.vercel.app/install | bash
fi

function install_nvim() {
	sudo curl -o /usr/bin/nvim -L "$1" && sudo chmod +x /usr/bin/nvim
	print_green "done!"
}

function handle_config() {
	NVIM_DIR=${XDG_CONFIG_HOME:-$HOME/.config}
	install_nvim "$2"
	if [ -d "$NVIM_DIR/nvim" ]; then
		print_red "$NVIM_DIR/nvim exists! make a backup before continuing"
		exit 1
	else
		print_cyan "Cloning my configs..."
		git clone https://github.com/pedromarquetti/neovim_config.git --branch "$1" "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
	fi
}

echo "Available versions: "
select opt in "${tags[@]}"; do
	case $opt in
	"master (Latest)")
		handle_config master https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
		;;
	"0.11 (Neovim 0.11)")
		handle_config 0.11 https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-x86_64.appimage
		;;
	"nv0.12 (Neovim 0.12)")
		handle_config nv0.12 https://github.com/neovim/neovim/releases/download/v0.12.0/nvim-linux-x86_64.appimage
		;;
	*) echo "Invalid option $REPLY" ;;
	esac
done

print_green "Cloned! Run nvim to finish setup"
