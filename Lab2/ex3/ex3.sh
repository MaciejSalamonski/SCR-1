#!/bin/bash

endCount=10
startCount=1

while [ $startCount -le $endCount ]
do
  echo "$startCount"
  startCount=$(( $startCount + 1 ))
  sleep 10
done

