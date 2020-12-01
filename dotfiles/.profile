# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export PATH=$PATH:/opt/
export PATH=$PATH:/home/maurice/Documents/Linux/scripts/lemonbar_scripts/
export PATH=$PATH:/opt/minecraft-launcher/
export PATH=$PATH:/home/maurice/.local/bin
#export PATH=$PATH:/home/maurice/.scripts/
#export PATH=$PATH:/home/maurice/Documents/Programs/

# Start xServer
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx
fi

xset +fp /home/maurice/.fonts
xset fp rehash
