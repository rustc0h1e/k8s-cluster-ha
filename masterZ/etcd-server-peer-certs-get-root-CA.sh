#!/bin/bash

# =============================================
# ===  copy certs
# =============================================

mkdir -p /etc/kubernetes/pki/etcd
cd /etc/kubernetes/pki/etcd

etcd0="10.0.0.4"
scp root@$etcd0:/etc/kubernetes/pki/etcd/ca.pem .
scp root@$etcd0:/etc/kubernetes/pki/etcd/ca-key.pem .
scp root@$etcd0:/etc/kubernetes/pki/etcd/client.pem .
scp root@$etcd0:/etc/kubernetes/pki/etcd/client-key.pem .
scp root@$etcd0:/etc/kubernetes/pki/etcd/ca-config.json .

