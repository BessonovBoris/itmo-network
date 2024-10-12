#!/bin/bash


INTERFACE=$(ip route | grep default | awk '{print $5}')


if [ -z "$INTERFACE" ]; then
    echo "Can't found net interface"
    exit 1
fi

echo "Info INTERFACE: $INTERFACE"


echo -e "\nModel:"
lspci -nnk | grep -A 3 -i ethernet


echo -e "\nSpeed, Duplex,Link detected :"
if command -v sudo ethtool >/dev/null 2>&1; then
    sudo ethtool $INTERFACE | grep -E "Speed|Duplex|Link detected"
else
    echo "Ethtool not install. Installing..."
    sudo apt-get update
    sudo apt-get install -y ethtool
    sudo ethtool $INTERFACE | grep -E "Speed|Duplex|Link detected"
fi


LINK_STATUS=$(sudo ethtool $INTERFACE | grep "Link detected" | awk '{print $3}')
echo -e "\nLink Status: $LINK_STATUS"


MAC_ADDRESS=$(ip link show $INTERFACE | awk '/ether/ {print $2}')
echo -e "\nMAC-address $INTERFACE: $MAC_ADDRESS"
