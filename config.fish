source /usr/share/cachyos-fish-config/cachyos-config.fish
source ~/.config/fish/functions/update.fish

abbr -a ll "ls -la"
abbr -a update_poweroff "update && sync && poweroff"

# Peka pa agentens socket. CachyOS aktiverar ssh-agent.socket (systemd),
# sa socketen finns under $XDG_RUNTIME_DIR.
# Guarden dar over: nar du loggar in via ssh med ForwardAgent sat redan
# SSH_AUTH_SOCK till den VIDAREBEFORDRADE agenten, och den ska bevaras.
if not set -q SSH_AUTH_SOCK
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
end

# Grafisk losenordsdialog, anvands bara for nycklar som HAR losenord.
set -gx SSH_ASKPASS /usr/bin/ksshaskpass

# Ladda nyckeln i agenten sa att ForwardAgent faktiskt har nagot att
# vidarebefordra. Utan detta ar agenten tom ("The agent has no identities")
# och nyckeln foljer inte med till andra maskiner.
if status is-interactive; and command -q ssh-add
    # Ladda bara in i en LOKAL agent. Nar du ssh-ar in pa en maskin med
    # ForwardAgent pekar SSH_AUTH_SOCK pa DEN ANDRA maskinens agent, och da
    # ska vi inte forsoka lagga in nagont.
    if test "$SSH_AUTH_SOCK" = "$XDG_RUNTIME_DIR/ssh-agent.socket"
        # Agenten saknar nyckeln (t.ex. efter reboot) -> lagg till den.
        if not ssh-add -l >/dev/null 2>&1
            if test -f ~/.ssh/id_ed25519
                # Synliga fel medvetet: en tyst ssh-add gor felsokning
                # omagentbar, precis som det forra "2>&1" gjorde.
                ssh-add ~/.ssh/id_ed25519
            else
                echo "ssh-agent: ~/.ssh/id_ed25519 finns inte, hoppar over." >&2
            end
        end
    end
end
