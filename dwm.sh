#!/bin/sh

TEMP=$(awk '{print $2}' /proc/acpi/thermal_zone/TZ00/temperature)
LOAD=$(awk '{print $1}' /proc/loadavg)
DATE=$(date "+%a, %b %d %T")

STATE=$(grep '^charging state:' /proc/acpi/battery/BAT0/state | awk '{print $NF}')
REMAINS=$(grep '^remaining capacity:' /proc/acpi/battery/BAT0/state | awk '{print $(NF-1)}')
RATE=$(grep '^present rate:' /proc/acpi/battery/BAT0/state | awk '{print $(NF-1)}')

MAH_MAX=$(grep '^last full capacity:' /proc/acpi/battery/BAT0/info | awk '{print $(NF-1)}')
MAH_MIN=$(grep '^design capacity warning:' /proc/acpi/battery/BAT0/info | awk '{print $(NF-1)}')

PERC_LEFT=$((${REMAINS}*100/${MAH_MAX}))

case $STATE in
        charging)
                if [[ $RATE -eq 0 ]]; then
                   TIME_LEFT="∞"
                else
                   TIME_LEFT=$(($((${MAH_MAX}-${REMAINS}))*60/$RATE))min 
                fi
                ;;
        discharging)
                TIME_LEFT=$(($((${REMAINS}-${MAH_MIN}))*60/$RATE))min
                ;;
        charged)
                TIME_LEFT="charged"
                ;;
        *)
                TIME_LEFT=$STATE
                ;;
esac

xsetroot -name "${TIME_LEFT} $PERC_LEFT%  $LOAD  ${TEMP}*C  $DATE"