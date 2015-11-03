#!/bin/sh -eux

dnf -y install rsyslog joe yum-utils net-tools nfs-utils mlocate telnet sudo git dnf python-pip

pip install -U pip
pip install -U setuptools
pip install -U wheel

# /tmp is not in ramdisk, so use /run to avoid image fragmentation
mkdir -p /run/tmp
cd /run/tmp

git clone --depth=1 https://git.openstack.org/openstack-dev/devstack
devstack/tools/install_prereqs.sh
rm -rf devstack

dnf -y install libvirt-devel sqlite-devel openldap-devel libjpeg-devel mysql rabbitmq-server
pip install -U cffi

git clone --depth=1 https://git.openstack.org/openstack/requirements

cat >/etc/pip.conf <<EOF
[global]
wheel-dir = /var/wheelhouse
find-links = /var/wheelhouse
EOF

grep -v '^$\|#' requirements/global-requirements.txt | while read req ; do
    pip wheel --no-cache-dir -b /var/tmp --timeout 60 $req
done
grep -v '^$\|#' requirements/upper-constraints.txt.txt | while read req ; do
    pip wheel --no-cache-dir -b /var/tmp --timeout 60 $req
done
rm -rf requirements
chown -R vagrant:vagrant /var/wheelhouse
