#!/bin/sh
set -xe
mkdir -pv /stage/var/empty /stage/run /stage/tmp /stage/etc /stage/bin /stage/root

cp -v /opt/ssh/* /etc/ssh
/usr/bin/ssh-keygen -A
mv /etc/ssh /stage/etc
cp -v /opt/bin/* /stage/bin
chmod -v +x /stage/bin/*.sh

tar cvf /stage/tmp/data.tar /data \

ln -sfv /data/etc/passwd /data/etc/shadow /data/etc/group /etc
cpio -d -p /stage <<EOD
/etc/passwd
/etc/shadow
/etc/group
/bin/busybox
/usr/bin
/sbin
/usr/sbin/sshd
EOD

ls /lib/l* | cpio -d -p /stage

chroot /stage /bin/busybox --install
echo "all done"
