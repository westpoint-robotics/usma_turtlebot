# Turtlebot Demo Instructions
Each computer is labeled with its name, such as ROS03 or ROS12. Each robot uses two computers, one acts as the Turtlebot computer and the other is the Control Station/User Interface. The computers are currently configured as pairs to work together. Below is a table identifying the pairs and their roles.

| Pair | Control Station |  Turtlebot  |
| :---: | :---: | :---: |
|  1   |      ROS02     |    ROS03    |
|  2   |      ROS04     |    ROS07    |
|  3   |      ROS12     |    ROS11    |

## Navigate a known map:
Reference: http://wiki.ros.org/turtlebot_navigation/Tutorials/Autonomously%20navigate%20in%20a%20known%20map

The below environmental variable is set in .bashrc. This is how the node knows what map to load.

`export TURTLEBOT_MAP_1FILE=~/catkin_ws/src/usma_turtlebot/maps/my_map.yaml`

This an example of using a different map.

`export TURTLEBOT_MAP_FILE=~/catkin_ws/src/usma_turtlebot/maps/th1138_map.yaml`

1. Turn on the Turtlebot computer, it will automatically login and once you see the desktop environment, shut the lid and put it ontop of the Turtlebot. Attach the two USB cables, it is better if the USB ports are facing the rear, they are less likely to get caught on something. Use the velcro to hold the computer on the Turtlebot. 

2. Turn on the ControlStation computer, connect it to the classroom projector and mirror the screen. All the 
following instructions are implemented on the ControlStation Computer.

3. Open a terminal and run the below commands:

    `ssh user1@<IP ADDRESS FOR TURTLEBOT COMPUTER>`

    `roslaunch usma_turtlebot it105_remote_demo.launch`

    IGNORE ANY ERRORS THAT BEGIN LIKE:

    - [ERROR] [1521683230.121319787]: Kobuki : malformed sub-payload detected.

    IGNORE ANY WARNINGS. They will mostly begin like this.

    - [ WARN] [1521683228.097645086] 

4. Open a another terminal and run this command:
`roslaunch usma_turtlebot it105_remote_visual.launch` 

5. Using RVIZ choose "2d Pose Estimate" by left clicking on it. Then left click on the map
in the approximate position and orientation of the robot. The closer to reality you are
the quicker the robot is going to develop an accurate estimate of its position.

6. You can drive the robot around with the joystick to help it localize better.

7. Left click on "2d Nav Goal" in RVIZ and pick a spot and orientation on the map by
left clicking on the map. I recommend picking something easy first. Then make it more
challenging.

8. You can demonstrate obstacle avoidance by having a student stand in the way of the robot. The
robot will develop a plan and move around the obstacle if possible.

## To create a new map:
Reference: http://wiki.ros.org/turtlebot_navigation/Tutorials/Build%20a%20map%20with%20SLAM

1. Turn on the Turtlebot computer, it will automatically login and once you see the desktop environment, shut the lid and put it ontop of the Turtlebot. Attach the two USB cables, it is better if the USB ports are facing the rear, they are less likely to get caught on something. Use the velcro to hold the computer on the Turtlebot. 

2. Turn on the ControlStation computer. All the following instructions are implemented on the ControlStation Computer.


3. Open a terminal and run the below commands:

    `ssh user1@<IP ADDRESS FOR TURTLEBOT COMPUTER>`

    `roslaunch usma_turtlebot it105_remote_mapping.launch`

    IGNORE ANY ERRORS THAT BEGIN LIKE:

    - [ERROR] [1521683230.121319787]: Kobuki : malformed sub-payload detected.

    IGNORE ANY WARNINGS. They will mostly begin like this.

    - [ WARN] [1521683228.097645086] 

4. Open a another terminal and run this command:
`roslaunch usma_turtlebot it105_remote_visual.launch`

5. Drive the robot around with the joystick watching how the map develops. A few tips:
    - Pivoting in place should be limited and slow. Better is a slow turn with forward
        drive.
    - Drive slower when the robot is mapping new area. You can go faster when the robot
        is driving over mapped areas.
    - You should drive loops. Drive out to the hallway and back to the corner more than
        once. This should enable the robot to accurately map the room. The room should
        be square, the walls continuous. 
        
7. When you are satisfied with the map you must save it before exiting out of the applications. 
To save the map you need to establish a another ssh shell to the Turtlebot and send the save command as
shown below. 
    - Open ANOTHER TERMINAL (3rd terminal) and run the following commands:

        `ssh user1@<IP ADDRESS FOR TURTLEBOT COMPUTER>`

        `rosrun map_server map_saver -f ~/catkin_ws/src/usma_turtlebot/maps/my_map`
    - You can change the map name, for example instead of calling it my_map, call it TH461_map. If you do this you need to change the environmental variable shown at the top of these instructions to reflect the new map.
    - Renaming the map is recommended. This code is a GIT repo and if your not careful it is possible to overwright your map with the one on Github.


