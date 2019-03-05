source ~/.bashrc

# golang
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# alias command list
alias ls='ls -G'
alias ll='ls -alhG'
alias dp='docker-compose ps'
alias doc='docker-compose'

alias gs='git status'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/anraku/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/anraku/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/anraku/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/anraku/Downloads/google-cloud-sdk/completion.bash.inc'; fi

# nodebrew path
export PATH=/usr/local/var/nodebrew/current/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

