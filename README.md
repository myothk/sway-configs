# sway-configs  
  
__Distribution - Void Linux__  
wm - sway  
termianl - foot  
menu - dmenu-wl  
notifications - mako  
bar - waybar  
polkit - mate-polkit (because it have no dependency)  
filemanager - lf  
editor - neovim  
image viewer - imv  
wallpaper - https://wallhaven.cc/w/kxj3l1
  
Currently text previews of files without extension are shown twice in lf. (Need to figure out a better way).  
  
- fanmodecontrol.sh is for my asus notebook, the path might need to be checked if it exits in your system. If not, better remove the [custom/fanmode] module in .config/waybar/config and remove .config/scripts/fanmodecontrol.sh.  
- lfrc have trash clearing keymap that use 'trash-cli' command.  
- for opening files, it uses 'mimeo'.  
- for preview highlighting, 'highlight' package is required.  
