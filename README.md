========================================
To navigate a known map:
Reference: http://wiki.ros.org/turtlebot_navigation/Tutorials/Autonomously%20navigate%20in%20a%20known%20map
========================================

The below environmental variable is set in .bashrc. This is how the node knows what map to load.
export TURTLEBOT_MAP_FILE=~/catkin_ws/src/usma_turtlebot/map/my_map.yaml
export TURTLEBOT_MAP_FILE=~/catkin_ws/src/usma_turtlebot/map/th1138_map.yaml

1. Boot Both laptops and login.
userName: user1
password:it105rocks


2. ROS12 is going to be your interface into the robot, ROS11 is going to control 
the robot. So you can close the lid of ROS11 and put it on the robot and strap it 
down. It is better if the USB ports are facing the rear, they less likely to get 
caught on something.


3. On ROS12 connect it to the Classroom projector and mirror the screen. All the 
following instructions are implemented on ROS12.


4. Open a terminal an IN ONE TERMINAL:
user1@ros12:~$ ssh user1@192.168.200.202
user1@ros11:~$ roslaunch usma_turtlebot it105_remote_demo.launch 

IGNORE ANY ERRORS THAT LOOK LIKE:
[ERROR] [1521683230.121319787]: Kobuki : malformed sub-payload detected. [206][170][CE AA 55 4D 01 0F 40 01 00 00 00 ]

IGNORE ANY WARNINGS. They will mostly look like this.
[ WARN] [1521683228.097645086]: Camera calibration file /home/user1/.ros/camera_info/depth_PS1080_PrimeSense.yaml not found.


5. IN ANOTHER TERMINAL:
user1@ros12:~$ roslaunch usma_turtlebot it105_remote_visual.launch 


6. Using RVIZ choose "2d Pose Estimate" by left clicking on it. Then left click on the map
in the approximate position and orientation of the robot. The closer to reality you are
the quicker the robot is going to develop an accurate estimate of its position.


7. You can drive the robot around a little to help it localize better.


8. Left click on "2d Nav Goal" in RVIZ and pick a spot and orientation on the map by
left clicking on the map. I recommend picking something easy first. Then make it more
challenging.


9. You can demonstrate obstacle avoidance by having a student stand in the way of the robot. The
robot will develop a plan and move around the obstacle if possible.

=====================================
To create a new map:
Reference: http://wiki.ros.org/turtlebot_navigation/Tutorials/Build%20a%20map%20with%20SLAM
=====================================
1. Boot Both laptops and login.
userName: user1
password:it105rocks


2. ROS12 is going to be your interface into the robot, ROS11 is going to control 
the robot. So you can close the lid of ROS11 and put it on the robot and strap it 
down. It is better if the USB ports are facing the rear, they less likely to get 
caught on something.


3. All the following instructions are implemented on ROS12.


4. Open a terminal an IN ONE TERMINAL:
user1@ros12:~$ ssh user1@192.168.200.202
user1@ros11:~$ roslaunch usma_turtlebot it105_remote_mapping.launch 

IGNORE ANY ERRORS THAT LOOK LIKE:
[ERROR] [1521683230.121319787]: Kobuki : malformed sub-payload detected. [206][170][CE AA 55 4D 01 0F 40 01 00 00 00 ]

IGNORE ANY WARNINGS. They will mostly look like this.
[ WARN] [1521683228.097645086]: Camera calibration file /home/user1/.ros/camera_info/depth_PS1080_PrimeSense.yaml not found.


5. IN ANOTHER TERMINAL:
user1@ros12:~$ roslaunch usma_turtlebot it105_remote_visual.launch 


6. Drive the robot around with the joystick watching how the map develops. A few tips:
    - Pivoting in place should be limited and slow. Better is a slow turn with forward
        drive.
    - Drive slower when the robot is mapping new area. You can go faster when the robot
        is driving over mapped areas.
    - You should drive loops. Drive out to the hallway and back to the corner more than
        once. This should enable the robot to accurately map the room. The room should
        be square, the walls continuous. 
        
7. When you are satisfied with the map you must save it before exiting out of the applications. 
To save the map you need to establish a seperate ssh shell to ROS11 and send the save command as
shown below. Open ANOTHER TERMINAL (3rd terminal) and run the following commands:

user1@ros12:~$ ssh user1@192.168.200.202
user1@ros11:~$ rosrun map_server map_saver -f ~/catkin_ws/src/usma_turtlebot/map/my_map
    

