#!/bin/bash
#this file helps to generate the Caddyfile for the proxy instance

proxy_name="my-rev-proxy"
gcp_project_of_proxy="my-gcp-project-id"
domainname="bitbybitcoding.org"

# an instance with this name should already exist and have a public IP... also caddy should be installed


declare -a arr=( "list" "of" "instance" "names" "here" )

gcp_project="my-gcp-project-id"

#generate proxy's Caddyfile
for i in "${arr[@]}"
do

	# MAKE SURE THESE SETTINGS MATCH THE REAL INTERNAL IP OF THE GCP INSTANCE. (can be found by running `ping -q -c 1 `hostname` | head -n 1 | cut -d " " -f 2` on the instance)

	caddyfile="
$i.$domainname {
	reverse_proxy $i.us-west1-b.c.$gcp_project.internal:8080
}
files.$i.$domainname {
	reverse_proxy $i.us-west1-b.c.$gcp_project.internal:80 {
			header_up Host {http.reverse_proxy.upstream.hostport}
	}
}
"
	echo "$caddyfile" | tee -a ./lb-Caddyfile
done


#upload this Caddyfile to the proxy instance. 
# NOTE: THIS NEEDS TO BE MOVED TO /etc/caddy/Caddyfile ON THE PROXY BEFORE IT WILL WORK
gcloud compute scp ./lb-Caddyfile "$proxy_name":/etc/caddy/Caddyfile --ssh-key-file=~/.ssh/id_rsa


gcloud compute ssh "$proxy_name" --ssh-key-file=~/.ssh/id_rsa --project="$gcp_project_of_proxy""
