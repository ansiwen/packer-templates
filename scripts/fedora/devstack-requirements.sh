#!/bin/sh -eux

#dnf -y update
dnf -y install rsyslog joe yum-utils net-tools nfs-utils mlocate telnet sudo git dnf python-pip

pip install -U pip
pip install -U setuptools

git clone https://git.openstack.org/openstack-dev/devstack
devstack/tools/install_prereqs.sh

rm -rf devstack

git clone https://git.openstack.org/openstack/requirements
mkdir tmp
pip install --cache-dir tmp -b tmp -U -r requirements/global-requirements.txt

rm -rf requirements
rm -rf tmp
