#!/bin/bash




INTERFACE=$(ip route | grep default | awk '{print $5}')

echo "Network card model: " $(lspci | grep -i ethernet)
echo "Canal speed: " $(cat /sys/class/net/"$INTERFACE"/speed)
echo "Duplex mode: $(ethtool $INTERFACE | grep -i duplex | awk '{print $2}')"
if [[ $(cat /sys/class/net/$INTERFACE/carrier) -eq 1 ]]; then
    echo "Physical connection: Connected"
else
    echo "Physical connection: Disconnected"
fi
IP_INFO=$(ip -o -f inet addr show $INTERFACE | awk '{print $4}')
IP_ADDRESS=${IP_INFO%/*}
PREFIX=${IP_INFO#*/}


prefix_to_netmask() {
    local i
    local mask=""
    local full_octets=$(($1/8))
    local remaining_bits=$(($1%8))

    for ((i=1; i<=4; i++)); do
        if [ $i -le $full_octets ]; then
            mask+="255"
        elif [ $i -eq $(($full_octets + 1)) ]; then
            mask+=$((256 - 2**(8 - $remaining_bits)))
        else
            mask+="0"
        fi

        [ $i -lt 4 ] && mask+="."
    done

    echo $mask
}

NETMASK=$(prefix_to_netmask $PREFIX)

GATEWAY=$(ip route | grep default | awk '{print $3}')


DNS_SERVERS=$(grep -E '^nameserver' /etc/resolv.conf | awk '{print $2}')

echo "Config IPv4:"
echo "INTERFACE: $INTERFACE"
echo "IP ADDRESS: $IP_ADDRESS"
echo "NETMASK: $NETMASK"
echo "GATEWAY: $GATEWAY"
echo "DNS SERVERS: $DNS_SERVERS"

