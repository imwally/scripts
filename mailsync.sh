#!/bin/sh

while true; do
    date;
    mbsync -a;
    sleep 300; # 5 minutes
done
