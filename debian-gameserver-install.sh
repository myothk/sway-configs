#!/bin/bash

# This script is to setup sway(intel+nvidia)+sunshine game streaming server for debian 12 bookworm.
# This script is still work in progress.

# Goals of this script
# Work for following hardware.
# Model: Asus ROG Strix G531GU
# CPU: Intel core i7-9750h 
# GPU: Nvidia GTX 1660ti(mobile)

# This script do the following tasts.
# Configure apt and install all required packages and softwares.
# Disable intel turbo boost (for lower cpu temperature)
# Set fan mode to asus turbo mode (via asus-nb-wmi kernel module)
# thermald packaged is installed and enabled to prevent aggressive hardware thermal control.
# Sway is setup with a virtual output with resolution 1280x720@60Hz for streaming to Moonlight.
# Internal display of the laptop will show nvtop and btop while sunshine is streaming the headless display.

main

####Functions####
main(){
  config_apt
  config_nvidia
  config_system
  packages="sway polkit foot thermald dbus wget nvtop btop"
  sudo apt update && sudo apt install -y "$packages"

}
config_sway(){
  mkdir -p ~/.config/sway/
  touch ~/.config/sway/config
  config="~/.config/sway/config"
  >$config
  echo -e "###start of config###
  set \$mod Mod4
  set \$term foot
  default border pixel 2
  
  ##some keybinds##
  bindsym \$mod+Return exec \$term
  
  ##workspace & app & display
  
  assign [app_id='^Steam$'] workspace number 2
  ##display###
  
  xrandr --output 
  ##end of config ###" >> $config
}
config_nvidia(){
  sudo dpkg --add-architecture i386 && sudo apt update
  sudo apt install nvidia-driver nvidia-driver-libs:i386
  sudo echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX nvidia-drm.modeset=1"' > /etc/default/grub.d/nvidia-modeset.cfg
  sudo update-grub
}
config_apt(){
  aptconfig="/etc/apt/sources.list"
  echo "Configuring apt"
  sudo echo -e "deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
  deb-src http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware

  deb http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
  deb-src http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware

  deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
  deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware" > $aptconfig
  echo "Finished configuring apt. exit code: $?"
  sudo apt update
}
config_system(){
  turbo="/sys/devices/system/cpu/intel_pstate/no_turbo"
  rclocal="/etc/rc.local"
  sudo touch "$rclocal"
  sudo chmod +x "$rclocal"
  if [ -e "$turbo" ] then
    sudo echo -e "#!/bin/bash" >> $rclocal
    sudo echo -e 'echo "1" > /sys/devices/system/cpu/intel_pstate/no_turbo' >> $rclocal
    sudo echo -e 'echo "$(cat /sys/class/backlight/intel_backlight/max_brightness) > /sys/class/backlight/intel_backlight/brightness"' >> $rclocal
  fi
  if [ -e "/sys/devices/platform/asus-nb-wmi/throttle_thermal_policy" ] then
    sudo echo 'echo "1" > /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy' >> $rclocal
  fi
}
config_prepare(){

}
