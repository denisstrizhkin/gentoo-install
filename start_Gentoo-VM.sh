#!/bin/bash

exec qemu-system-x86_64 -enable-kvm \
        -cpu host \
        -drive file=Gentoo-VM.img,if=virtio \
        -netdev bridge,id=net0,br=br0 \
        -device virtio-net,netdev=net0 \
        -device virtio-rng-pci \
        -m 2048M \
        -smp 6 \
        -monitor stdio \
        -name "Gentoo VM" \
        $@