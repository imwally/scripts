#!/bin/sh

uname=`uname`

if [[ $uname == "Linux" ]]; then
  show_bat() {
    BAT=`acpi | awk '{print $5}' | head -c 5`
  }
  show_vol() {
    VOL=`amixer get Master | egrep -o "[0-9]+%"`
  }
fi

if [[ $uname == "OpenBSD" ]]; then
  show_bat() {
    BAT_H=$((`apm -m`/60))
    BAT_M=$((`apm -m`%60))
    BAT=$BAT_H:$BAT_M
  }
  show_vol() {
    VOL=`mixerctl -n outputs.master | sed 's/^[0-9]*,//g'`
  VOL=`echo $(($VOL*100/255)) | bc`
  }
fi

while true; do
  show_bat
  show_vol
  echo "BAT: $BAT    VOL: $VOL%"
  sleep 10 
done
