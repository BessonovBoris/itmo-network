#!/bin/bash

echo "INFO IPv4"


INTERFACE=$(ip route | awk '/default/ {print $5}')

if [ -z "$INTERFACE" ]; then
    echo "Can't find interface."
    exit 1
fi

echo -e "\nINTERFACE: $INTERFACE"


IP_INFO=$(ip -o -f inet addr show $INTERFACE | awk '{print $4}')

if [ -z "$IP_INFO" ]; then
    echo "Can't find IP_ADDRESS $INTERFACE."
    exit 1
fi

IP_ADDRESS=${IP_INFO%/*}
PREFIX=${IP_INFO#*/}


prefix_to_netmask() {
    local prefix=$1
    local mask=""
    local bits=0
    local octet=0

    for ((i=1; i<=4; i++)); do
        if [ $prefix -ge 8 ]; then
            bits=8
        else
            bits=$prefix
        fi
        octet=$(( (255 << (8 - bits)) & 255 ))
        mask+=$octet
        [ $i -lt 4 ] && mask+="."
        prefix=$((prefix - bits))
        if [ $prefix -le 0 ]; then
            prefix=0
        fi
    done
    echo $mask
}

NETMASK=$(prefix_to_netmask $PREFIX)


GATEWAY=$(ip route | awk '/default/ {print $3}')


DNS_SERVERS=$(awk '/^nameserver/ {print $2}' /etc/resolv.conf)

echo -e "\nIP_ADDRESS: $IP_ADDRESS"
echo "NETMASK: $NETMASK"
echo "GATEWAY: $GATEWAY"
echo -e "DNS_SERVERS:\n$DNS_SERVERS"
