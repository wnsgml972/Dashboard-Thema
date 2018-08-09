sudo tc qdisc change dev tunnel1 root handle 1:0 tbf rate 5Mbit burst 500k latency 1ms
sudo tc qdisc change dev tunnel2 root handle 1:0 tbf rate 950Mbit burst 500k latency 1ms
