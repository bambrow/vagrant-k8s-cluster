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

If everything works well, you can run the following to check the nodes and pods status:
```bash
$ kubectl get nodes -o wide
NAME      STATUS   ROLES                  AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION       CONTAINER-RUNTIME
master    Ready    control-plane,master   48m     v1.21.1   10.0.0.80     <none>        Ubuntu 18.04.5 LTS   4.15.0-147-generic   docker://20.10.12
worker1   Ready    <none>                 7m28s   v1.21.1   10.0.0.81     <none>        Ubuntu 18.04.5 LTS   4.15.0-147-generic   docker://20.10.12
worker2   Ready    <none>                 21m     v1.21.1   10.0.0.82     <none>        Ubuntu 18.04.5 LTS   4.15.0-147-generic   docker://20.10.12

$ kubectl -n kube-system get all -o wide
NAME                                           READY   STATUS    RESTARTS   AGE     IP              NODE      NOMINATED NODE   READINESS GATES
pod/calico-kube-controllers-6b9fbfff44-4jpvc   1/1     Running   0          50m     10.244.219.66   master    <none>           <none>
pod/calico-node-p4qb2                          1/1     Running   0          23m     10.0.0.82       worker2   <none>           <none>
pod/calico-node-tcsxt                          1/1     Running   0          9m47s   10.0.0.81       worker1   <none>           <none>
pod/calico-node-wl74r                          1/1     Running   0          50m     10.0.0.80       master    <none>           <none>
pod/coredns-558bd4d5db-78sjf                   1/1     Running   0          50m     10.244.219.67   master    <none>           <none>
pod/coredns-558bd4d5db-jft6t                   1/1     Running   0          50m     10.244.219.65   master    <none>           <none>
pod/etcd-master                                1/1     Running   0          50m     10.0.0.80       master    <none>           <none>
pod/kube-apiserver-master                      1/1     Running   0          50m     10.0.0.80       master    <none>           <none>
pod/kube-controller-manager-master             1/1     Running   8          50m     10.0.0.80       master    <none>           <none>
pod/kube-proxy-h4vnv                           1/1     Running   0          9m47s   10.0.0.81       worker1   <none>           <none>
pod/kube-proxy-jgd5h                           1/1     Running   1          23m     10.0.0.82       worker2   <none>           <none>
pod/kube-proxy-pznsv                           1/1     Running   0          50m     10.0.0.80       master    <none>           <none>
pod/kube-scheduler-master                      1/1     Running   3          50m     10.0.0.80       master    <none>           <none>

NAME               TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE   SELECTOR
service/kube-dns   ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   50m   k8s-app=kube-dns

NAME                         DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS    IMAGES
               SELECTOR
daemonset.apps/calico-node   3         3         3       3            3           kubernetes.io/os=linux   50m   calico-node   docker.io/calico/node:v3.21.2   k8s-app=calico-node
daemonset.apps/kube-proxy    3         3         3       3            3           kubernetes.io/os=linux   50m   kube-proxy    k8s.gcr.io/kube-proxy:v1.21.1   k8s-app=kube-proxy

NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS                IMAGES
       SELECTOR
deployment.apps/calico-kube-controllers   1/1     1            1           50m   calico-kube-controllers   docker.io/calico/kube-controllers:v3.21.2   k8s-app=calico-kube-controllers
deployment.apps/coredns                   2/2     2            2           50m   coredns                   k8s.gcr.io/coredns/coredns:v1.8.0           k8s-app=kube-dns

NAME                                                 DESIRED   CURRENT   READY   AGE   CONTAINERS                IMAGES
             SELECTOR
replicaset.apps/calico-kube-controllers-6b9fbfff44   1         1         1       50m   calico-kube-controllers   docker.io/calico/kube-controllers:v3.21.2   k8s-app=calico-kube-controllers,pod-template-hash=6b9fbfff44
replicaset.apps/coredns-558bd4d5db                   2         2         2       50m   coredns                   k8s.gcr.io/coredns/coredns:v1.8.0           k8s-app=kube-dns,pod-template-hash=558bd4d5db
```

### Halt & Restart
```bash
vagrant halt
vagrant up
```

To halt or restart a specific node, run `vagrant halt|up master|worker1|worker2`.

### Destroy
```bash
vagrant destroy -f
```

To destroy a specific node, run `vagrant destroy -f master|worker1|worker2`.
