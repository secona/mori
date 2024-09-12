capacity() {
	BAT=`ls /sys/class/power_supply | grep BAT | head -n 1`
	cat /sys/class/power_supply/${BAT}/capacity
}

icon() {
	BAT=`ls /sys/class/power_supply | grep BAT | head -n 1`
	CAPACITY=$(cat /sys/class/power_supply/${BAT}/capacity)

	if [[ -z $(grep -o "Charging" /sys/class/power_supply/${BAT}/status) ]]; then
		if [[ $CAPACITY -ge 90 ]]; then
			echo "󰁹 "
		elif [[ $CAPACITY -ge 80 ]]; then
			echo "󰂂 "
		elif [[ $CAPACITY -ge 70 ]]; then
			echo "󰂀 "
		elif [[ $CAPACITY -ge 60 ]]; then
			echo "󰁿 "
		elif [[ $CAPACITY -ge 50 ]]; then
			echo "󰁾 "
		elif [[ $CAPACITY -ge 40 ]]; then
			echo "󰁽 "
		elif [[ $CAPACITY -ge 30 ]]; then
			echo "󰁼 "
		elif [[ $CAPACITY -ge 20 ]]; then
			echo "󰁻 "
		else
			echo "󰁺 "
		fi
	else
		if [[ $CAPACITY -ge 90 ]]; then
			echo "󰂅 "
		elif [[ $CAPACITY -ge 80 ]]; then
			echo "󰂋 "
		elif [[ $CAPACITY -ge 70 ]]; then
			echo "󰂊 "
		elif [[ $CAPACITY -ge 60 ]]; then
			echo "󰂉 "
		elif [[ $CAPACITY -ge 50 ]]; then
			echo "󰢝 "
		elif [[ $CAPACITY -ge 40 ]]; then
			echo "󰂈 "
		elif [[ $CAPACITY -ge 30 ]]; then
			echo "󰂇 "
		elif [[ $CAPACITY -ge 20 ]]; then
			echo "󰂆 "
		else
			echo "󰢜 "
		fi
	fi
}

"$@"
