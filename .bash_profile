# .bash_profile
#Env variables
echo "Setting environment variables..."


###################################################
export EDITOR='nvim'
export XDG_SCREENSHOTS_DIR=/home/mthk/Pictures/Screenshots
export XDG_CURRENT_DESKTOP=sway
export __EGL_VENDOR_LIBRARY_FILENAMES="/usr/share/glvnd/egl_vendor.d/50_mesa.json"
export __GLX_VENDOR_LIBRARY_NAME="mesa"

#[WLR Root SWAY]
export WLR_NO_HARDWARE_CURSORS=1
export XWAYLAND_NO_GLAMOR=1

#[ELM APPS]
export ELM_DISPLAY=wl

#[QT Apps]
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORM=wayland-egl
export QT_WAYLAND_FORCE_DPI=physical
#export QT_QPA_PLATFORMTHEME=qt6ct

#[SDL2 force wayland]
export SDL_VIDEODRIVER=wayland
#export SDL_DYNAMIC_API=/usr/lib/libSDL2-2.0.so

#[Firefox]
export MOZ_ENABLE_WAYLAND=1
####################################################


echo "Done."

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

## Startup stuff here ##
echo "Loading required stuffs..."
echo "Done."

### Start i3 here ###
if [[ $(tty) == "/dev/tty1" ]] 
then
	exec dbus-run-session sway --unsupported-gpu
fi
