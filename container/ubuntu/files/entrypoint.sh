#!/bin/bash
echo "Execute EntryPoint"

/usr/sbin/sshd -D  &

echo $#
echo "$@"

uname -a
if [ -f /tmp/zip_job.py ] ; then
    	echo "[INFO] Zip Exists"
else
	echo "[CRITICAL] Zip does Not Exists"
	exit 1
fi

# This is use to allow docker-plugin
# to execute cat this way it hold the container run
# and jenkins is runing within the container

if [ "$#" -gt 0 ]; then
	echo "Executing" "$@"
	exec "$@"
fi

