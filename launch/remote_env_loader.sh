#!/bin/bash

export ROS_IP=192.168.200.202

source /home/user1/catkin_ws/devel/setup.bash

exec "$@"
