#!/bin/bash

emerge --sync

emerge --ask --verbose --update --deep --newuse @world

emerge --ask --update --deep --changed-use sys-devel/clang

emerge --ask app-portage/cpuid2cpuflags

echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags

emerge --ask app-portage/eix

eix-sync

emerge --ask app-editors/neovim
