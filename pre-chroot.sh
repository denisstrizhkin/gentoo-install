#!/bin/bash

TARBALL_URL='https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/20230326T170209Z/stage3-amd64-systemd-20230326T170209Z.tar.xz'
MIRROR_URL='https://mirror.yandex.ru/gentoo-distfiles/'


cd /mnt/gentoo

wget "${URL}"

tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner

rm *.tar.xz

echo "GENTOO_MIRRORS=\"${MIRROR_URL}\"" >> /mnt/gentoo/etc/portage/make.conf

cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run

test -L /dev/shm && rm /dev/shm && mkdir /dev/shm
mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm
chmod 1777 /dev/shm /run/shm

chroot /mnt/gentoo ./chroot.sh
