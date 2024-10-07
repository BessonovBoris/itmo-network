#!/bin/bash

if [ -f /proc/net/bonding/bond007 ]; then
    cat /proc/net/bonding/bond007
else
    echo "Ошибка: файл /proc/net/bonding/bond007 не найден."
fi
