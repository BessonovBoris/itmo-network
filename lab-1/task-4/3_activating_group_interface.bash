#!/bin/bash

sudo ip link set bond007 up

echo "Информация о интерфейсах:"
ip addr show
