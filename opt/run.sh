#!/bin/sh
set -xe

mkdir -pv /data/etc
if [ ! -h /etc/passwd ]
then
	if [ ! -f /data/etc/passwd ]
	then
		mv -v /etc/passwd /data/etc
		mv -v /etc/shadow /data/etc
		mv -v /etc/group /data/etc
	fi
	ln -sfv /data/etc/passwd /etc/passwd
	ln -sfv /data/etc/shadow /etc/shadow
	ln -sfv /data/etc/group /etc/group
fi


if [ ! -d /data/skel ]
then
	/opt/create.sh skel
fi

echo "prep done"

exec /usr/sbin/sshd -D -e
echo "sshd failed"
