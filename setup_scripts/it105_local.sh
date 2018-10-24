#!/bin/bash
# This script is not run directly it is run by the it105_turtlebotSetup.sh script.

# Remove the usma_turtlebot packet, then clone the latest packet from git_hub.
rm -rf ~/catkin_ws/src/usma_turtlebot
cd ~/catkin_ws/src/
git clone https://github.com/westpoint-robotics/usma_turtlebot.git
git config --global user.name "user1 turtlebot"
git config --global user.email "user1@turtlebot.com"



