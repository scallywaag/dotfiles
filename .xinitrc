#!/bin/bash

i() { pgrep -x "$1" > /dev/null || "$@" & disown; }

i clipmenud
i picom
i flameshot

exec awesome

