#!/bin/sh

for i in $(cat adresy.txt)
do
    mail -s "Great offert" $i -A spec.pdf < tresc.txt
done
