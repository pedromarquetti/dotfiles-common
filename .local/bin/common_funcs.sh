backup_dconf ()
{
	if [[ ! -n "${1+x}" ]]; then
        echo -e "Path Not set $1"
		else
		dconf dump / > "$HOME"/.backup/"$1"
    fi
}

restore_dconf ()
{
	if [[ ! -n "${1+x}" ]]; then
			echo -e "Path Not set $1"
		else
			dconf load / < "$HOME"/.backup/"$1"
    fi
}
