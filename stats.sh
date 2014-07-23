#!/bin/sh

uname=`uname`

case $uname in
    "Linux")
        get_battery_info() {
            BAT_PERC=`acpi | grep -E -o "[0-9].%" | cut -c -2`
            BAT_STATUS=`acpi | awk '{print $3}'`
            BAT=`acpi | awk '{print $5}' | head -c 5`
            
            if [ $BAT_STATUS = "Charging," ]; then
                BAT="+$BAT"
            else
                if [ $BAT_PERC -lt 10 ]; then
                    BAT="-$BAT !! DUDE, YOU NEED TO PLUG IN !!"
                else
                    BAT="-$BAT"
                fi 
            fi 
        }
        get_volume_info() {
            VOL=`amixer get Master | grep "Left" | egrep -o "[0-9]+%"`
        }
    ;;
    "OpenBSD")
        get_battery_info() {
            BAT_H=$((`apm -m`/60))
            BAT_M=$((`apm -m`%60))
            BAT=$BAT_H:$BAT_M
        }
        get_volume_info() {
            VOL=`mixerctl -n outputs.master | sed 's/^[0-9]*,//g'`
            VOL=`echo $(($VOL*100/255)) | bc`
        }
    ;;
esac

while true; do
    get_battery_info
    get_volume_info
    echo "AC $BAT    VOL $VOL" 
    sleep 1 
done
