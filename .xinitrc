#!/bin/sh

xrandr --output eDP-1 --mode 1440x900
xset r rate 200 30
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'
