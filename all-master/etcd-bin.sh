#!/bin/bash

# =============================================
# ===   install etcd binaries
# =============================================

mkdir -p /etc/kubernetes/pki/etcd
cd /etc/kubernetes/pki/etcd

#export ETCD_VERSION=v3.1.10
export ETCD_VERSION=v3.2.18
curl -sSL https://github.com/coreos/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz | tar -xzv --strip-components=1 -C /usr/local/bin/

rm -rf etcd-$ETCD_VERSION-linux-amd64*

