#!/usr/bin/env bash
set -euo pipefail

REPO="https://raw.githubusercontent.com/marcuszxc/linux-dotfiles/cachy-os"

mkdir -p ~/.config/fish/functions

wget -q -O ~/.config/fish/functions/update.fish "$REPO/update.fish"
wget -q -O ~/.config/fish/config.fish "$REPO/config.fish"

# Begränsa ssh-agent-socketen till 0600 istället för systemd-default 0666,
# så att inte andra lokala användare kan använda din privata nyckel.
mkdir -p ~/.config/systemd/user/ssh-agent.socket.d
wget -q -O ~/.config/systemd/user/ssh-agent.socket.d/override.conf \
    "$REPO/systemd/ssh-agent.socket.d/override.conf"

systemctl --user daemon-reload
systemctl --user enable --now ssh-agent.socket
# Omstart tömmer agenten, så nyckeln måste laddas in igen.
systemctl --user restart ssh-agent.socket

echo "Klart. Öppna en ny interaktiv terminal så att config.fish laddar nyckeln,"
echo "eller kör direkt: ssh-add ~/.ssh/id_ed25519"