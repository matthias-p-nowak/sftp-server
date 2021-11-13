#!/bin/sh

echo "got arguments $*"

if [ -d /data/skel ]
then
  SK=/data/skel/
else
  SK=/opt/skel
fi


for F in $*
do
	HD="/data/$F"
  /usr/sbin/adduser -h $HD -k $SK -s /bin/false --disabled-password $F
	chmod -Rv  go= $HD/etc
	chown root:root $HD
	chmod go=rx $HD
	passwd -u $F
done

awk -e '{ print $1, $6 }' -F: </etc/passwd |
while read U D
do
	if [ ! -e $D ]
	then
		echo "removing $U"
		deluser --remove-home $U
	fi
done
