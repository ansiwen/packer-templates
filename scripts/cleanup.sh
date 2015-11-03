#!/bin/bash -eux
#yum -y remove gcc cpp kernel-devel kernel-headers perl
dnf -y clean all
rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?
bash -O dotglob -c "rm -rf /tmp/*"
# Because memory is scarce resource in most cloud/virt environments,
# and because this impedes forensics, we are differing from the Fedora
# default of having /tmp on tmpfs.
systemctl mask tmp.mount
