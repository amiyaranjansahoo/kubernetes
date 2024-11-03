## Login to Killerkoda account (https://killercoda.com/) or any k8s cluster
#### Create a pod name as below.
#### What is the name of the pod ?	
#### What is the name of the container ?
#### Calculate no of pods and containers ?

```sh
kind: Pod
apiVersion: v1
metadata:
  name: myfirstpod
spec:
  containers:
    - name: myapache
      image: httpd
      ports:
        - containerPort: 80
```
#### Create a pod name as javahome as below
```sh
Installl 2 containers 
First container with name as mynginx with nginx image and 
Second container with name as mytomcat with tomcat image
```
#### Login to killerkoda and Schedule the pod in controlplane
```sh
kind: Pod
apiVersion: v1
metadata:
  name: mypod2
spec:
  containers:
    - name: mytomcat
      image: tomcat
      ports:
        - containerPort: 8080
  nodeName: controlplane
```

#### Login to killerkoda and Schedule the pod.
#### Verify the reason why its not Running?
#### Now schedule the pod in node01?

```sh
kind: Pod
apiVersion: v1
metadata:
  name: nodelabels
  labels:
    env: development
spec:
    containers:
       - name: myubuntu
         image: ubuntu
         command: ["/bin/bash", "-c", "sleep 50000"]
    nodeSelector:                                         
       hardware: t2-medium
```
#### Now Delete the pod and rescheduled the pod in controlplane
