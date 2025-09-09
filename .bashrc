#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Enable systemd tab completion
. /usr/share/bash-completion/completions/systemctl
. /usr/share/bash-completion/completions/systemd-analyze

# Start the SSH agent and add keys if not already running
if ! pgrep -u $USER ssh-agent > /dev/null; then
  eval "$(ssh-agent -s)"
  ssh-add || true # The "|| true" prevents an error if no keys exist
fi

. ~/.bash_aliases
