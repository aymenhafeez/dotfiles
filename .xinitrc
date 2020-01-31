#!/bin/sh

# ~/.xinitrc

# exec i3
exec /usr/bin/jwm 
# xrandr --output eDP-1 --mode 1440x900
# xset r rate 200 30
# setxkbmap -option 'caps:ctrl_modifier'
# xcape -e 'Caps_Lock=Escape'
# nm-applet
# compton --backend glx --paint-on-overlay --vsync opengl-swc
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
