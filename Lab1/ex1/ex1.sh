#!/bin/sh

export LC_ALL=C

currentDay=$(date +%u)

saturday=6
sunday=7

if [ $currentDay == $saturday ]
then
    echo "SATURDAY!"
elif [ $currentDay == $sunday ]
then
    echo "SUNDAY!"
else
    echo "We have to go to work :("
fi
