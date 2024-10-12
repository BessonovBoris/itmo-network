#!/bin/bash


INTERFACE=$(nmcli device status | awk '/ethernet/ && /connected/ {print $1}' | head -n 1)

if [ -z "$INTERFACE" ]; then
    echo "No active ethernet interface found."
    exit 1
fi

echo "Detected network interface: $INTERFACE"


IP_ADDRESS="10.100.0.2/24"
GATEWAY="10.100.0.1"
DNS_SERVER="8.8.8.8"


CONNECTION_NAME=$(nmcli -t -f NAME,DEVICE connection show --active | grep ":$INTERFACE$" | cut -d: -f1)

if [ -n "$CONNECTION_NAME" ]; then
    nmcli connection delete "$CONNECTION_NAME"
fi


nmcli connection add type ethernet ifname "$INTERFACE" con-name static-connection autoconnect yes ipv4.method manual ipv4.addresses "$IP_ADDRESS" ipv4.gateway "$GATEWAY" ipv4.dns "$DNS_SERVER"


nmcli connection up static-connection

echo "Network interface $INTERFACE has been configured with static IP."
