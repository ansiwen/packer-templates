#!/bin/sh -eux

dnf -y install rsyslog yum-utils net-tools nfs-utils mlocate telnet sudo \
  git dnf dnf-plugins-core python-pip libvirt-devel sqlite-devel \
  openldap-devel libjpeg-devel mariadb-server rabbitmq-server vim joe mod_wsgi \
  scsi-target-utils kvm qemu-kvm libvirt libvirt-devel

git clone --depth=1 http://git.openstack.org/openstack-dev/devstack
devstack/tools/install_prereqs.sh
rm -rf devstack
