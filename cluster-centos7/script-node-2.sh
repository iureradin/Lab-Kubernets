#!/bin/bash

#loga como root
sudo su

#configuração modulo kernel
echo "br_netfilter
ip_vs
ip_vs_rr
ip_vs_sh
ip_vs_wrr
nf_conntrack_ipv4" > /etc/modules-load.d/k8s.conf

#atualiza o sistema
yum upgrade -y

#baixa e instala docker
curl -fsSL https://get.docker.com | bash

mkdir /etc/docker

cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF

mkdir -p /etc/systemd/system/docker.service.d
systemctl daemon-reload
systemctl restart docker

#adicionar repositorio kubernets
echo "[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg" > /etc/yum.repos.d/kubernetes.repo

setenforce 0
systemctl stop firewalld
systemctl disable firewalld
yum install -y kubelet kubeadm kubectl
systemctl enable --now docker
systemctl enable --now kubelet

echo "net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1" > /etc/sysctl.d/k8s.conf

swapoff -a

kubeadm config images pull