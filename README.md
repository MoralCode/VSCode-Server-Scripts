# VSCode-Server Scripts

This repository includes mostly-complete scripts for deploying multiple instances of https://github.com/cdr/code-server on google cloud compute engine for the purpose of supporting multiple users.


These scripts are not a completely automated setup. They just help make the process less tedious where possible.

The setup that was used consisted of a reverse proxy to provide HTTPS for many domains from one IP address (to avoid hiting quotas) as well as using google cloud's Shared VPC to spread the instances out across multiple GCP projects (and potentially regions if desired).

You will likely make the most use out of these scripts if you set up the Shared VPC in advance and create two VM's (one for the proxy, one for an instance). Then you can set up disk images of this second fully-installed-but-not-customized instance of code-server and then create more instances automatically using these scripts. Instance templates will also be handy for automating the setup of VM performance, networking, disk images etc.