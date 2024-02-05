#!/bin/bash

#sway with moonlight and steam headless setup
packages="sway polkit foot thermald"

sudo apt update && sudo apt install -y "$packages"


config_sway(){
  mkdir -p ~/.config/sway/
  touch ~/.config/sway/config
  config="~/.config/sway/config"
  echo -e "set \$mod Mod4" >> $config
  echo -e "set \$term foot" >> $config
  echo -e "default border pixel 2" >> $config
  echo -e "bindsym \$mod+Return exec \$term"
  echo -e "assign [app_id='^Steam$'] workspace number 2"
}
config_nvidia(){
  sudo dpkg --add-architecture i386 && sudo apt update
  sudo apt install nvidia-driver nvidia-driver-libs:i386
  sudo echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX nvidia-drm.modeset=1"' > /etc/default/grub.d/nvidia-modeset.cfg
  sudo update-grub
}
config_apt(){
  aptconfig="/etc/apt/sources.list"
  
}
config_system(){
  turbo="/sys/devices/system/cpu/intel_pstate/no_turbo"
  rclocal="/etc/rc.local"
  sudo touch "$rclocal"
  sudo chmod +x "$rclocal"
  if [ -e "$turbo" ] then
    echo -e "#!/bin/bash" >> $rclocal
    echo -e 'echo "1" > /sys/devices/system/cpu/intel_pstate/no_turbo' >> $rclocal
    echo -e 'echo "$(cat /sys/class/backlight/intel_backlight/max_brightness) > /sys/class/backlight/intel_backlight/brightness"' >> $rclocal
  fi
  if [ -e "/sys/devices/platform/asus-nb-wmi/throttle_thermal_policy" ] then
    echo 'echo "1" > /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy' >> $rclocal
}
