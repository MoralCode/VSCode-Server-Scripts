# gcloud compute machine-types list
# INSTANCE_TYPE="f1-micro"
# gcloud compute images list
# INSTANCE_IMAGE="debian-10"
# INSTANCE_PROJECT="helloworld2020-servers"
# gcloud compute zones list
# INSTANCE_ZONE="us-west1-b"
# INSTANCE_NAME=""
# read -r -p 'Enter a name for this instance: ' INSTANCE_NAME


# setup compute instance
# gcloud compute instances create "$INSTANCE_NAME" --image="$INSTANCE_IMAGE" --image-project="$INSTANCE_PROJECT" --machine-type="$INSTANCE_TYPE" --zone="$INSTANCE_ZONE";

# exit(0);
#install code-server

# curl -fsSL https://code-server.dev/install.sh | sh


#set up and run code-server
# systemctl --user enable --now code-server
# alow the server to run user level services after logout
# sudo loginctl enable-linger USERNAME

# install caddy 
# https://github.com/cdr/code-server/blob/master/doc/guide.md#lets-encrypt
# echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" \
#     | sudo tee -a /etc/apt/sources.list.d/caddy-fury.list
# sudo apt update
# sudo apt install caddy

# set up domain name



# configure individual intances

# configure caddy for your domain
# read -p "what is this instances name: " name


caddyfile="$(hostname):80, $( ping -q -c 1 $(hostname) | head -n 1 | cut -d " " -f 2
):80, $(hostname).bitbybitcoding.org:80 {

        log {
        output file         /var/log/caddy/files-sample.log
        }
        root * /home/ace/my-website
        file_server
}
"

echo "$caddyfile" | sudo tee /etc/caddy/Caddyfile
sudo mkdir -p /var/log/caddy/
sudo chmod g+w /var/log/caddy

sudo systemctl start caddy
# sudo systemctl reload caddy
sudo chgrp caddy /var/log/caddy


# reboot

#user setup (with user perms)
read -p "please enter the password you wish to set for accessing the code-server: " pass
sed -i.bak "s/password: .*/password: $pass/" ~/.config/code-server/config.yaml
sed -i.bak "s/bind-addr: .*/bind-addr: 0.0.0.0:8080 /" ~/.config/code-server/config.yaml
mkdir -p ~/my-website

systemctl --user restart code-server
sudo systemctl restart caddy

# sudo reboot
