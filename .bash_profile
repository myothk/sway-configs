# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

if [[ $(tty) == "/dev/tty1" ]]
then
	clear
	export XDG_CURRENT_DESKTOP=sway
	export EDITOR=nvim
	export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
	export QT_QPA_PLATFORM="wayland-egl;xcb"
	export ELM_DISPLAY=wl
	export SDL_VIDEODRIVER=wayland
	export QT_WAYLAND_FORCE_DPI=physical
	export XWAYLAND_NO_GLAMOR=1	#should be 1
	export MOZ_ENABLE_WAYLAND=1	
	export WLR_RENDERER=wayland-egl		#wayland-egl,vulkan
#	export GBM_BACKEND=nvidia-drm 
	export __GLX_VENDOR_LIBRARY_NAME=nvidia
	#export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json
	#IGPU=`readlink -f /dev/dri/by-path/pci-0000\:00\:02.0-card`

	#export WLR_DRM_DEVICES="$IGPU" 
	exec dbus-run-session sway --unsupported-gpu
fi
