# p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# colors
[ -f ~/.ls_colors ] && source ~/.ls_colors

# zsh
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

export XCURSOR_PATH="${XCURSOR_PATH}:/usr/share/icons"
export XCURSOR_PATH="${XCURSOR_PATH}:~/.local/share/icons"

export GOPATH=$HOME/.go
export GOBIN=$HOME/.local/bin

# aliases
alias ls='ls --group-directories-first --color=tty'
alias grep='grep --color=auto'
alias vim='nvim'
alias ff='fastfetch'
alias wttr='curl wttr.in/timisoara'

# misc
export LESS="-R -M"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(zoxide init zsh)"

# functions
dpg() {
  if [ $# -ne 3 ]; then
    echo "Usage: dpg <container_id_or_name> <username> <database>"
    return 1
  fi
  docker exec -it "$1" psql -U "$2" -d "$3"
}

# p10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

