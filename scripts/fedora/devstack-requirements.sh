#!/bin/sh -eux

#dnf -y update
dnf -y install rsyslog joe yum-utils net-tools nfs-utils mlocate telnet sudo git dnf python-pip

pip install -U pip
pip install -U setuptools

git clone https://git.openstack.org/openstack-dev/devstack
devstack/tools/install_prereqs.sh
rm -rf devstack

git clone https://git.openstack.org/openstack/requirements
mkdir -p tmp build
dnf -y install libvirt-devel sqlite-devel openldap-devel
pip install --cache-dir tmp -b build --timeout 60 -U -r requirements/global-requirements.txt
pip wheel --cache-dir tmp -b build --timeout 60 -r requirements/global-requirements.txt
rm -rf requirements build tmp
mv wheelhouse /usr/local
