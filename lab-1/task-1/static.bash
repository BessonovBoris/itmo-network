#!/bin/bash


INTERFACE=$(ip route | awk '/default/ {print $5}')


IP_ADDRESS="10.100.0.2"
NETMASK="255.255.255.0"
GATEWAY="10.100.0.1"
DNS_SERVER="8.8.8.8"


sudo ip addr flush dev $INTERFACE


sudo ip addr add $IP_ADDRESS/24 dev $INTERFACE

DEFAULT_ROUTE=$(ip route show default)

if [ -n "$DEFAULT_ROUTE" ]; then

    sudo ip route del default
fi

sudo ip route add default via $GATEWAY dev $INTERFACE


echo "nameserver $DNS_SERVER" | sudo tee /etc/resolv.conf > /dev/null



echo "$INTERFACE static service done."
