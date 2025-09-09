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

:SSH Agent Setup:~/.bashrc
# Start the SSH agent and load keys if it's not already running
# This script ensures the agent is shared across all terminal windows.
SSH_ENV="$HOME/.ssh/agent-info"

# Helper function to start the agent
start_agent() {
    echo "Starting ssh-agent..."
    # The 'ssh-agent -s' command prints the environment variables
    # We capture them and store them in the SSH_ENV file
    ssh-agent -s > "$SSH_ENV"
    echo "Done. Environment variables stored in $SSH_ENV"
    # Then we source the file to apply them to the current shell
    . "$SSH_ENV"
    # Finally, add the key
    ssh-add
}

# Check if the agent is running and the environment variables are set
# Check if the file exists and source it if it does
if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV"
fi

# Check if the agent is actually running
# 'ssh-add -l' will return a non-zero exit code if the agent is not reachable
# We send the output to /dev/null to keep the terminal clean
ssh-add -l &> /dev/null || start_agent

. ~/.bash_aliases
