Create bridge interface

```console
$ nmcli con add ifname br0 type bridge con-name br0
$ nmcli con add type bridge-slave ifname enp6s0 master br0
$ nmcli con modify br0 bridge.stp no
$ nmcli con modify br0 bridge.forward-delay 0
$ nmcli con modify br0 bridge.hello-time 1
```

Enable bridge in `QEMU`

```console
# echo 'allow br0' >> /etc/qemu/bridge.conf
```

Create disk image

```console
$ qemu-img create -f qcow2 Gentoo-VM.img 20G
```

Start script (during install)

```bash
#!/bin/bash
exec qemu-system-x86_64 -enable-kvm \
        -cpu host \
        -drive file=Gentoo-VM.img,if=virtio \
        -net nic \
        -net bridge,br=br0 \
        -device virtio-rng-pci \
        -m 2048M \
        -smp cores=6,threads=1,sockets=1 \
        -display gtk \
        -vga qxl \
        -monitor stdio \
        -name "Gentoo VM" \
        $@
```

Run install

```bash
$ ./start_Gentoo_VM.sh -boot d -cdrom minimal-amd64.iso
```

Start (after install)