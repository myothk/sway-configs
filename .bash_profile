# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

if [[ $(tty) == "/dev/tty1" ]]
then
	WLR_RENDERER=vulkan
	export XDG_CURRENT_DESKTOP=sway
	export EDITOR=nvim
	export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
	export QT_QPA_PLATFORM=wayland-egl
#	export XWAYLAND_NO_GLAMOR=1 (this fuck up the opengl driver)

	echo "Starting SwayWm"
#	GBM_BACKEND=nvidia-drm
#	__GLX_VENDOR_LIBRARY_NAME=nvidia
	WLR_RENDERER=vulkan
	WLR_DRM_DEVICES=/dev/dri/card0 exec dbus-run-session sway --unsupported-gpu
fi
