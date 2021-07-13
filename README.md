# Vagrant Kubernetes Cluster

This repository shows how to use Vagrant to build a Kubernetes cluster. Please install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/docs/installation) before starting.

For the scripts specially tuned for networks in China, please refer to [this link](https://gitee.com/bambrow/vagrant-k8s-cluster-cn).

## Versions

VirtualBox and Vagrant versions:
```
VirtualBox: 6.1.20 r143896 (Qt5.6.2)
Vagrant: 2.2.16
```

Kubernetes container versions:
```
kube-apiserver: v1.21.1
kube-proxy: v1.21.1
kube-controller-manager: v1.21.1
kube-scheduler: v1.21.1
pause: 3.4.1
coredns: v1.8.0
etcd: 3.4.13-0  
```

## Quick Start

### Initiate
```bash
git clone https://github.com/bambrow/vagrant-k8s-cluster.git
cd vagrant-k8s-cluster
vagrant up
```

### Connect
```bash
vagrant ssh master
vagrant ssh worker1
vagrant ssh worker2
```

### Halt & Restart
```bash
vagrant halt
vagrant up
```

### Destroy
```bash
vagrant destroy -f
```
