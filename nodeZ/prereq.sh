#!/bin/bash


# =============================================
# ===  install prereq
# =============================================

apt-get update
apt-get install -y docker.io kubeadm kubectl kubelet kubernetes-cni

