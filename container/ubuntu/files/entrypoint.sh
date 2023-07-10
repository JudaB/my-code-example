#!/bin/bash
uname -a
if [ -f /tmp/zip_job.py ] ; then
   echo "Exists"
else
   echo "Not Exists"
fi
