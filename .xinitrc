#!/bin/sh

# ~/.xinitrc

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

sxhkd &
xset r rate 200 30 &
setxkbmap -option 'caps:ctrl_modifier' &
xcape -e 'Caps_Lock=Escape' &
xrdb ~/.Xresources &
compton --backend glx --paint-on-overlay --vsync opengl-swc &
feh --bg-scale /home/aymen/Pictures/Wallpapers/uV7sQyB.png &

~/Documents/scripts/dwm_status.sh &

exec dwm
# exec bspwm
# exec /usr/bin/jwm 
# exec i3

xrandr --output eDP1 --mode 1440x900 &

