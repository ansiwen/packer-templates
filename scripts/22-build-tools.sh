#!/bin/bash -eux
# Installing build tools here because Fedora 22 will not do so during kickstart
#dnf -y update
if [ "$PACKER_BUILDER_TYPE" == "qemu" ]; then
    exit 0 ;
fi

dnf -y install kernel-headers kernel-devel gcc make perl dkms
