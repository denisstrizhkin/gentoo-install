# Gentoo livecd install commands

## Enable ssh connection

Set `root` password

```console
# passwd root
```

Change `sshd` settings `PasswordAuthentication yes`

```console
# sed -i '/^PasswordAuthentication/s/ no/ yes/' /etc/ssh/sshd_config
```

Start `sshd`

```console
# /etc/init.d/sshd start
```

Check ip (then `ssh` into it)

```console
# ip a
```

## Partitioning the disk

List device partition info

```console
# sfdisk --dump /dev/vda
```

or

```console
# sfdisk -l /dev/vda
```

Create empty GPT partition table

```console
# echo 'label: gpt' | sfdisk /dev/vda
```

Add partitions. Here two partitions added: first - 4G `swap` partition,
second - left over space `linux` partition.

```console
# echo -e 'size=4G, type=S\n size=+, type=L\n' | sfdisk /dev/vda
```

## Activating the swap partition

Initializing swap partition

```console
# mkswap /dev/vda1
```

Activating swap partition

```console
# swapon /dev/vda1
```

## Creating btrfs filesystem

```console
# mkfs.btrfs /dev/vda2
```

## Mounting the root partition

Creating install directory
```console
# mkdir -p /mnt/gentoo
```

Mounting the root partition
```console
# mount /dev/vda2 /mnt/gentoo
```

## Sync date

```console
# ntpd -q -g
```

## Downloading the stage tarball

Enter root mount point

```console
# cd /mnt/gentoo
```

Download the stage tarball

```console
# wget <URL>
```

Unpack the stage tarball

```console
# tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner
```

# Select mirrors

Set source code mirrors
```console
# echo 'GENTOO_MIRRORS="https://mirror.yandex.ru/gentoo-distfiles/"' >> /mnt/gentoo/etc/portage/make.conf
```

Create `repos.conf` directory
```console
# mkdir -p /mnt/gentoo/etc/portage/repos.conf
```

Copy the Gentoo repository config file
```console
# cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
```

# Copy DNS info

```console
# cp -L /etc/resolv.conf /mnt/gentoo/etc/
```

# Mount the necessary filesystems

```console
# mount --types proc /proc /mnt/gentoo/proc &&
    mount --rbind /sys /mnt/gentoo/sys &&
    mount --make-rslave /mnt/gentoo/sys &&
    mount --rbind /dev /mnt/gentoo/dev &&
    mount --make-rslave /mnt/gentoo/dev &&
    mount --bind /run /mnt/gentoo/run &&
    mount --make-slave /mnt/gentoo/run &&
```

# Chroot

```console
# chroot /mnt/gentoo /bin/bash
# source /etc/profile && 
    export PS1="(chroot) ${PS1}"
```

