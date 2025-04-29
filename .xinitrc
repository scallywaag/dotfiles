#!/bin/bash

xrdb ~/.Xresources &
xsetroot -cursor_name left_ptr &

xrandr --output DP-4 --mode 1920x1080 --rate 240 --pos 0x0 --primary &&
xrandr --output HDMI-0 --mode 1920x1080 --rate 240 --pos 1920x0

i() { pgrep -x "$1" > /dev/null || "$@" & disown; }

i clipmenud
i picom
i flameshot

exec awesome

