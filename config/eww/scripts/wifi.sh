status=$(nmcli g | grep -oE "disconnected")
essid=$(nmcli c | grep wlp2s0 | awk '{print ($1)}')
strength=$(nmcli dev wifi list | grep "*" | awk '{print $(NF-1)}')

if [[  ! $status ]]; then
	if [[ $(echo "$strength" | grep "█") ]]; then
		icon="󰤨 "
	elif [[ $(echo "$strength" | grep "▆") ]]; then
		icon="󰤥 "
	elif [[ $(echo "$strength" | grep "▄") ]]; then
		icon="󰤢 "
	elif [[ $(echo "$strength" | grep "▂") ]]; then
		icon="󰤟 "
	else
		icon="󰤯 "
	fi

	message="Connected"
	color="#a6e3a1"
else
	icon="󰤮 "
	message="Disconnected"
	color="#a6e3a1"
fi

if [[ "$1" == "--COLOR" ]]; then
	echo $color
elif [[ "$1" == "--MESSAGE" ]]; then
	echo $message
elif [[ "$1" == "--ICON" ]]; then
	echo $icon
fi
