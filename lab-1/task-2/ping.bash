#!/bin/bash


BRIDGE_IP="10.100.0.3"
TEST_IP="10.100.0.2"

echo "Testing connectivity from $BRIDGE_IP to $TEST_IP..."


ping -c 4 -I br0 "$TEST_IP"

echo "Ping test completed."
