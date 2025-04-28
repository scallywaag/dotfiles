#!/bin/bash

export XCURSOR_THEME="Bibata-Modern-Ice"

i() { pgrep -x "$1" > /dev/null || "$@" & disown; }

i clipmenud
i picom
i flameshot

exec awesome

