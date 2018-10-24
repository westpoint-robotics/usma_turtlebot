#!/bin/bash
# IT105 Turtlebot Demo setup script to send the shutdown command to all turtlebots if you put their IP address in the list.

# Create an array of servers to configure
declare -a comps=("192.168.200.60" "192.168.200.123" "192.168.200.117" "192.168.200.105" "192.168.200.202" "192.168.200.55")

# For each computer configure it
for i in "${comps[@]}"; do
    echo "1. Working on $i, shuttingdown."
    # ping -c 3 $i

    ssh -t user1@$i "sudo poweroff"
    #ssh -t user1@$i "sudo apt-get install sshpass"

done
'''
it105rocks
'''
