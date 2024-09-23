#!/bin/bash

INTERFACE=$(ip route | grep default | awk '{print $5}')

sudo ip link set $INTERFACE down


sudo ip link set $INTERFACE up


sudo dhclient $INTERFACE

IP_ADDR=$(ip addr show $INTERFACE | grep 'inet ' | awk '{print $2}')

if [ -z "$IP_ADDR" ]; then
    echo "Не удалось получить IP-адрес для интерфейса $INTERFACE"
else
    echo "Интерфейс $INTERFACE настроен с IP-адресом: $IP_ADDR"
fi
