#!/bin/bash
echo "FQDN:$(hostname)"
echo "Host Information:"
hostnamectl status
echo "IP Addresses:$(hostname -I)"
df -h /boot/efi
