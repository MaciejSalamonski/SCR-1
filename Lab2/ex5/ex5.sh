#!/bin/bash
## ctrl c - SIGQUIT,

name=${0##*/}
echo -e "Script - PID \v"
ps -C $name -o pid=
echo -e " \v"

trap 'echo "  Insensitive to SIGINT"' 2 #SIGINT
trap 'echo "  Insenstiive to SIGQUIT"' 3 #SIGQUIT
trap 'echo "  Insensitive to SIGFPE"' 4 #SIGILL
trap 'echo "  Insensitvie to SIGFPE"' 8 #SIGFPE

while true
do
    echo " `date +"%H:%M:%S"`"
    sleep 10
done
