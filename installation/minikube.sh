### Launch ec2 ubuntu t2-medium(2 CPU 4 GB RAM )

# Download and Install kubectl
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl

#Apply execute permissions to the binary:
chmod +x ./kubectl

#Copy the binary to a directory in your path:
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

#Ensure kubectl is installed:
kubectl version --short --client



# Download and Install docker
# Login as ec2-user)
sudo yum install docker
docker version 
sudo service docker start
sudo systemctl enable docker
docker image ls 
# Add the ec2-user to the docker group so you can execute Docker commands without using sudo
cat /etc/group # docker group present and ec2-user does not present to the group
sudo usermod -G docker ec2-user 
cat /etc/group  # We must see ec2-user belongs to the docker group.
# Logout of the screen and login again
docker image ls



# Minikube Installation
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

minikube start

################## end ##################

# Launch minikube cri 

### Launch ec2 ubuntu t2-medium(2 CPU 4 GB RAM ) - ubuntu 20.04 LTS
## Login as root => sudo su
#!/bin/bash

# Install Docker
sudo apt update && apt -y install docker.io

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl &&   chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl

# Install minikube
curl -Lo minikube https://github.com/kubernetes/minikube/releases/download/v1.24.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

# Install conntrack
apt install conntrack

# Install CRI-Dockerd
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.2.0/cri-dockerd-v0.2.0-linux-amd64.tar.gz
tar -zxvf cri-dockerd-v0.2.0-linux-amd64.tar.gz
sudo mv ./cri-dockerd /usr/local/bin/ 
cri-dockerd --help
 
wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.service
wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.socket
sudo mv cri-docker.socket cri-docker.service /etc/systemd/system/
sudo sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service

systemctl daemon-reload
systemctl enable cri-docker.service
systemctl enable --now cri-docker.socket
systemctl status cri-docker.socket

# Install crictl
wget https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.24.0/crictl-v1.24.0-linux-amd64.tar.gz
sudo tar zxvf crictl-v1.24.0-linux-amd64.tar.gz -C /usr/local/bin
rm -f crictl-v1.24.0-linux-amd64.tar.gz

# Start minikube
minikube start --vm-driver=none

# Check minikube status
minikube status
