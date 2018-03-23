#!/bin/bash
# This script is not run directly it is run by the hadoopCleanup.sh script.

# Deleting files that are the solutions to the ICE
rm -rf ~/catkin_ws/src/usma_turtlebot
cd ~/catkin_ws/src/
git clone https://github.com/westpoint-robotics/usma_turtlebot.git
git config --global user.name "user1 turtlebot"
git config --global user.email "user1@turtlebot.com"


#cd ~/catkin_ws
#catkin_make
#cd ~
#sudo su it105rocks -c 'rm /etc/NetworkManager/system-connections/EECSNet*'
#sudo su it105rocks -c 'rm /etc/NetworkManager/system-connections/DML*'


