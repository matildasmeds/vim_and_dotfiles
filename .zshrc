# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export PATH=$HOME/bin/:$PATH

# Set editor
export VISUAL=vim
export EDITOR="$VISUAL"
export GIT_EDITOR="$VISUAL"

# Key bindings
function zle-line-init {
    marking=0
}
zle -N zle-line-init

function select-char-right {
    if (( $marking != 1 ))
    then
        marking=1
        zle set-mark-command
    fi
    zle .forward-char
}
zle -N select-char-right

function select-char-left {
    if (( $marking != 1 ))
    then
        marking=1
        zle set-mark-command
    fi
    zle .backward-char
}
zle -N select-char-left

function forward-char {
    if (( $marking == 1 ))
    then
        marking=0
        NUMERIC=-1 zle set-mark-command
    fi
    zle .forward-char
}
zle -N forward-char

function backward-char {
    if (( $marking == 1 ))
    then
        marking=0
        NUMERIC=-1 zle set-mark-command
    fi
    zle .backward-char
}
zle -N backward-char

function delete-char {
    if (( $marking == 1 ))
    then
        zle kill-region
        marking=0
    else
        zle .delete-char
    fi
}
zle -N delete-char

bindkey ';2D' select-char-left   # assuming xterm
bindkey ';2C' select-char-right  # assuming xterm
bindkey ';5D' backward-word
bindkey ';5C' forward-word
bindkey '^[[3~' delete-char

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

# Git prompt
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn
# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
RPROMPT=$'$(vcs_info_wrapper)'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
