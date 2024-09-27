#!/bin/bash

sudo apt update
sudo apt install -y netplan.io

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
    INTERFACE:
      dhcp4: no
      addresses:
        - 10.100.0.4/24
        - 10.100.0.5/24
      gateway4: 10.100.0.3
EOL

sudo netplan apply
echo "Конфигурация сети применена"

echo "Проверка связи с 10.100.0.2 и 10.100.0.3:"
ping -c 3 10.100.0.2
ping -c 3 10.100.0.3

echo "Проверка связи с 10.100.0.4 и 10.100.0.5:"
ping -c 3 10.100.0.4
ping -c 3 10.100.0.5

echo "Таблица ARP кэша:"
arp -n | grep -E "10.100.0.[2-5]"
