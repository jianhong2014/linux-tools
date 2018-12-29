#!/bin/bash
# Get current swap usage for all running processes
# 
getPidSwap(){
  swapSum=0
  for SWAP in `grep Swap /proc/$1/smaps 2>/dev/null| awk '{ print $2 }'`
        do
                let swapSum=$swapSum+$SWAP
  done
  echo "pid:$1, Swap used: $swapSum,percent:$swapSum/$2"  
  return $swapSum 
}


SUM=0
OVERALL=0
interval=1
numInterval=10
qpid=0
while getopts :i:n:p:t opt
do  
    case $opt in
        i)  
            #echo "-i=$OPTARG"
            interval=$OPTARG
            ;;
        n)
            #echo "-n=$OPTARG"
            numInterval=$OPTARG
            ;;
        p)  
            #echo "-p=$OPTARG"
            qpid=$OPTARG
            ;;
        *)  
            echo "-$OPTARG not recognized"
            ;;
    esac
done

if [ $qpid == 0 ]; then
  echo "no query pid set"
  exit
fi 

for DIR in `find /proc/ -maxdepth 1 -type d | egrep "^/proc/[0-9]"` ; do
        PID=`echo $DIR | cut -d / -f 3`
        PROGNAME=`ps -p $PID -o comm --no-headers`
        for SWAP in `grep Swap $DIR/smaps 2>/dev/null| awk '{ print $2 }'`
        do
                let SUM=$SUM+$SWAP
        done
        let OVERALL=$OVERALL+$SUM
        SUM=0

done


int=1
while(( $int<=numInterval ))
do
    getPidSwap $qpid $OVERALL
    pidSwapSum=$?
    sleep $interval 
    let "int++"
done
