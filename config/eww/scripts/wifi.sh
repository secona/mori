status=$(nmcli g | grep -oE "disconnected")
essid=$(nmcli -t -f NAME c show --active | head -n 1)
strength=$(nmcli dev wifi list | grep "*" | awk '{print $(NF-1)}')
signal=$(nmcli dev wifi list | grep "*" | awk '{print $(NF-2)}')

if [[  ! $status ]]; then
	if [[ $(echo "$strength" | grep "█") ]]; then
		icon="󰤨 $signal%"
	elif [[ $(echo "$strength" | grep "▆") ]]; then
		icon="󰤥 $signal%"
	elif [[ $(echo "$strength" | grep "▄") ]]; then
		icon="󰤢 $signal%"
	elif [[ $(echo "$strength" | grep "▂") ]]; then
		icon="󰤟 $signal%"
	else
		icon="󰤯 $signal%"
	fi

	message="Connected - $essid"
	color="#a6e3a1"
else
	icon="󰤮 "
	message="Disconnected"
	color="#f38ba8"
fi

if [[ "$1" == "--COLOR" ]]; then
	echo $color
elif [[ "$1" == "--MESSAGE" ]]; then
	echo $message
elif [[ "$1" == "--ICON" ]]; then
	echo $icon
fi
