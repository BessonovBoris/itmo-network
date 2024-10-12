#!/bin/bash

while true; do
    echo -e "\nSelect an action:"
    echo "1) Get network card information"
    echo "2) Get current IPv4 configuration"
    echo "3) Configure network interface (Static IP)"
    echo "4) Configure network interface (Dynamic IP via DHCP)"
    echo "5) Exit the script"
    read -p "Enter the number of the action (1-5): " choice

    case $choice in
        1)
            ./info.bash
            ;;
        2)
            ./IPv4.bash
            ;;
        3)
            ./static.bash
            ;;
        4)
            ./dynamic.bash
            ;;
        5)
            echo "Exiting the script."
            exit 0
            ;;
        *)
            echo "Invalid input! Please select an action from the list."
            ;;
    esac
done
