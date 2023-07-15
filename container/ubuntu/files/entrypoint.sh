#!/bin/bash
echo "Execute EntryPoint"

/usr/sbin/sshd -D  &

echo $#
echo "$@"

if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
	uname -a
	if [ -f /tmp/zip_job.py ] ; then
	    	echo "[INFO] Zip Exists"
	else
   		echo "[CRITICAL] Zip does Not Exists"
	fi
fi

echo "Executing" "$@"
exec "$@"
