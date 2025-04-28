#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '
# PS1='[\u@\h \w]\n\$ '

# light green user@hostname, light blue dir
PS1='\n\[\e[1;32m\]\u@\h\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\]\n\$ '

export PATH="$HOME/.local/kitty.app/bin:$PATH"

alias x='xclip -sel c'
