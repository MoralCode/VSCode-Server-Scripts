# Step 1: set up the first code-server instance manually using the official instructions that may ot may not look like this:

#install code-server

# curl -fsSL https://code-server.dev/install.sh | sh


#set up and run code-server
# systemctl --user enable --now code-server
# alow the server to run user level services after logout
# sudo loginctl enable-linger `$whoami``

# install caddy 
# https://github.com/cdr/code-server/blob/master/doc/guide.md#lets-encrypt
# echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" \
#     | sudo tee -a /etc/apt/sources.list.d/caddy-fury.list
# sudo apt update
# sudo apt install caddy


# now you can create a disk image of this instance to replicate it many times