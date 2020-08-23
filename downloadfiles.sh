#!/bin/bash
declare -a arr=( "list" "of" "instance" "names" "here" )

gcp_project="my-gcp-project-id"

output_dir="/home/$(whoami)/Documents/Server Downloads"
instance_user="user"

for i in "${arr[@]}"
do
	path="$output_dir/$i/"
	echo ""
	echo "downloading from instance: $i..."
	mkdir -p "$path"
	# Copy any files that arent hidden, including directories
	gcloud compute scp --compress --recurse "$i":"/home/$instance_user/[!.]*" "$path" --project="$gcp_project" --ssh-key-file=~/.ssh/id_rsa 
done