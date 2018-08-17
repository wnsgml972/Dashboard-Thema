kill -9 `ps -ef | grep ffmpeg | awk '{print $2}'`
kill -9 `ps -ef | grep iperf | awk '{print $2}'`
