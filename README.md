# sway-configs

Distribution - Void Linux
wm - sway
termianl - foot
menu - dmenu-wl
notifications - mako
bar - waybar
polkit - mate-polkit (because it have no dependency)
filemanager - lf
editor - neovim
image viewer - imv

Currently show text previews of files without extension are shown twice. (Need to figure out a better way).

fanmodecontrol.sh is for my asus notebook, the path might need to be checked if it exits in your system. If not, better remove the [custom/fanmode] module in .config/waybar/config and remove .config/scripts/fanmodecontrol.sh.
lfrc have trash clearing keymap that use 'trash-cli' command.
for opening files, it uses 'mimeo'.
for preview highlighting, 'highlight' package is required.
