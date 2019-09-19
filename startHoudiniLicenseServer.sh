#!/bin/bash

# Probably a simple, but bad idea:
#/etc/init.d/sesinetd start

# Cut another step out:
#/usr/lib/sesi/sesinetd_safe --sesi=/usr/lib/sesi --sesinetd=/usr/lib/sesi/sesinetd --log-file=/dev/stdout --pid-file=/var/run/sesinetd.pid -V 3 -z 0 -y 0 -m *.*.*.* -M *.*.*.* -p 1717 -W 1 -l /dev/stdout -u /dev/stdout

# Copy installed folder to volume mount (no clobber) and then sym link volume back in place
if [[ ! -L /usr/lib/sesi/ && -d /usr/lib/sesi ]]; then
    cp -R -n /usr/lib/sesi/** /usr/lib/sesi-docker/ || true
    rm -rf /usr/lib/sesi/
    ln -s /usr/lib/sesi-docker/ /usr/lib/sesi
fi

# Finally, the actual binary and it's flags
/usr/lib/sesi/sesinetd -l /dev/stdout -D -V 3 -z 0 -y 0 -m *.*.*.* -M *.*.*.* -p 1715 -W 1 -l /dev/stdout -u /dev/stdout -R /var/run/sesinetd.pid