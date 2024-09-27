#!/bin/bash

for i in {1..3}; do
    echo "Запуск $i:"
    ./currenе_time_Receive_Transmit.bash &
    sleep 10
    kill $!
    echo "Скрипт network_stats.sh завершен."
done