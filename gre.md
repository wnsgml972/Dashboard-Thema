## 기본 설정
 
### 191.168.10.1에서의 설정 

* $ cat gre.sh

<pre>
sudo ip tunnel add tunnel1 mode gre remote 192.168.10.1 local 192.168.10.2 dev enp0s8 key 100
sudo ip tunnel add tunnel2 mode gre remote 192.168.10.1 local 192.168.10.2 dev enp0s8 key 200
sudo ifconfig tunnel1 192.168.100.2 netmask 255.255.255.252 pointopoint 192.168.100.1
sudo ifconfig tunnel1 mtu 1500 up
sudo ifconfig tunnel2 192.168.200.2 netmask 255.255.255.252 pointopoint 192.168.200.1
sudo ifconfig tunnel2 mtu 1500 up
sudo tc qdisc add dev tunnel1 root handle 1:0 tbf rate 50Mbit burst 500k latency 1ms
sudo tc qdisc add dev tunnel2 root handle 1:0 tbf rate 950Mbit burst 500k latency 1ms
</pre>
 
### 192.168.10.2에서의 설정

* $ cat gre.sh

<pre>
sudo ip tunnel add tunnel1 mode gre remote 192.168.10.2 local 192.168.10.1 dev enp26s0f0 key 100
sudo ip tunnel add tunnel2 mode gre remote 192.168.10.2 local 192.168.10.1 dev enp26s0f0 key 200
sudo ifconfig tunnel1 192.168.100.1 netmask 255.255.255.252 pointopoint 192.168.100.2
sudo ifconfig tunnel1 mtu 1500 up
sudo ifconfig tunnel2 192.168.200.1 netmask 255.255.255.252 pointopoint 192.168.200.2
sudo ifconfig tunnel2 mtu 1500 up
sudo tc qdisc add dev tunnel1 root handle 1:0 tbf rate 50Mbit burst 500k latency 1ms
sudo tc qdisc add dev tunnel2 root handle 1:0 tbf rate 950Mbit burst 500k latency 1ms
</pre>
 
* 영상은 192.168.100.1로 흘리고

* iperf 는 192.168.200.1로 돌리고

* bw 그래프는 192.168.10.1 과 192.168.100.1 이 나오게
 

 
### 일반 트래픽 START

#### 양쪽다

<pre>
sudo tc qdisc change dev tunnel1 root handle 1:0 tbf rate 5Mbit burst 500k latency 1ms
sudo tc qdisc add dev tunnel2 root handle 1:0 tbf rate 950Mbit burst 500k latency 1ms
</pre> 

### 차등 트래픽 START

#### 양쪽다

<pre>
sudo tc qdisc change dev tunnel1 root handle 1:0 tbf rate 50Mbit burst 500k latency 1ms
sudo tc qdisc change dev tunnel2 root handle 1:0 tbf rate 850Mbit burst 500k latency 1ms
</pre>
 
