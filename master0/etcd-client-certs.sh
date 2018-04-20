#!/bin/bash

# =============================================
# ===  Create etcd client certs
# =============================================

mkdir -p /etc/kubernetes/pki/etcd
cd /etc/kubernetes/pki/etcd

cat >client.json <<EOF
{
    "CN": "client",
    "key": {
        "algo": "ecdsa",
        "size": 256
    }
}
EOF

# create : client.pem - client-key.pem 
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=client client.json | cfssljson -bare client

