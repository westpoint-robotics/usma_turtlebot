#!/usr/bin/env python
import time
import rospy
from copy import copy
from std_msgs.msg import String, ColorRGBA
from geometry_msgs.msg import Point
from visualization_msgs.msg import Marker
import apfinder as apf

if __name__ == "__main__":
    point=Point()
    color=ColorRGBA()
    wifiPoints = []
    wifiColors = []
    for i in range(5):        
        point.x=i/2.0
        point.y=1
        point.z=1  
        wifiPoints.append(copy(point))
        color.r=1.0
        color.a=1.0
        wifiColors.append(copy(color))
    
    print(wifiPoints)
    pub = rospy.Publisher("smarker", Marker, queue_size = 100)
    rospy.init_node('smarker_node', anonymous=True)
    marker=Marker()
    marker.header.frame_id = "/map"
    #marker.type = marker.SPHERE
    marker.type = marker.POINTS
    marker.action = marker.ADD
    marker.pose.orientation.w = 1

    marker.points = wifiPoints
    marker.colors = wifiColors
    #t = rospy.Duration()
    #marker.lifetime = t
    marker.scale.x = 0.05
    marker.scale.y = 0.05
    marker.scale.z = 0.05

    
    
    rate = rospy.Rate(10) # 10hz
    while not rospy.is_shutdown():
        #marker.pose.position.x = 1.0 
        marker.header.stamp = rospy.Time.now()   
        sig = apf.check_connected_ap()    
        pub.publish(marker)
        rate.sleep()
