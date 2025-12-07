#!/bin/bash
# CPUの負荷
read F1 F2 F3 F4 F5 < /proc/loadavg
## １分間負荷　５分間負荷　１５分間負荷　プロセス数／待機プロセス　PID
printf "%03s" "${F4%%/*}" # プロセス数
printf P\["%.1f" "$F1" # -負荷
printf "/`nproc`"\] # CPU数

# I/O負荷
INTERVAL=1
read -r _ _ _ _ _ _ _ _ _ T1 _ < /sys/class/block/mmcblk1/stat
sleep $INTERVAL
read -r _ _ _ _ _ _ _ _ _ T2 _ < /sys/class/block/mmcblk1/stat
# 計算式：T2-T1ミリ秒を秒に、これを％にする。
# (T2-T1) / 1000 * 100
printf "　"%04s "$(((T2-T1)/10))% "

# メモリ空き
INFO=`cat /proc/meminfo |head -n2|tail -n1`
printf "　"%06s "$((${INFO//[^0-9]/} / 1000))M"

exit 0
