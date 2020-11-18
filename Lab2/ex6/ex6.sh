1 #!/bin/bash
## ctrl c - SIGINT,

fileName=${0##*/}
echo -e "Script PID $$ \v"
name=`ps -C $fileName -o pid=`
echo "$name"
echo -e " \v"

 while true
 do
     echo " `date +"%H:%M:%S"`"
     sleep 10
done

