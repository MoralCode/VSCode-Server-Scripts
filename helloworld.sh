#!/bin/bash
# This script is meant to be run on each instance upon setup to set instance-specific settings like caddy configuration and passwords

domainname="bitbybitcoding.org"
vscode_bind_addr="0.0.0.0:8080"

caddyfile="$(hostname):80, $( ping -q -c 1 $(hostname) | head -n 1 | cut -d " " -f 2
):80, $(hostname).$(domainname):80 {

        log {
        output file         /var/log/caddy/files-sample.log
        }
        root * /home/$(whoami)/my-website
        file_server
}
"

echo "$caddyfile" | sudo tee /etc/caddy/Caddyfile
#logging never ended up working right
# sudo mkdir -p /var/log/caddy/
# sudo chmod g+w /var/log/caddy

sudo systemctl start caddy
# sudo systemctl reload caddy
sudo chgrp caddy /var/log/caddy


# reboot

#user setup (with user perms)
read -p "please enter the password you wish to set for accessing the code-server: " pass
sed -i.bak "s/password: .*/password: $pass/" ~/.config/code-server/config.yaml
sed -i.bak "s/bind-addr: .*/bind-addr: $vscode_bind_addr /" ~/.config/code-server/config.yaml
mkdir -p ~/my-website

systemctl --user restart code-server
sudo systemctl restart caddy
