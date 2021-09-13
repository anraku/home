export LANG=ja_JP.UTF-8
# anyenv setting
eval "$(anyenv init -)"

# golang path setting
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# goenv setting
export PATH=$PATH:$HOME/.anyenv/envs/goenv/bin/goenv
 # nodenv setting
export PATH=:$PATH:$HOME/.nodenv/bin
eval "$(nodenv init -)"

## Set path for pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi

# direnv setting
eval "$(direnv hook zsh)"

# alias command list
alias vim='nvim'

alias ls='ls -G'
alias ll='ls -alhG'
alias dp='docker-compose ps'
alias doc='docker compose'

alias gs='git status'
alias gb='git switch `git branch | fzf`'
alias gore='gore -autoimport'

alias awk='gawk'

# fzf setting
alias f='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'

# peco setting
alias pcd='cd $(find . -maxdepth 1 -type d | peco)'

# neovim setting
export XDG_CONFIG_HOME=$HOME/.config

# oh my zsh theme
export ZSH=/Users/jimages/.oh-my-zsh
export ZSH_THEME="robbyrussell"
export ZSH_DISABLE_COMPFIX=true

# peco settings
# 過去に実行したコマンドを選択。ctrl-rにバインド
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history


# 初回起動時にtmuxを起動
if [[ ! -n $TMUX ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | fzf | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi
