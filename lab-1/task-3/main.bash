#!/bin/bash


INTERFACE=$(ip route | grep default | awk '{print $5}')

if dpkg -l | grep -q netplan; then
    echo "netplan установлен"
else
    echo "Ошибка: netplan не установлен"
    exit 1
fi


NETPLAN_CONFIG="/etc/netplan/01-netcfg.yaml"
sudo tee $NETPLAN_CONFIG > /dev/null <<EOL
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s5:
      dhcp4: no
      addresses:
        - 10.100.0.4/24
        - 10.100.0.5/24
      routes:
        - to: 0.0.0.0/0
          via: 10.100.0.3
      nameservers:
        addresses:
          - 8.8.8.8
EOL

sudo netplan apply

sudo ip link set enp0s5 down
sudo ip link set enp0s5 up


ping -c 3 10.100.0.2
sleep 5 &
ping -c 3 10.100.0.3
sleep 5 &
ping -c 3 10.100.0.4
sleep 5 &
ping -c 3 10.100.0.5


echo "Таблица ARP кэша:"
sudo arp -a

ip neigh show
