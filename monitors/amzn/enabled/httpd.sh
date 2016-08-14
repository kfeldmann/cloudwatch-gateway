#!/bin/sh
H=$(/bin/ps -u apache 2>/dev/null | /bin/grep -c httpd)
MPMCONF=$(/usr/bin/find /etc/httpd -type f -name "*.conf" \
  -exec grep -i MaxRequestWorkers {} \; -print 2>/dev/null | tail -1)
if [ "x${MPMCONF}" = "x" ]; then
  /bin/echo "HTTPDProcessCount $H Count"
else
  M=$(/bin/grep MaxRequestWorkers ${MPMCONF} 2>/dev/null \
    | /bin/awk '{print $2}')
  HP=$(/bin/echo "scale=4; ($H*100)/$M" | /usr/bin/bc)
  /bin/echo "HTTPDProcessesPct $HP Percent"
fi
