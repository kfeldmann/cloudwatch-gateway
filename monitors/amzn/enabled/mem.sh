#!/bin/sh
A=$(/bin/grep MemAvailable /proc/meminfo | /bin/awk '{print $2}')
T=$(/bin/grep MemTotal /proc/meminfo | /bin/awk '{print $2}')
AP=$(/bin/echo "scale=1; 100-(${A}*100)/${T}" | /usr/bin/bc)
/bin/echo "MemUsagePct ${AP} Percent"
