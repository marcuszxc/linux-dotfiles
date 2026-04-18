source /usr/share/cachyos-fish-config/cachyos-config.fish
source ~/.config/fish/functions/update.fish

abbr -a ll "ls -la"
abbr -a update_poweroff "update && sync && poweroff"

if not set -q SSH_AUTH_SOCK
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
end

set -gx SSH_ASKPASS /usr/bin/ksshaskpass

if status is-interactive
    # Check if the agent is empty
    if not ssh-add -l > /dev/null 2>&1
        # Add the key using the GUI prompt
        # Replace 'id_ed25519' with your actual key filename if it's different
        ssh-add ~/.ssh/id_ed25519 </dev/null > /dev/null 2>&1
    end
end
