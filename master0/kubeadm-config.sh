#!/bin/bash

# =============================================
# ===  write a configuration file
# =============================================

master0="10.0.0.4"
master1="10.0.0.5"
master2="10.0.0.6"
lb="52.151.43.204"

export serverip=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')

cat >config.yaml <<EOF
apiVersion: kubeadm.k8s.io/v1alpha1
kind: MasterConfiguration
api:
  advertiseAddress: $serverip
etcd:
  endpoints:
  - https://$master0:2379
  - https://$master1:2379
  - https://$master2:2379
  caFile: /etc/kubernetes/pki/etcd/ca.pem
  certFile: /etc/kubernetes/pki/etcd/client.pem
  keyFile: /etc/kubernetes/pki/etcd/client-key.pem
networking:
  podSubnet: 
apiServerCertSANs:
- $lb
apiServerExtraArgs:
  apiserver-count: "3"
EOF

