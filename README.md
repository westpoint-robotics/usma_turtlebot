# Turtlebot Aspire E11 Joystick Instructions
In a terminal run the command:

`ls /dev/input | grep js`

If this shows both js0 and js1 then you need make the ROS nodes use the js1 joystick. You can set the parameter and start the node in one line with:

`rosparam set /joystick/dev "/dev/input/js1"`


# Turtlebot Demo Instructions - Odroid
Each Turtlebot is controlled by an Odroid single board computer. When the Turtlebot is turned on, the Odroid is also powered on and then automatically boots up, loads the operating system, and connects to the EECSDS3 network. It may take a minute or two for the Odroid to fully boot and connect to the network. When the Odroid is working properly you will see a steady red light and blinking blue light.

Every Odroid has a single map that covers TH462, TH460 and TH459. When launching the IT105_demo this map is used by default. Other maps can be created and used see below for those instructions.

Each Odroid has a label on it to help identify it. Also it's environment is setup to work with a designated laptop and to start in a designated room. See the below table to match the Odroid to Laptop and room.

| Pair | Odroid Label |  Turtlebot  |  Laptop Contoller |  Start Room   |
| :---: | :---: | :---: | :---: | :---: |
|  1   |      T02     |    Turtl02    |    ROS303   |    TH462   |
|  2   |      T03     |    Turtl03    |    ROS308   |    TH460   |

## Navigate a known map:
Reference: http://wiki.ros.org/turtlebot_navigation/Tutorials/Autonomously%20navigate%20in%20a%20known%20map

1. If the robot is not turned on, then turn it on.

2. Place the robot in the center of the aisle, aligned with the front row of desks, and facing the front of the room. This is the location the robot expects to be in once it starts. 

3. On the desktop of the ROS Laptop, click on the red turtle icon labeled "Turtle Navigating". This opens a terminal, connects to the Odroid using SSH, and starts the navigation code on the Odriod, 

4. Open a terminal on the ROS Laptop and enter the command:
`roslaunch usma_turtlebot it105_visual.launch`

5. After a delay, you should see the map appear on laptop display. If the robot is not at the correct location on the map, you adjust this by clicking on the "2d Pose Estimate" button on the top menu bar, then clicking on the estimated location of the robot on the map. Before letting up on the mouse button make sure the arrow is pointing in the same orientation as the robot.

6. Click on the 2D Nav Goal button on the top menu bar then click on a desired destination on the map. The robot will then navigate to this location.

7. When the robot looses network access as is switches to another access point, it may cause a lag or for RViz to loose synchronization. If this does not resolve itself, you can close RViz then select the terminal and press Ctrl-C. Up arrow and run the last command again.




