#!/bin/sh
set -xe

if [ ! -d /data/etc ]
then
  tar -xvf /tmp/data.tar
fi

exec /usr/sbin/sshd -D -e
echo "sshd failed"
