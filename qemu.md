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
        -net nic \
        -net bridge,br=br0 \
        -device virtio-rng-pci \
        -m 2048M \
        -smp cores=3,threads=2,sockets=1 \
        -monitor stdio \
        -name "Gentoo VM" \
        $@
```

Run install

```bash
./start_Gentoo_VM.sh -boot d -cdrom minimal-amd64.iso
```

Start (after install)