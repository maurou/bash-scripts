#!/bin/bash
echo "Por favor ingrese su gw:"
read gw
hoy=$(date +"%d-%m-%Y")
log="/home/log-"
log+=$hoy
cnt=0
while true
do
        d=$(date)
        ping -c 1 $gw > tmp
        if [ $? -ne 0 ]; then
                echo "Sin red " $d >> $log
                echo "**Procesos mayores a 80% **" >> $log
                ps -Ao user,uid,comm,pid,pcpu,tty --sort=-pcpu | awk '{if ($5 > "80") print $1 "  " $2 "  "  $3 "  " $4 "  " $5}' >> $log
                echo "**********************************" >> $log
                echo "" >> $log
                /etc/init.d/networking restart
                let cnt=cnt+1
                if [ $cnt -eq 2 ]; then
                        let cnt=cnt-2
                        echo "Reinicio " $d >> $log
                        sudo reboot
                fi
        fi
        sleep 1m
done