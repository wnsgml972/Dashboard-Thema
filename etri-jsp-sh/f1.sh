
INTERVAL="1"  # update interval in seconds
 
if [ -z "$1" ]; then
        echo
        echo usage: $0 [network-interface]
        echo
        echo e.g. $0 eth0
        echo
        exit
fi
 
IF=$1
while true
do
  T1=`cat /sys/class/net/$1/statistics/tx_bytes`
  R1=`cat /sys/class/net/$1/statistics/rx_bytes`
  sleep $INTERVAL
  T2=`cat /sys/class/net/$1/statistics/tx_bytes`
  R2=`cat /sys/class/net/$1/statistics/rx_bytes`
  TBPS=`expr $T2 - $T1`
  RBPS=`expr $R2 - $R1`
  TBiPS=`expr $TBPS \* 8`
  RBiPS=`expr $RBPS \* 8`
  TMBPS=`expr $TBPS / 1024`
  RMBPS=`expr $RBPS / 1024`
  TMBPSF=`echo "${TMBPS} ${TBPS}" |
      awk '{printf "%.3f", $1 + ($2 * 8) % 1024 * 0.001}'`
  RMBPSF=`echo "${RMBPS} ${RBPS}" |
      awk '{printf "%.3f", $1 + ($2 * 8) % 1024 * 0.001}'`
  AMBPSF=`echo "${TMBPSF} ${RMBPSF}" | awk '{printf "%.3f", $1 + $2}'`
#  echo $AMBPSF $T1 $T2 $TBPS $TBiPS $R1 $R2 $RBPS $RBiPS
  echo $AMBPSF
done
