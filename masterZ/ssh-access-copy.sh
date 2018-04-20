#!/bin/bash

# =============================================
# ===  Create SSH access
# =============================================

# env var
export PEER_NAME=$(hostname)
export PRIVATE_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')

# verify : eth1 = ipv4 private ip
echo $PRIVATE_IP

# generate some SSH keys | all empty
ssh-keygen -t rsa -b 4096 -C ""

# copy : public key file for master1 / master2
cat ~/.ssh/id_rsa.pub

