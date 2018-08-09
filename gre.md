## 기본 설정

### 설명

* gre tunnel은 가상 인터페이스이다.
* 여기서는 실제 인터페이스인 enp0s8에 가상 터널 2개(tunnel1, tunnel2)를 만들어 enp0s8이 가진 대역폭을 나눠 가진다.
* 이 예제에서는 총 2가지 테스트를 진행한다.
  1. enp0s8의 대역폭은 1000Mbit/s로 정한다.
  2. 첫 번째는 tunnel1의 대역폭은 5Mbit, tunnel2의 대역폭은 나머지를 모두 할당하여 동영상 스트리밍을 __tunnel1에__ 했을 시 __끊기는 모습을 보여준다.__
  3. 두 번째는 tunnel1의 대역폭은 50bit, tunnel2의 대역폭은 나머지를 모두 할당하여 동영상 스트리밍을 __tunnel1에__ 했을 시 __정상적으로 스트리밍 되는 모습을 보여준다.__
  4. 이러한 예제를 통해 인터페이스에서 가상 인터페이스(터널)를 만들어 차등 서비스를 지원할 수 있다는 것을 보여줄 수 있다.
 
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
sudo tc qdisc change dev tunnel2 root handle 1:0 tbf rate 950Mbit burst 500k latency 1ms
</pre> 

### 차등 트래픽 START

#### 양쪽다

<pre>
sudo tc qdisc change dev tunnel1 root handle 1:0 tbf rate 50Mbit burst 500k latency 1ms
sudo tc qdisc change dev tunnel2 root handle 1:0 tbf rate 850Mbit burst 500k latency 1ms
</pre>
 
