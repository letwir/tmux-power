#!/bin/bash
# CPUの負荷
read F1 F2 F3 F4 F5 < /proc/loadavg
## １分間負荷　５分間負荷　１５分間負荷　プロセス数／待機プロセス　PID
printf " %03sP" "${F4%%/*}" # プロセス数
printf "[%4.1f" "$F1" # -負荷
printf "/%2s]C " $(nproc) # CPU数

# I/O負荷
INTERVAL=1
read -r _ _ _ _ _ _ _ _ _ T1 _ < /sys/class/block/mmcblk1/stat
sleep $INTERVAL
read -r _ _ _ _ _ _ _ _ _ T2 _ < /sys/class/block/mmcblk1/stat
# 計算式：T2-T1ミリ秒を秒に、これを％にする。
# (T2-T1) / 1000 * 100
printf " "%3s"％" "$(((T2-T1)/10))"

# メモリ空き
INFO=`cat /proc/meminfo |head -n2|tail -n1`
LC_NUMERIC="en_US.UTF-8" printf " % '7d㍋" "$((${INFO//[^0-9]/} / 1000))"
exit 0
