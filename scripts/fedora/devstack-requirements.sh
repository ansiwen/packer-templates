#!/bin/sh -eux

#dnf -y update
dnf -y install rsyslog joe yum-utils net-tools nfs-utils mlocate telnet sudo git dnf python-pip

pip install -U pip
pip install -U setuptools

git clone https://git.openstack.org/openstack-dev/devstack.git

devstack/tools/install_prereqs.sh

rm -r devstack
