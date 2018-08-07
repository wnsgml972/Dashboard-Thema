
## ETRI Dashboard 정리

## 환경 설정 (ubuntu 16.04, tomcat 8)
* Tomcat
  * <https://wnsgml972.github.io/linux/linux_ubuntu_tomcat.html>
* JSP
  * <https://wnsgml972.github.io/linux/linux_jsp.html>
* ffserver conf 를 이용한 ffserver 실행
  * 설치 <https://wnsgml972.github.io/ffmpeg/ffmpeg_ffserver_config.html>
  * 사용법 <https://wnsgml972.github.io/ffmpeg/ffmpeg_ffserver_streamming.html>

## clone시 할 것
  1. /dashboard/conf/ffserver.conf의 ACL allow에 스트리밍 서버를 올릴 ip 추가  [conf 파일 변경]
  2. user로 로그인하여 root 의 위치를 " /home/user " 로 만들거나, /dashboard/WebContent/jsp/* 파일들의 실행 path 모두 변경
  3. localhost interface 설정 <https://github.com/wnsgml972/Dashboard-Thema/blob/etri/localhost.md>
  4. IpSec 설정 <https://github.com/wnsgml972/Dashboard-Thema/blob/etri/ipsec.md>

## 키워드 [ 조절 ]
* 프로그래밍 시 url path나 chart를 수정

<hr/>

### HTML
* index.html  
  * __media event__ 버튼 클릭, url path 조절

### Directory
* jsp
  * process build bath 조절
* conf
  * ffserver.conf  
  * VM local 환경에서 네트워크 대역폭 한계 설정 명령어 모음, 수신량만 조절 가능, 송신량은 조절 불가
* etri-jsp-sh
  * 쉘 스크립트 모음
  * ifdown ifup, 원하는 인터페이스 down 또는 up 조절
  * play-ffmpeg, input url 조절
  * bw.sh 네트워크 대역폭 1초마다 계속,  bw1.sh 네트워크 대역폭 한번, <https://github.com/wnsgml972/Dashboard-Thema/blob/etri/bandwidth.md>

### Java Script
* build/js/custom.min.js
  * junhee code (제일 위, 제일 아래)
  * lineChart 검색( 여기서 네트워크 대역폭 차트 조절 )
* build/js/custom.jun.js  
  * 커스텀 자바 스크립트

### Flow
* index.html의 media event 버튼 클릭 시
  1. jsp 코드 호출
  2. jsp 코드 내에서 프로세스 빌더를 이용해 쉘 스크립트 실행
  3. 결과를 ajax로 가져와 실행
* onload시 1초마다 bw1.sh를 실행하여 네트워크 대역폭을 line chart에 대입
* JSP를 이용한 쉘 스크립트 실행 <https://wnsgml972.github.io/linux/linux_shellscript.html>
