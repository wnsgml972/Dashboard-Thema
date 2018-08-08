#!/bin/bash
# interface enp0s8 connect

INTERVAL="1"  # update interval in seconds
 
IF=$1
 
while true
do
	wget http://192.168.1.2:/file1 -O /home/user/file1
	sleep $INTERVAL
        wget http://192.168.1.2:/file2 -O /home/user/file2
	sleep $INTERVAL
        wget http://192.168.1.2:/file3 -O /home/user/file3
	sleep $INTERVAL
        wget http://192.168.1.2:/file4 -O /home/user/file4
        sleep $INTERVAL
        rm file1.*
        rm file2.*
        rm file3.*
        rm file4.*
        sleep $INTERVAL
done
