# Completion
autoload -U compinit && compinit
zstyle ':completion:*:*:*:*:*' menu select
zmodload -i zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Key bindings
bindkey '^[[3~' delete-char

# Prompt
function git_prompt_info() {
  local ref
  ref="$(command git symbolic-ref HEAD 2> /dev/null)" ||
    ref="$(command git rev-parse --short HEAD 2> /dev/null)" || return 0
  echo "$ZSH_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_GIT_PROMPT_SUFFIX"
}

function parse_git_dirty() {
  local STATUS="$(command git status --porcelain 2> /dev/null | tail -n1)"

  if [[ -n $STATUS ]]; then
    echo "$ZSH_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_GIT_PROMPT_CLEAN"
  fi
}

autoload -U colors && colors
setopt prompt_subst

ZSH_GIT_PROMPT_PREFIX=" on %{$fg[red]%}"
ZSH_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_GIT_PROMPT_DIRTY="%{$fg[yellow]%}!%{$reset_color%}"
ZSH_GIT_PROMPT_CLEAN=''

PROMPT='%{$fg[red]%}%~%{$reset_color%}$(git_prompt_info) $ '

# Aliases
alias gb='git branch'
alias gco='git checkout'
alias gst='git status'

alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

alias ll='ls -l'
alias l='ls -la'

# PATH
export PATH="$HOME/.bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# rbenv
eval "$(rbenv init - --no-rehash)"

. ~/.zshrc.local
