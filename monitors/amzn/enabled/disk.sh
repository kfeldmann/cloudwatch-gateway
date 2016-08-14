#!/bin/sh
df -l -x devtmpfs -x tmpfs --output=target,ipcent,pcent \
  | tail -n +2 \
  | sed -e 's/%//g' \
  | { while read TG IP SP; do
        /bin/echo "DiskInodePct-${TG} ${IP} Percent"
        /bin/echo "DiskSpacePct-${TG} ${SP} Percent"
      done
    };
