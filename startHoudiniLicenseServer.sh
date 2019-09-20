#!/bin/bash

# Probably a simple, but bad idea:
#/etc/init.d/sesinetd start

# Cut another step out:
#/usr/lib/sesi/sesinetd_safe --sesi=/usr/lib/sesi --sesinetd=/usr/lib/sesi/sesinetd --log-file=/dev/stdout --pid-file=/var/run/sesinetd.pid -V 3 -z 0 -y 0 -m *.*.*.* -M *.*.*.* -p 1717 -W 1 -l /dev/stdout -u /dev/stdout

# Finally, the actual binary and it's flags
/usr/lib/sesi/sesinetd -l /dev/stdout -D -V 3 -z 0 -y 0 -m *.*.*.* -M *.*.*.* -p 1715 -W 1 -l /dev/stdout -u /dev/stdout -R /var/run/sesinetd.pid