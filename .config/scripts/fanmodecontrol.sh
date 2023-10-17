#!/bin/bash
FILE=/sys/devices/platform/asus-nb-wmi/throttle_thermal_policy
OUTPUT=~/.config/scripts/confs/fanmode
if test -f "$FILE";then
	speed=$(cat /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy)
	if [[ "$1" == "show" ]]; then
		case $speed in
			0)
				echo "Balanced";;
			1)
				echo "Turbo";;
			2)
				echo "Silent";;
		esac
	elif [[ "$1" == "toggle" ]];then
		speed=$(($speed+1))
		if [ $speed -gt 2 ]; then
			speed=0
		fi

		if echo $speed > /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy; then
			case $speed in
				0)
					echo "Balanced" > $OUTPUT
					;;
				1)
					echo "Turbo" > $OUTPUT
					;;
				2)
					echo "Silent" > $OUTPUT
					;;
				*)
					echo "Error!" > $OUTPUT
					;;
			esac	
		else
			echo "Error!"
		fi
	else
		:
	fi
fi
