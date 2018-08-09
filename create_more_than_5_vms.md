## Create more than 5 VMs

### 현재 VB 에서 기본적으로 어댑터가 4개로 설정되어 있음

### nic5 생성

1. cmd (관리자 모드)

2. C:\Program Files\Oracle\VirtualBox\

3. vboxmanage modifyvm vm-name --nic5 hostonly --cableconnected5 on --hostonlyadapter5 "VirtualBox Host-Only Ethernet Adapter #11" --nicpromisc5 allow-all

4. vboxmanage modifyvm vm-name2 --nic5 hostonly --cableconnected5 on --hostonlyadapter5 "VirtualBox Host-Only Ethernet Adapter #11" --nicpromisc5 allow-all

5. 현재 존재하는 Adaptor #와 연결하기 (없으며 만들고 생성된 번호와 연결하기)

6. VM shutdown 후 실행
