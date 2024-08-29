SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initialising new SSH agent..."
    
    if [[ -z $SSH_KEY ]]; then
        SSH_KEY=id_vmkey
    fi

    VAR_SSH_ENV="$(/usr/bin/ssh-agent) export SSH_KEY=$SSH_KEY"
    VAR_SSH_ENV="${VAR_SSH_ENV//echo/#echo}"
    VAR_SSH_ENV="${VAR_SSH_ENV//export /export\|}"
    VAR_SSH_ENV="${VAR_SSH_ENV// Agent pid /\|Agent\|pid\|}"
    echo "$VAR_SSH_ENV" | tr ' ' '\n' | tr '|' ' ' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add "$HOME"/.ssh/"$SSH_KEY";
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep "${SSH_AGENT_PID}" | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

function setsshkey {

    if [[ -z "$1" ]]; then
        
        read -rp "Enter a new ssh key: " SSH_KEY
    
    elif [[ -n "$1" ]]; then

        SSH_KEY=$1
    fi

    rm "${SSH_ENV}"

    start_agent
}
