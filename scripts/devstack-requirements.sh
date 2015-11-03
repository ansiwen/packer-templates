#!/bin/sh -eux

dnf -y install rsyslog joe yum-utils net-tools nfs-utils mlocate telnet sudo git dnf python-pip

cd /tmp

git clone --depth=1 https://git.openstack.org/openstack-dev/devstack
devstack/tools/install_prereqs.sh
rm -rf devstack

dnf -y install libvirt-devel sqlite-devel openldap-devel libjpeg-devel mysql rabbitmq-server

git clone --depth=1 https://git.openstack.org/openstack/requirements

pip install -U --no-cache-dir --timeout 60 pip
pip install -U --no-cache-dir --timeout 60 setuptools
pip install -U --no-cache-dir --timeout 60 wheel
pip install -U --no-cache-dir --timeout 60 cffi

cat >/etc/pip.conf <<EOF
[global]
wheel-dir = /var/wheelhouse
find-links = /var/wheelhouse
EOF

grep -v '^$\|#' requirements/global-requirements.txt | while read req ; do
    pip wheel --no-cache-dir --timeout 60 $req
done
grep -v '^$\|#' requirements/upper-constraints.txt.txt | while read req ; do
    pip wheel --no-cache-dir --timeout 60 $req
done
rm -rf requirements
chown -R vagrant:vagrant /var/wheelhouse
