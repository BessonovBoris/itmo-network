#!/bin/bash


BRIDGE_NAME="br0"


BRIDGE_IP="10.100.0.3/24"


INTERFACE=$(nmcli device status | awk '/ethernet/ && /connected/ && !/bridge/ {print $1}' | head -n 1)

if [ -z "$INTERFACE" ]; then
    echo "No active ethernet interface found."
    exit 1
fi

echo "Detected network interface: $INTERFACE"


nmcli connection delete "$BRIDGE_NAME" 2>/dev/null
nmcli connection delete "${INTERFACE}-slave" 2>/dev/null


nmcli connection add type bridge ifname "$BRIDGE_NAME" con-name "$BRIDGE_NAME" ipv4.addresses "$BRIDGE_IP" ipv4.method manual


nmcli connection add type bridge-slave ifname "$INTERFACE" master "$BRIDGE_NAME" con-name "${INTERFACE}-slave"


nmcli connection up "$BRIDGE_NAME"

echo "Bridge interface $BRIDGE_NAME has been created and activated with IP address $BRIDGE_IP."
