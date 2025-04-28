#!/bin/bash

xrdb ~/.Xresources
xsetroot -cursor_name left_ptr

i() { pgrep -x "$1" > /dev/null || "$@" & disown; }

i clipmenud
i picom
i flameshot

exec awesome

