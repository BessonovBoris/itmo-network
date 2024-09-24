#!/bin/bash


echo "Configuring network interface with static IP..."
sudo ./static.bash


echo "Creating and activating the bridge interface br0..."
sudo ./virtual.bash


echo "Testing connectivity between the real and virtual interfaces..."
sudo ./ping.bash


echo "Retrieving MAC address of the virtual interface br0..."
sudo ./mac-address.bash

echo "All operations have been completed."
