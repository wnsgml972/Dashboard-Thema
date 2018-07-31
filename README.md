
## ETRI Dashboard 정리

## 환경 설정 (ubuntu 16.04, tomcat 8)
* Tomcat
  * <https://wnsgml972.github.io/linux/ubuntu-tomcat.html>
* JSP 
  * <https://wnsgml972.github.io/linux/linux_jsp.html>
* ffserver conf 를 이용한 ffserver 실행 
  * 설치 <https://wnsgml972.github.io/ffmpeg/ffmpeg_ffserver-config.html>
  * 사용법 <https://wnsgml972.github.io/ffmpeg/ffmpeg_ffserver-streamming.html>

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
  * ffserver.conf,  네트워크 대역폭 사용자가 한계 설정 명령어 모음
* etri-jsp-sh 
  * 쉘 스크립트 모음
  * ifdown ifup, 원하는 인터페이스 down 또는 up 조절
  * play-ffmpeg, input url 조절
  * bw.sh 네트워크 대역폭 1초마다 계속,  bw1.sh 네트워크 대역폭 한번 

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

