#!/bin/bash

#Create file named servers.txt and keep all remote hosts.

for host in `cat server.txt`
do
	echo "Checking server health of:: Disk, Memory and CPU"
	ssh username@"$host" 'df -h;free -m;mpstat 1 3' || echo "Faild to connect to server"
        echoo "----------------------------------------------------------------"
done
