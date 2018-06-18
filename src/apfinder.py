#!/usr/bin/env python
import subprocess
import time
import rospy
from std_msgs.msg import String

def check_connected_ap():
    cmd =["nmcli -f BSSID,ACTIVE dev wifi list | awk '$2 ~ /yes/ {print $1}'"]
    address = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
    (out, err) = address.communicate()
    sigInfo=''
    with open("/proc/net/wireless", "r") as f:
        data = f.read()
        data_list=data.split()
        if (len(data_list) > 31):
            sigInfo = data_list[29].replace(".","")+","+data_list[30].replace(".","")+","+data_list[31]
    return out.strip() + "," + sigInfo

if __name__ == "__main__": 
    pub = rospy.Publisher('network_stats', String, queue_size=10)
    rospy.init_node('network_monitor', anonymous=True)
    rate = rospy.Rate(10) # 10hz
    while not rospy.is_shutdown():
        msg = check_connected_ap()
        print(msg)        
        pub.publish(msg)
        rate.sleep()



'''
#!/bin/bash
IFACE="wlan0"
LIMIT="-75"
while true; do
        signal=$(iw $IFACE link | grep signal | awk '{print $2}')
        [ $signal ] && [ $signal -lt $LIMIT ] && iw $IFACE disconnect
        echo $signal
        sleep 1
done
source: https://superuser.com/questions/441400/how-can-i-control-switching-between-wireless-aps-on-linux





'''
