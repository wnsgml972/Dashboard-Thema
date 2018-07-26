ifconfig enp0s8 down
sudo kill -9 `ps -ef | grep iperf | awk '{print $2}'`
