#!/bin/bash

# =============================================
# ===  copy certs
# =============================================

mkdir -p /etc/kubernetes/pki/etcd
cd /etc/kubernetes/pki/etcd

export PEER_NAME=$(hostname)
export PRIVATE_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')

cfssl print-defaults csr > config.json
sed -i '0,/CN/{s/example\.net/'"$PEER_NAME"'/}' config.json
sed -i 's/www\.example\.net/'"$PRIVATE_IP"'/' config.json
sed -i 's/example\.net/'"$PEER_NAME"'/' config.json

cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=server config.json | cfssljson -bare server
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=peer config.json | cfssljson -bare peer
