source /usr/share/cachyos-fish-config/cachyos-config.fish
source ~/.config/fish/functions/update.fish

abbr -a ll "ls -la"
abbr -a update_poweroff "update && sync && poweroff"

if not set -q SSH_AUTH_SOCK
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
end

set -gx SSH_ASKPASS /usr/bin/ksshaskpass
