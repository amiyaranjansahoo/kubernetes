#### Attach the adminstrator access to the worker node policy
#### Install CSI Driver using helm
```sh
wget https://get.helm.sh/helm-v3.12.3-linux-amd64.tar.gz
tar -xzf helm-v3.12.3-linux-amd64.tar.gz
sudo mv ./linux-amd64/helm /usr/local/bin/
---
helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver
helm repo update
helm upgrade --install aws-ebs-csi-driver \
--namespace kube-system \
aws-ebs-csi-driver/aws-ebs-csi-driver
kubectl get pods -n kube-system # Verify the csi driver was installed
```

#### Creating a Storage
```sh
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata: 
  name: ebs-sc
provisioner: ebs.csi.aws.com
volumeBindingMode: WaitForFirstConsumer
```
#### Claming the Persistent Volume claim
```sh
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ebs-mysql-pv-claim
spec: 
  accessModes:
    - ReadWriteOnce
  storageClassName: ebs-sc
  resources: 
    requests:
      storage: 4Gi
```
#### Deploying the application using the PVC
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pvdeploy
spec:
  replicas: 1
  selector:      # tells the controller which pods to watch/belong to
    matchLabels:
     app: mypv
  template:
    metadata:
      labels:
        app: mypv
    spec:
      containers:
      - name: shell
        image: ubuntu
        command: ["bin/bash", "-c", "sleep 10000"]
        volumeMounts:
        - name: mypd
          mountPath: "/tmp/persistent"
      volumes:
        - name: mypd
          persistentVolumeClaim:
            claimName: ebs-mysql-pv-claim
```
