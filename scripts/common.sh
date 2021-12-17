#! /bin/bash

KUBERNETES_VERSION="1.21.1-00"

# disable swap 
sudo swapoff -a
sudo sed -ri 's/.*swap.*/#&/' /etc/fstab 

echo "Swap diasbled..."

# disable firewall
sudo ufw disable

# install dependencies
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl wget software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update -y
sudo apt-get install -y docker-ce

echo "Dependencies installed..."

# configure docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts":["native.cgroupdriver=systemd"]
}
EOF

# start docker
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker

echo "Docker installed and configured..."

# install kubelet, kubectl, kubeadm
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update -y
sudo apt-get install -y kubelet=$KUBERNETES_VERSION kubectl=$KUBERNETES_VERSION kubeadm=$KUBERNETES_VERSION

sudo systemctl start kubelet  
sudo systemctl enable kubelet   

echo "Installation done..."
