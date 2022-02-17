# TurtleBot3 Setup

These instructions are based on the [Robotis e-Manual](https://emanual.robotis.com/docs/en/platform/turtlebot3/overview/) for the Turtlebot3.  

Assuming the TB3 (waffel_pi version) contains a RPi3B+, OpenCR board, LDS-01 LIDAR, and an image running Ubuntu 20.04 with ROS Noetic based on these [instructions](https://emanual.robotis.com/docs/en/platform/turtlebot3/sbc_setup/#sbc-setup). If there is no image, see your instructor.

1. From a WREN Linux computer (Ubuntu 20.04), ssh into the TB3 using the IP address found on the lower waffel. Password is `turtlebot`.

`ssh ubuntu@10.X.X.X`

2. Open the .bashrc

`nano .bashrc`

3. Check that your .bashrc on the RPi has these settings:

`source /opt/ros/noetic/setup.bash`

`source ~/catkin_ws/devel/setup.bash`

`export ROS_MASTER_URI=http://10.X.X.X:11311 # Remote PC`

`export ROS_HOSTNAME=10.X.X.X # RPI3`

`export LDS_MODEL=LDS-01`

`export OPENCR_PORT=/dev/ttyACM0`

`export OPENCR_MODEL=waffle_noetic`

`export TURTLEBOT3_MODEL=waffle_pi`

4. Save the .bashrc (Ctrl-x).

5. Re-source the .bashrc.

`source .bashrc`

6. Check the settings on the remote PC (Desktop):

`nano .bashrc`

 7. Check that your .bashrc on the remote PC has these settings:

`source /opt/ros/noetic/setup.bash`

`source ~/catkin_ws/devel/setup.bash`

`export ROS_MASTER_URI=http://10.X.X.X:11311 # Remote PC`

`export ROS_HOSTNAME=10.X.X.X # Remote PC`

`export TURTLEBOT3_MODEL=waffle_pi`

8. Re-source the .bashrc.

`source .bashrc`

9. All of the previous commands are based on the [Quick Start Guide](https://emanual.robotis.com/docs/en/platform/turtlebot3/quick-start/). Click the Noetic Tab.

# TurtleBot3 Bringup

Both the Remote PC (Desktop) and TB3 should be properly configured to communicate on the same ROS network over the WREN.

Follow the [bringup instructions](https://emanual.robotis.com/docs/en/platform/turtlebot3/bringup/#bringup) to start both the Remote PC and TB3. 

