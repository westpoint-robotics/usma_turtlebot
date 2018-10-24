#!/bin/bash
# IT105 Turtlebot Demo setup script
# This script requires the following additional files (They should be in the same directory that you are running this script in):
#   - it105_local.sh
#   - TurtleMapping.desktop
#   - TurtleNavigating.desktop
#   - bashrcTemplate

# This script assumes the password for all computers is "it105rocks". If this is not so then change it.
# This script requires that sshpass is installed on all computers. If not then install using the command:
# sudo apt-get install sshpass

# For this to work you need put all computers on the network and know their IP Addresses. Those IP address go in the below 2 lists.
# By using the below lists you pair a control station computer IP address with a turtlebot control computer IP address by the sequence it appears in the list.

# turtl is a list of IP addresses for all computers that are on the turtlebot.
declare -a turtl=("192.168.200.123" "192.168.200.105" "192.168.200.202")
# cntrl is a list of IP addresses for all computers used as remote control stations for the turtlebots. 
# The first computer in this list controls the first computer in the turtlebot list, and second controls the second turtlebot computer, etc.
declare -a cntrl=("192.168.200.60" "192.168.200.117" "192.168.200.55")

# For each turtlebot computer configure it
for ((i=0;i<${#turtl[@]};++i)); do
    echo "1. Working on ${turtl[i]}, updating bashrc and running script."
    # ping -c 3 ${turtl[i]}
    sshpass -p "it105rocks" scp -o StrictHostKeyChecking=no bashrcTemplate user1@${turtl[i]}:.bashrc
    sshpass -p "it105rocks" ssh -o StrictHostKeyChecking=no user1@${turtl[i]} bash -s < it105_local.sh
    echo "2. Working on ${turtl[i]}, setting up as Turtlebot Computer."
    # Set the ROS_IP environmental variable in the .bashrc file based on the IP address of itself
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${turtl[i]} 'echo "export ROS_IP='${turtl[i]}'" >> ~/.bashrc' 
    # Set the ROS_MASTER_URI environmental variable in the .bashrc file based on the IP address of itself    
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${turtl[i]} 'echo "#export ROS_MASTER_URI=http://'${turtl[i]}':11311" >> ~/.bashrc'  
done

# For each control unit computer configure it
for ((i=0;i<${#cntrl[@]};++i)); do
    echo "3. Working on ${cntrl[i]}, updating bashrc and running script."
    # ping -c 3 ${cntrl[i]}
    sshpass -p "it105rocks" scp -o StrictHostKeyChecking=no bashrcTemplate user1@${cntrl[i]}:.bashrc
    sshpass -p "it105rocks" ssh -o StrictHostKeyChecking=no user1@${cntrl[i]} bash -s < it105_local.sh
    echo "4. Working on ${cntrl[i]}, setting up as Control Computer."
    # Set the ROS_IP environmental variable in the .bashrc file based on the IP address of itself
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${cntrl[i]} 'echo "export ROS_IP='${cntrl[i]}'" >> ~/.bashrc' 
    # Set the ROS_MASTER_URI environmental variable in the .bashrc file based on the IP address of the turtlebot computer    
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${cntrl[i]} 'echo "export ROS_MASTER_URI=http://'${turtl[i]}':11311" >> ~/.bashrc' 
    # Create a temporary copy of the Turtlebot Mapping Desktop Icon.
    cp TurtleMapping.desktop temp.desktop
    # Modify the temp file to match this pair of turtlebot computer and control computer.
    echo "Exec=terminator -x sshpass -p \"it105rocks\" ssh -t -o StrictHostKeyChecking=no user1@${turtl[i]} 'bash -ic \"roslaunch usma_turtlebot it105_remote_mapping.launch\" '" >> temp.desktop     
    # Use SCP to move the temp file to the desktop of the control computer.   
    sshpass -p "it105rocks" scp -o StrictHostKeyChecking=no temp.desktop user1@${cntrl[i]}:Desktop/TurtleMapping.desktop
    # Remove the temp file
    rm temp.desktop
    # Create a temporary copy of the Turtlebot Navigation Desktop Icon. 
    cp TurtleNavigating.desktop temp.desktop
    # Modify the temp file to match this pair of turtlebot computer and control computer.
    echo "Exec=terminator -x sshpass -p \"it105rocks\" ssh -t -o StrictHostKeyChecking=no user1@${turtl[i]} 'bash -ic \"roslaunch usma_turtlebot it105_remote_demo.launch\" '" >> temp.desktop   
    # Use SCP to move the temp file to the desktop of the control computer.    
    sshpass -p "it105rocks" scp -o StrictHostKeyChecking=no temp.desktop user1@${cntrl[i]}:Desktop/TurtleNavigating.desktop
    # Remove the temp file
    rm temp.desktop
    # Make both desktop icons executable
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${cntrl[i]} 'chmod +x Desktop/TurtleMapping.desktop' 
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${cntrl[i]} 'chmod +x Desktop/TurtleNavigating.desktop' 
done

