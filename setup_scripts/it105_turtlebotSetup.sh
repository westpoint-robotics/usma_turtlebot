#!/bin/bash
# IT105 Turtlebot Demo setup script
# This script relies on it105_local.sh to do some of the work.

# Create an array of servers to configure
declare -a comps=("192.168.200.60" "192.168.200.123" "192.168.200.117" "192.168.200.105" "192.168.200.202" "192.168.200.55")
declare -a turtl=("192.168.200.123" "192.168.200.105" "192.168.200.202")
declare -a cntrl=("192.168.200.60" "192.168.200.117" "192.168.200.55")

# For each computer configure it
for i in "${comps[@]}"; do
    echo "1. Working on $i, updating bashrc and running script."
    # ping -c 3 $i
    sshpass -p "it105rocks" scp -o StrictHostKeyChecking=no bashrcTemplate user1@$i:.bashrc
    sshpass -p "it105rocks" ssh -o StrictHostKeyChecking=no user1@$i bash -s < it105_local.sh
done

# For each turtlebot computer configure it
for ((i=0;i<${#turtl[@]};++i)); do
    echo "2. Working on ${turtl[i]}, setting up as Turtlebot Computer."
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${turtl[i]} 'echo "export ROS_IP='${turtl[i]}'" >> ~/.bashrc' 
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${turtl[i]} 'echo "#export ROS_MASTER_URI=http://'${cntrl[i]}':11311" >> ~/.bashrc' 
    cp TurtleMapping.desktop temp.desktop
    echo "Exec=terminator -x sshpass -p \"it105rocks\" ssh -t -o StrictHostKeyChecking=no user1@${cntrl[i]} 'bash -ic \"roslaunch usma_turtlebot it105_remote_mapping.launch\" '" >> temp.desktop    
    sshpass -p "it105rocks" scp -o StrictHostKeyChecking=no temp.desktop user1@${turtl[i]}:Desktop/TurtleMapping.desktop
    rm temp.desktop 
    cp TurtleNavigating.desktop temp.desktop
    echo "Exec=terminator -x sshpass -p \"it105rocks\" ssh -t -o StrictHostKeyChecking=no user1@${cntrl[i]} 'bash -ic \"roslaunch usma_turtlebot it105_remote_demo.launch\" '" >> temp.desktop    
    sshpass -p "it105rocks" scp -o StrictHostKeyChecking=no temp.desktop user1@${turtl[i]}:Desktop/TurtleNavigating.desktop
    rm temp.desktop
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${turtl[i]} 'chmod +x Desktop/TurtleMapping.desktop' 
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${turtl[i]} 'chmod +x Desktop/TurtleNavigating.desktop' 
done

# For each control unit computer configure it
for ((i=0;i<${#cntrl[@]};++i)); do
    echo "3. Working on ${cntrl[i]}, setting up as Control Computer."
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${cntrl[i]} 'echo "export ROS_IP='${cntrl[i]}'" >> ~/.bashrc' 
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${cntrl[i]} 'echo "export ROS_MASTER_URI=http://'${turtl[i]}':11311" >> ~/.bashrc' 
    cp TurtleMapping.desktop temp.desktop
    echo "Exec=terminator -x sshpass -p \"it105rocks\" ssh -t -o StrictHostKeyChecking=no user1@${turtl[i]} 'bash -ic \"roslaunch usma_turtlebot it105_remote_mapping.launch\" '" >> temp.desktop    
    sshpass -p "it105rocks" scp -o StrictHostKeyChecking=no temp.desktop user1@${cntrl[i]}:Desktop/TurtleMapping.desktop
    rm temp.desktop 
    cp TurtleNavigating.desktop temp.desktop
    echo "Exec=terminator -x sshpass -p \"it105rocks\" ssh -t -o StrictHostKeyChecking=no user1@${turtl[i]} 'bash -ic \"roslaunch usma_turtlebot it105_remote_demo.launch\" '" >> temp.desktop    
    sshpass -p "it105rocks" scp -o StrictHostKeyChecking=no temp.desktop user1@${cntrl[i]}:Desktop/TurtleNavigating.desktop
    rm temp.desktop
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${cntrl[i]} 'chmod +x Desktop/TurtleMapping.desktop' 
    sshpass -p "it105rocks" ssh -t -o StrictHostKeyChecking=no user1@${cntrl[i]} 'chmod +x Desktop/TurtleNavigating.desktop' 
done

