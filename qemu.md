Create disk image

```bash
$ qemu-img create -f qcow2 Gentoo-VM.img 20G
```

Start (during install)

```bash
#!/bin/bash
exec qemu-system-x86_64 -enable-kvm \
        -cpu host \
        -drive file=Gentoo-VM.img,if=virtio \
        -netdev user,id=vmnic,hostname=Gentoo-VM \
        -device virtio-net,netdev=vmnic \
        -device virtio-rng-pci \
        -m 2048M \
        -smp 6 \
        -monitor stdio \
        -name "Gentoo VM" \
        $@
```

Run install

```bash
./start_Gentoo_VM.sh -boot d -cdrom minimal-amd64iso
```

Start (after install)