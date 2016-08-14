#!/bin/sh
if [ "x${4}" = "x" ]; then
  echo "Usage: setup.sh region appname environment tier"
  exit 1
fi
/usr/bin/mkfifo /var/opt/cloudwatch-gateway
/bin/echo "* * * * * root /opt/bin/run-monitors 2>&1 | /usr/bin/logger -t run-monitors -p local1.err" >> /etc/crontab
cat > /etc/init/cwg.conf <<EOF
start on runlevel [2345]
respawn
respawn limit unlimited
exec /opt/bin/cwg ${1} ${2}-${3}-${4} < /var/opt/cloudwatch-gateway 2>&1 | /usr/bin/logger -t cwg -p local1.info
EOF
