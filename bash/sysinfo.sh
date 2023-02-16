#!/bin/bash

hostname=$(hostname)
domain_name=$(hostname -f)
OS_name_version=$(lsb_release -ds)
IP=$(ip route | grep -w default | awk '{print$3}')
free_space=$(df --output=avail -h / | tail -n1)

cat << EOF

Report of $hostname
================== 
FQDN: $domain_name
Operating System name and version: $OS_name_version
IP Address: $IP
Root System Free Space:$free_space
===================

EOF
