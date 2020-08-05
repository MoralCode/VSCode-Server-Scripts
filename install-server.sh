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

