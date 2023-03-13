#!/bin/bash

exec qemu-system-x86_64 -enable-kvm \
        -cpu host \
        -drive file=Gentoo-VM.img,if=virtio \
        -net nic \
        -net bridge,br=br0 \
        -device virtio-rng-pci \
        -m 6144M \
        -smp cores=6,threads=1,sockets=1 \
        -display gtk \
        -vga qxl \
        -monitor stdio \
        -name "Gentoo VM" \
        $@