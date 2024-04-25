#### Pre-requisite:
```sh
1. Before installing helm, you must first have a functional k8s cluster and kubectl installed
2. Helm can be installed on Linux, Windows or Mac OS systems
3. We can install hel using different method like binary(helm-v3*.tar.gz),  snap, brew, choco, scoop  (Windows),
   dnf/yum(fedora)
```
#### Installation using binary method
```sh
wget https://get.helm.sh/helm-v3.12.3-linux-amd64.tar.gz
tar -xzf helm-v3.12.3-linux-amd64.tar.gz
sudo mv ./linux-amd64/helm /usr/local/bin/
```
#### How to check teh helm version
```sh
helm version
```
