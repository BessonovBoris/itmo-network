#!/bin/bash

if lsmod | grep -q bonding; then
    echo "Модуль bonding уже загружен."
else
    echo "Загрузка модуля bonding..."
    sudo modprobe bonding

    if lsmod | grep -q bonding; then
        echo "Модуль bonding успешно загружен."
    else
        echo "Ошибка: не удалось загрузить модуль bonding."
        exit 1
    fi
fi