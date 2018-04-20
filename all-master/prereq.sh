#!/bin/bash


# =============================================
# ===  create working directory
# =============================================

#mkdir skript
#cd ./skript

# =============================================
# ===  verify : MAC address - product_uuid
# =============================================

ip link
sudo cat /sys/class/dmi/id/product_uuid

# =============================================
# ===  install docker
# =============================================

apt-get update
apt-get install -y docker.io

# =============================================
# ===  Installing kubeadm, kubelet and kubectl
# =============================================

apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl

# =============================================
# ===  Configure cgroup driver used by kubelet on Master Node
# =============================================

docker info | grep -i cgroup
cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

sed -i "s/cgroup-driver=systemd/cgroup-driver=cgroupfs/g" /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

systemctl daemon-reload
systemctl restart kubelet

