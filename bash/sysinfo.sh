#!/bin/bash

echo "FQDN:$(hostname)" # echo is a basic command that prints text or string to the terminal or console
echo "Host Information:" # host information isthe term refers to details about a device on the network, which can be retrieved using the command and includes information such as hostname, IP addresses, and DNS information, used for troubleshooting network issues and checking configurations
hostnamectl status
echo "ip address= $(hostname -i)"  #it shows ip address of the host
df -h /boot/ef #df -h command in bash displays information about the disk space usage and availability of the file systems in a human-readable format
