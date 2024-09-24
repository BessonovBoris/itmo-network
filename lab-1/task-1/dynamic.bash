#!/bin/bash


INTERFACE=$(ip route | awk '/default/ {print $5}')


sudo dhclient -r $INTERFACE


sudo ip addr flush dev $INTERFACE


sudo ip link set $INTERFACE up


sudo dhclient $INTERFACE

echo " $INTERFACE dynamic setting done."
