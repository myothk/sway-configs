#!/bin/bash
FILE=/sys/devices/system/cpu/cpu0/power/energy_perf_bias
if test -e "$FILE";then
	EPB=$(cat $FILE)
	if [[ "$1" == "show" ]]; then
		case $EPB in
			0) echo "CPU: Performance";;
			4) echo "CPU: Balanced-Performance";;
			6) echo "CPU: Balanced";;
			8) echo "CPU: Balanced-Powersave";;
			15) echo "CPU: Powersave";;
		esac
	elif [[ "$1" == "toggle" ]]; then
		case $EPB in
			0) echo "15" | tee /sys/devices/system/cpu/cpu*/power/energy_perf_bias
			   echo "1" >/sys/devices/system/cpu/intel_pstate/no_turbo
			;;
			6) echo "0" | tee /sys/devices/system/cpu/cpu*/power/energy_perf_bias
			   echo "0" > /sys/devices/system/cpu/intel_pstate/no_turbo
			   ;;
			15) echo "6" | tee /sys/devices/system/cpu/cpu*/power/energy_perf_bias
			    echo "1" >/sys/devices/system/cpu/intel_pstate/no_turbo
			;;
		esac
	fi
fi
