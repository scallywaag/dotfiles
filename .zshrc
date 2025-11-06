# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## zsh
# set up colors for completions
[ -f $HOME/.config/ls_colors ] && source $HOME/.config/ls_colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# insensitive case matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

setopt nocaseglob
setopt nocasematch
setopt ignore_eof

# disable XON/XOFF (<C-s>)
# if [[ -t 0 ]]; then
#   stty -ixon
# fi

## env vars
export BIN=$HOME/.local/bin
export PATH=$BIN:$PATH

# go
export GOPATH=$HOME/.go
export GOBIN=$HOME/.local/bin
export PATH=$GOBIN:$PATH

## aliases
alias ls='ls --group-directories-first --color=tty'
alias grep='grep --color=auto'
alias ff='fastfetch'
alias wttr='curl wttr.in/timisoara'
alias tree='tree --dirsfirst -I ".git|node_modules|dist"'
alias gt='grc go test ./...'

## functions
dpg() {
  if [ $# -ne 3 ]; then
    echo "Usage: dpg <container_id_or_name> <username> <database>"
    return 1
  fi
  docker exec -it "$1" psql -U "$2" -d "$3"
}

## init 
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/nvm/init-nvm.sh
eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
