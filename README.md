Run script
```
wget -O- https://raw.githubusercontent.com/marcuszxc/linux-dotfiles/cachy-os/setup.sh | bash
```
Download to location
```
wget -O https://raw.githubusercontent.com/marcuszxc/linux-dotfiles/cachy-os/setup.sh
```

## What setup.sh does

Installs:
- `update.fish` -> `~/.config/fish/functions/update.fish`
- `config.fish` -> `~/.config/fish/config.fish`
- `override.conf` -> `~/.config/systemd/user/ssh-agent.socket.d/override.conf`

The `override.conf` sets `SocketMode=0600` on the ssh-agent socket. Upstream
`/usr/lib/systemd/user/ssh-agent.socket` sets no `SocketMode`, so systemd falls
back to `0666` - which lets *any* local user on the machine connect to the agent
and use your private key.

Note: restarting the socket empties the agent. `config.fish` reloads the key
automatically the next time you open an interactive shell, or run
`ssh-add ~/.ssh/id_ed25519` yourself.

Open a new shell afterwards for the config to take effect.