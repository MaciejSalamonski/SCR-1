#!/bin/bash

mFlag=0
nFlag=0
aFlag=0

modifiedTime=0
extension="*.*"
archiveName=defaultArchive.tar

while getopts ":n:m:a:" options;
do
    case ${options} in
	n)
	    nFlag=1
	    modifiedTime=$OPTARG
	    ;;
	m)
	    mFlag=1
	    extension=$OPTARG
	    ;;
	a)
	    aFlag=1
	    archiveName=$OPTARG
	    ;;
	*)
	    nFlag=1
	    mFlag=1
	    aFlag=1
	    ;;

    esac
done

if test $nFlag -eq 0
then
	echo "Type file last modified time [in days]:"
	read modifiedTime
fi

if test $mFlag -eq 0
then
	echo "Type file name/extension:"
	read extension
fi

if test $aFlag -eq 0
then
	echo "Type the name of archive you want to create:"
	read archiveName
fi

echo -e "Modified time [days]: $modifiedTime \v"
echo -e "Name/Extension:: $extension \v"
echo -e "Archive name: $archiveName \v"

echo -e "The archive has been created! :) \v"

find $(pwd) -type f -name "$extension.*" -mtime -$modifiedTime | xargs tar -rvf  $archiveName.tar -P
