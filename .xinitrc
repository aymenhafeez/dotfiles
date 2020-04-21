#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# sxhkd &

~/Documents/scripts/monitor.sh
xset r rate 200 30 &
setxkbmap -option 'caps:ctrl_modifier' &
xcape -e 'Caps_Lock=Escape' &
xrdb ~/.Xresources &
nitrogen --restore &
compton &
urxvtd -q &
dunst &

exec jwm

# ~/Documents/scripts/dwm_status.sh &
# exec dwm
