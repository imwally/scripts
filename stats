#!/bin/sh

uname=`uname`

case $uname in
    "Linux")
        get_battery_info() {
            BAT_PERC=`acpi | awk '{print +$4}'`
            BAT_STATUS=`acpi | awk '{print $3}'`
            BAT=`acpi | awk '{print $5}' | head -c 5`

	    
            if [ $BAT_STATUS = "Charging," ]; then
                BAT="+$BAT"
            fi

            if [ $BAT_STATUS = "Discharging," ] && [ $BAT_PERC -lt 10 ]; then
                BAT="!"
            fi

            if [ $BAT_STATUS = "Full," ] || [ $BAT_PERC = "99" ]; then
                BAT="100%"
            fi
        }
        get_volume_info() {
            VOL=`amixer get Master | grep "Left" | egrep -o "[0-9]+%"`
        }
	new_mail() {
	    NUM_MSG=`/bin/ls -1U ~/Mail/Inbox/new | wc -l`
	    if [ $NUM_MSG -gt 0 ]; then
		MAIL="MAIL $NUM_MSG"
	    else
		MAIL=""
	    fi
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
    new_mail
    echo "AC $BAT    VOL $VOL    $MAIL" 
    sleep 1 
done
