#!/bin/bash

# =============================================
# ===  copy certs
# =============================================

cd /etc/kubernetes/pki/

etcd0="10.0.0.4"

scp root@$etcd0:/etc/kubernetes/pki/* /etc/kubernetes/pki
rm apiserver.*

