#!/bin/sh -eux

#dnf -y update
dnf -y install rsyslog joe yum-utils net-tools nfs-utils mlocate telnet sudo git dnf python-pip

pip install -U pip
pip install -U setuptools
pip install -U wheel

git clone --depth=1 https://git.openstack.org/openstack-dev/devstack
devstack/tools/install_prereqs.sh
rm -rf devstack

git clone --depth=1 https://git.openstack.org/openstack/requirements
dnf -y install libvirt-devel sqlite-devel openldap-devel
grep -v '^$\|#' requirements/global-requirements.txt | while read req ; do
    pip wheel --no-cache-dir --timeout 60 "$req"
    pip install --no-index --find-links wheelhouse --no-cache-dir -U "$req"
done
rm -rf requirements
mv wheelhouse /usr/local
