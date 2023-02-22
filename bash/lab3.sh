#!/bin/bash

# check if lxd is installed
if command -v lxd > /dev/null; then
	echo "lxd already installed"
else
  # install lxd if not installed
	sudo snap install lxd || exit 1
fi

# check if lxdbr0 interface exists, initialize lxd if it doesn't exist
ip link show lxdbr0 > /dev/null && echo "lxdbr0 interface found" || sudo lxd init --auto || exit 1

# launch container if it doesn't exist
if lxc list | grep -q COMP2101-S22; then
	echo "COMP2101-S22 container already exists"
else
  # launch Ubuntu 20.04 server container named COMP2101-S22
	sudo lxc launch ubuntu:20.04 COMP2101-S22 || exit 1
fi

# Get the IP address of the container named COMP2101-S22
container_ip=$(lxc list COMP2101-S22 -c 4 | awk 'FNR == 3 {print $1}')
# Check if the container IP is not empty
if [ -n "$container_ip" ]; then

  # Check if the /etc/hosts file contains an entry for COMP2101-S22
  if grep -q "COMP2101-S22" /etc/hosts; then
    # Update the existing entry with the new IP address
    sudo sed -i "s/.*COMP2101-S22/$container_ip COMP2101-S22/g" /etc/hosts
  else
    # Add a new entry for COMP2101-S22
    echo "$container_ip COMP2101-S22" | sudo tee -a /etc/hosts >/dev/null
  fi
  
fi

# install Apache2 in the container
if sudo lxc exec COMP2101-S22 -- command -v apache2 > /dev/null; then
	echo "Apache2 already installed in the container"
else
  # install Apache2 in the container
	lxc exec COMP2101-S22 -- sudo apt install -y apache2 > /dev/null || exit 1
fi

# retrieve default web page from the container's web service
curl http://COMP2101-S22 > /dev/null
if [ $? -eq 0 ]; then
	echo "successfully retrieved default web page from container"
else
  # notify user of failure to retrieve default web page from container
	echo "failed to retrieve default web page from container"
 	exit 1
fi

