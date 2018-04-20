#!/bin/bash

# =============================================
# ===    generate the environment file that systemd will use
# =============================================

# env var
export PEER_NAME=$(hostname)
export PRIVATE_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')

touch /etc/etcd.env
echo "PEER_NAME=$PEER_NAME" >> /etc/etcd.env
echo "PRIVATE_IP=$PRIVATE_IP" >> /etc/etcd.env


# =============================================
# ===   copy the systemd unit file
# =============================================

# hostnames
etcd0="master0"
etcd1="master1"
etcd2="master2"

# IP address
etcd0ip="10.0.0.4"
etcd1ip="10.0.0.5"
etcd2ip="10.0.0.6"

cat >/etc/systemd/system/etcd.service <<EOF
[Unit]
Description=etcd
Documentation=https://github.com/coreos/etcd
Conflicts=etcd.service
Conflicts=etcd2.service

[Service]
EnvironmentFile=/etc/etcd.env
Type=notify
Restart=always
RestartSec=5s
LimitNOFILE=40000
TimeoutStartSec=0


ExecStart=/usr/local/bin/etcd --name ${PEER_NAME} \
    --data-dir /var/lib/etcd \
    --listen-client-urls https://${PRIVATE_IP}:2379 \
    --advertise-client-urls https://${PRIVATE_IP}:2379 \
    --listen-peer-urls https://${PRIVATE_IP}:2380 \
    --initial-advertise-peer-urls https://${PRIVATE_IP}:2380 \
    --cert-file=/etc/kubernetes/pki/etcd/server.pem \
    --key-file=/etc/kubernetes/pki/etcd/server-key.pem \
    --client-cert-auth \
    --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.pem \
    --peer-cert-file=/etc/kubernetes/pki/etcd/peer.pem \
    --peer-key-file=/etc/kubernetes/pki/etcd/peer-key.pem \
    --peer-client-cert-auth \
    --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.pem \
    --initial-cluster $etcd0=https://$etcd0ip:2380,$etcd1=https://$etcd1ip:2380,$etcd2=https://$etcd2ip:2380 \
    --initial-cluster-token my-etcd-token \
    --initial-cluster-state new

[Install]
WantedBy=multi-user.target
EOF

# launch etcd
systemctl daemon-reload
systemctl start etcd

# check if launched successfully
systemctl status etcd
