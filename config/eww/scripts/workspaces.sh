all() {
	hyprctl workspaces -j | jq -c 'sort_by(.id)'

	socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
		while read -r line; do
			hyprctl workspaces -j | jq -c 'sort_by(.id)'
		done
}

# FIX
active() {
	hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id'

	socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
		stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}'
}

"$@"
