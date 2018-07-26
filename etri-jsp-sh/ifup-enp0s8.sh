ifconfig enp0s8 up
sleep 3
iperf -c 192.168.10.2 -t 1000000 -i 2
