#!/bin/bash

#tasks.
#configure /etc/elogind/logind.conf
#configure repos at /etc/xbps.d/


#install required packages.
#to get manually installed packages of current system. Issue the following command.
#sudo xbps-query -m | rev | cut -d "-" -f1 --complement | rev
USER=$(getent passwd 1000 | cut -d':' -f1)
IN_PACKAGES="dbus \
  elogind \
  NetworkManager \
  polkit \
  mate-polkit \
  bash-completion \
  bind-utils \
  breeze-cursors \
  btop \
  chafa \
  dnsmasq \
  foot \
  git \
  grimshot \
  imv \
  intel-ucode \
  intel-video-accel \
  lf \
  font-awesome6 \
  imv \
  mvp \
  libsixel \
  mako \
  mesa-dri \
  mesa-dri-32bit \
  mesa-vulkan-intel \
  vulkan-loader \
  Vulkan-ValidationLayers \
  neovim \
  noto-fonts-cjk \
  noto-fonts-ttf \
  noto-fonts-ttf-extra \
  nvidia \
  nvidia-libs-32bit \
  nvtop \
  pavucontrol \
  pipewire \
  python3 \
  qt5-wayland \
  trash-cli \
  unzip \
  wofi \
  xdg-desktop-portal-wlr \
  seatd \
  sway"

#update and install non free repos
sudo xbps-install -S
sudo xbps-install -uy xbps
sudo xbps-install -Suvy
sudo xbps-install void-repo-multilib void-repo-nonfree void-repo-multilib-nonfree

#install the packages and configure the system
sudo xbps-install -y "$IN_PACKAGES"

sudo usermod -aG _seatd,network $USER

#enable services
sudo ln -s /etc/sv/dbus /var/service/
SERVICES=(elogind NetworkManager dnsmasq polkitd)
for SERVICE in ${SERVICES[@]}; do
  sudo ln -s /etc/sv/$SERVICE /var/service/

#clear conflicting services for NetworkManager
rm_services=(dhcpcd wpa_supplicant wicd)
for rm_service in ${rm_services[@]}; do
  sudo rm /var/service/$rm_service

#wayland

  
  
