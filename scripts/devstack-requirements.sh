#!/bin/sh -eux

dnf -y install rsyslog joe yum-utils net-tools nfs-utils mlocate telnet sudo git dnf python-pip

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

cat >/etc/pip.conf <<EOF
[global]
wheel-dir = /var/wheelhouse
find-links = /var/wheelhouse
EOF

pip wheel --timeout 60 -r https://raw.githubusercontent.com/openstack/requirements/master/global-requirements.txt
pip wheel --timeout 60 -r https://raw.githubusercontent.com/openstack/requirements/master/upper-constraints.txt
pip wheel --timeout 60 -r https://raw.githubusercontent.com/openstack/requirements/master/test-requirements.txt
pip wheel --timeout 60 -r https://raw.githubusercontent.com/openstack/nova/master/requirements.txt
pip wheel --timeout 60 -r https://raw.githubusercontent.com/openstack/nova/master/test-requirements.txt

chown -R vagrant:vagrant /var/wheelhouse
