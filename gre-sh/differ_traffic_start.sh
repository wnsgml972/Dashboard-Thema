sudo tc qdisc change dev tunnel1 root handle 1:0 tbf rate 50Mbit burst 500k latency 1ms
sudo tc qdisc change dev tunnel2 root handle 1:0 tbf rate 850Mbit burst 500k latency 1ms
