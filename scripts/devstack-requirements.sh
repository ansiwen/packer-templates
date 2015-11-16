#!/bin/sh -eux

dnf -y install rsyslog joe yum-utils net-tools nfs-utils mlocate telnet sudo git dnf dnf-plugins-core python-pip

mkdir -p /run/tmp
cd /run/tmp

git clone --depth=1 https://git.openstack.org/openstack-dev/devstack
devstack/tools/install_prereqs.sh
rm -rf devstack

dnf -y install libvirt-devel sqlite-devel openldap-devel libjpeg-devel mysql rabbitmq-server

pip install -U --timeout 60 pip
pip install -U --timeout 60 setuptools
pip install -U --timeout 60 wheel
pip install -U --timeout 60 cffi
