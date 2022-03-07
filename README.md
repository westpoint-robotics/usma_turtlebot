# TurtleBot3 Setup

These instructions are based on the [Robotis e-Manual](https://emanual.robotis.com/docs/en/platform/turtlebot3/overview/) for the Turtlebot3. Read the [Quick Start Guide](https://emanual.robotis.com/docs/en/platform/turtlebot3/quick-start/) to gain an overall understanding of the process. Always click the tab for the ROS Version (i.e. Noetic).  

Assuming the TB3 (waffel_pi version) contains a RPi3B+, OpenCR board, LDS-01 LIDAR, and an image running Ubuntu 20.04 with ROS Noetic based on these [instructions](https://emanual.robotis.com/docs/en/platform/turtlebot3/sbc_setup/#sbc-setup). If there is no image, see your instructor.

1. From a WREN Linux computer (Ubuntu 20.04), ssh into the TB3 using the IP address found on the lower waffel. Username is `ubuntu` and password is `turtlebot`.

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

8. Save and re-source the .bashrc.

`source .bashrc`

9. All of the previous commands are based on the [Quick Start Guide](https://emanual.robotis.com/docs/en/platform/turtlebot3/quick-start/). Always click the tab for the ROS Version (i.e. Noetic).  

# TurtleBot3 Bringup

Both the Remote PC (desktop or laptop) and TB3 (RPi) should be properly configured to communicate on the same ROS network over the WREN.

Follow the [bringup instructions](https://emanual.robotis.com/docs/en/platform/turtlebot3/bringup/#bringup) to start both the Remote PC and TB3. 

If you get error messages on the RPi, re-load the firmware to the OpenCR board based on these [instructions](https://emanual.robotis.com/docs/en/platform/turtlebot3/opencr_setup/#opencr-setup).

`ssh ubuntu@10.X.X.X`

`cd ./opencr_update`

`./update.sh $OPENCR_PORT $OPENCR_MODEL.opencr`

# TurtleBot3 Basic Operation

After bringup, perform teleoperation using these [instructions](https://emanual.robotis.com/docs/en/platform/turtlebot3/basic_operation/#basic-operation).


# TurtleBot3 Raspberry Pi Camera Module

In order to run [Raspberry Pi Camera Module](https://www.raspberrypi.com/products/camera-module-v2/), `raspicam_node package` will be used.

1. Access to TB3 via `ssh`

`ssh ubuntu@10.X.X.X # Turtlebot IP`

2. Update `turtlebot3` package

`cd ~/catkin_ws/src/turtlebot3 && git pull`

Remove broken work spaces. If you are using the following folders, do not run the command.

`rm -r turtlebot3_description/ turtlebot3_teleop/ turtlebot3_navigation/ turtlebot3_slam/ turtlebot3_example/`

Build.

`cd ~/catkin_ws && catkin_make`

3. Install libcamera-based stack

`sudo apt install libraspberrypi-bin libraspberrypi-dev`

4. Build `raspicam_node`

`cd ~/catkin_ws/src`

`git clone https://github.com/UbiquityRobotics/raspicam_node.git`

`sudo apt-get install ros-noetic-compressed-image-transport ros-noetic-camera-info-manager ros-noetic-diagnostic-updater`

`cd ~/catkin_ws && catkin_make --only-pkg-with-deps raspicam_node`

5. Enable camera module

`sudo nano /boot/firmware/config.txt`

Add the following lines below `[all]`

```
start_x=1
gpu_mem=128
```

`sudo usermod -a -G video $USER`

`sudo reboot`

6. Testing the camera node

To see if the camera connected,

`vcgencmd get_camera`

If the output is `supported=1 detected=1`, run `raspicam_node` package by following steps

On your PC:
`roscore`

On the TB3:
`roslaunch raspicam_node camerav2_1280x960.launch`

On your PC:
`rqt_image_view`

At the top of the image viewer, select the raspicam_node topic.


