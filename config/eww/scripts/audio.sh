volume_up() {
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+
}

volume_down() {
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
}

volume_icon() {
	volume=`wpctl get-volume @DEFAULT_AUDIO_SINK@`
	level=`echo $volume | awk '{print $2}' | sed 's/0*\.//g'`
	muted=`echo $volume | grep '[MUTED]'`

	if [[ $muted ]]; then
		echo "󰖁 $level%"
		exit 0
	fi

	echo "󰕾 $level%"
}

volume_color() {
	volume=`wpctl get-volume @DEFAULT_AUDIO_SINK@`
	muted=`echo $volume | grep '[MUTED]'`

	if [[ $muted ]]; then
		echo "#f38ba8"
	else
		echo "#a6e3a1"
	fi
}

input_volume_up() {
	wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%+
}

input_volume_down() {
	wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%-
}

input_volume_icon() {
	volume=`wpctl get-volume @DEFAULT_AUDIO_SOURCE@`
	level=`echo $volume | awk '{print $2}' | sed 's/0*\.//g'`
	muted=`echo $volume | grep '[MUTED]'`

	if [[ $muted ]]; then
		echo "󰍭 $level%"
	else
		echo "󰍬 $level%"
	fi
}

input_volume_color() {
	volume=`wpctl get-volume @DEFAULT_AUDIO_SOURCE@`
	muted=`echo $volume | grep '[MUTED]'`

	if [[ $muted ]]; then
		echo "#f38ba8"
	else
		echo "#a6e3a1"
	fi
}

"$@"
