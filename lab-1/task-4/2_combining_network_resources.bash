#!/bin/bash

INTERFACE=$(ip route | grep default | awk '{print $5}')
NETPLAN_CONFIG="/etc/netplan/02-bonding.yaml"
sudo tee $NETPLAN_CONFIG > /dev/null <<EOL
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s5:
      dhcp4: no
    enp0s6:
      dhcp4: no
  bonds:
    bond007:
      dhcp4: true
      interfaces:
        - enp0s5
        - enp0s6
      parameters:
        mode: balance-rr
EOL

sudo netplan apply
echo "Bonding конфигурация применена."
