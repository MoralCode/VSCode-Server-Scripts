#!/bin/bash
declare -a arr=( "list" "of" "instance" "names" "here" )

gcp_project="my-gcp-project-id"
template_name="my-image-name" # the name of an instance template configures. this simplifies the process of picking zones, netowrk settings and disk images for larger scale operations
# templates are manually created for each GCP project. Making the names all the same is helpful.

setup_script_name="customize_instance.sh" # the name of the setup script to be run on each instance

# Step 1: create the instances
gcloud compute instances create "${arr[@]}" --source-instance-template="$template_name" --project="$gcp_project"; sleep 10; #wait a bit for the instances to finish spinning up so they can be sshed into


# copy the setup script to each instance
for i in "${arr[@]}"
do
	gcloud compute scp "$setup_script_name" "$i":~ --ssh-key-file=~/.ssh/id_rsa --project="$gcp_project"
done

# open an SSH shell into each instance in order to run the script and do other manual setup. type exit inside the instance once done to disconnect and go to the next instance. 
for i in "${arr[@]}"
do
	gcloud compute ssh "$i" --ssh-key-file=~/.ssh/id_rsa --project="$gcp_project"
done