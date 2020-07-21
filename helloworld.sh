# gcloud compute machine-types list
INSTANCE_TYPE="f1-micro"
# gcloud compute images list
INSTANCE_IMAGE="debian-10"
INSTANCE_PROJECT="project-name"
# gcloud compute zones list
INSTANCE_ZONE="us-west1-b"
INSTANCE_NAME=""
read -r -p 'Enter a name for this instance: ' INSTANCE_NAME


# setup compute instance
gcloud compute instances create "$INSTANCE_NAME" --image="$INSTANCE_IMAGE" --image-project="$INSTANCE_PROJECT" --machine-type="$INSTANCE_TYPE" --zone="$INSTANCE_ZONE";
#install code-server

curl -fsSL https://code-server.dev/install.sh | sh


#set up and run code-server
systemctl --user enable --now code-server
sudo loginctl enable-linger USERNAME

echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" \
    | sudo tee -a /etc/apt/sources.list.d/caddy-fury.list
sudo apt update
sudo apt install caddy

sudo mkdir -p /etc/caddy
echo 'vscode-test.bitbybitcoding.org' | sudo tee /etc/caddy/Caddyfile
echo '' | sudo tee -a /etc/caddy/Caddyfile
echo 'reverse_proxy 127.0.0.1:8080' | sudo tee -a /etc/caddy/Caddyfile

sudo systemctl reload caddy

# reboot

#user setup (with user perms)
read -p "please enter the password you wish to set for accessing the code-server: " pass
sed -i.bak "s/password: .*/password: $pass/" ~/.config/code-server/config.yaml
mkdir ~/`whoami`s-website



sudo reboot