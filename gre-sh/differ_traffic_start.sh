sudo tc qdisc change dev tunnel1 root handle 1:0 tbf rate 50Mbit burst 500k latency 1ms
sudo tc qdisc change dev tunnel2 root handle 1:0 tbf rate 850Mbit burst 500k latency 1ms
iperf -c 192.168.200.2 -t 10000 &
ffmpeg -i ftp://user:1@192.168.100.2/sample.mp4 -hls_allow_cache 0 -threads 8 -cpu-used 5 -deadline realtime -an http://localhost:12390/feed1.ffm
