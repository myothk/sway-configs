# .bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#prevent nested lf
lf() {
	if [ -z "$LF_LEVEL" ]; then
		/usr/bin/lf "$@"
	else
		exit
	fi
}

