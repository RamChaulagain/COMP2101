#!/bin/bash

hostname=$(hostname)
#(hostname)It  is a command that displays the hostname of the computer you are currently using in a command-line interface (CLI) or terminal. 
domain_name=$(hostname -f)
#(hostname -f) The command returns the fully qualified domain name (FQDN) of the current host. 
OS_name_version=$(lsb_release -ds)
#(lsb_release -ds) The command is used to retrieve information about the Linux distribution on which it is executed.
IP=$(ip route | grep -w default | awk '{print$3}')
#(ip_route) The ip route command is used to display or manipulate the kernel's IP routing table 
free_space=$(df --output=avail -h / | tail -n1)
#(tail -n1) The command  is used in a command-line interface (CLI) or terminal to display the last line of a text file.

cat << EOF

Report of $hostname
================== 
FQDN: $domain_name
Operating System name and version: $OS_name_version
IP Address: $IP
Root System Free Space:$free_space
===================

EOF
