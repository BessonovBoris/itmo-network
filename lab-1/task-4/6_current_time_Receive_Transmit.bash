#!/bin/bash

while true; do
    echo "Текущее время: $(date)"
    echo "Имя интерфейса | Принятые пакеты | Переданные пакеты"
    grep -E '^(bond007|enp0s5|enp0s6)' /proc/net/dev | while read -r line; do
        iface=$(echo $line | awk '{print $1}' | tr -d :)
        rcv_packets=$(echo $line | awk '{print $3}')
        tx_packets=$(echo $line | awk '{print $11}')
        echo "$iface | $rcv_packets | $tx_packets"
    done
    sleep 10  # Повторять каждые 10 секунд
done
