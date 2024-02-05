#!/bin/bash

#sway with moonlight and steam headless setup
packages="sway polkit foot thermald"

sudo apt update && sudo apt install -y "$packages"
main(){

}
config_sway(){
  mkdir -p ~/.config/sway/
  touch ~/.config/sway/config
  config="~/.config/sway/config"
  >$config
  echo -e "set \$mod Mod4
  set \$term foot
  default border pixel 2
  bindsym \$mod+Return exec \$term
  assign [app_id='^Steam$'] workspace number 2" >> $config
}
config_nvidia(){
  sudo dpkg --add-architecture i386 && sudo apt update
  sudo apt install nvidia-driver nvidia-driver-libs:i386
  sudo echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX nvidia-drm.modeset=1"' > /etc/default/grub.d/nvidia-modeset.cfg
  sudo update-grub
}
config_apt(){
  aptconfig="/etc/apt/sources.list"
  echo -e "deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
  deb-src http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware

  deb http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
  deb-src http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware

  deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
  deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware" > $aptconfig
  
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
  fi
}
config_prepare(){

}
