## Configure Kubernetes Cluster With Kubeadm
### Set up the hosname ( if on-premise)
```sh
hostnamectl set-hostname master
Edit the /etc/hosts
192.168.0.107 master
```
### Take 3 Linux servers (I'Ve taken AWS Linux 3 servers)
```sh
  One node for master and other two workers
```
### Install docker on all nodes ( Repeate these steps on all three nodes )
```sh
sudo yum install docker -y
sudo service docker start
sudo chkconfig docker on
```
### Adding current user to docker group (Optional)
```sh
sudo usermod -aG docker $USER
sudo service docker start 
```
### Disable swap momory
```sh
sudo swapoff -a
```
### Command to update fstab so that swap remains disabled after a reboot
```sh
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```
### Set SELinux in permissive mode (effectively disabling it)
```sh
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
```
### Install kubeadmn, kubectl, kubectl on all three nodes
```sh
cat >> /etc/yum.repos.d/kubernetes.repo <<EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=0
EOF
sudo yum install -y kubelet kubeadm kubectl
```
### Disable the firewall
```sh
systemctl stop firewalld
```
### Install and Start the containerd
```sh
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y containerd.io
#Step 2. Configure containerd:

sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
#Step 3. Restart containerd:

systemctl restart containerd

```
### Initialize kubernets cluster on Master node(Run this only on master)
```sh
kubeadm init --pod-network-cidr=10.244.0.0/16
```
### Do following setup to start using kubernetes cluster(Run this only on master) and Add pod network
```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

Reference: https://kubernetes.io/docs/concepts/cluster-administration/addons/
```
### Take note of kubeadm command and run on all workers
```sh
Run this command(replace with your command) on every node to join the cluster
sudo kubeadm join 172.31.44.226:6443 --token f6o4a3.jdagdd4e2h8xhzy1 \
    --discovery-token-ca-cert-hash sha256:d0528baca6a2cf15bfece995d7df6f5d018b233b54251716ce2fd984148ba6d6
```


