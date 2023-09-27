### container to container communication
```sh
kind: Pod
apiVersion: v1
metadata:
  name: testpod
spec:
  containers:
    - name: myubuntu
      image: ubuntu
      command: ["/bin/bash", "-c", "while true; do echo welcome to k8s; sleep 5 ; done"]
    - name: myapache
      image: httpd
      ports:
       - containerPort: 80
```

### pod to pod communication
```sh
kind: Pod
apiVersion: v1
metadata:
  name: testpod1
spec:
  containers:
    - name: mynginx
      image: nginx
      ports:
       - containerPort: 80
---
kind: Pod
apiVersion: v1
metadata:
  name: testpod2
spec:
  containers:
    - name: myapache
      image: httpd
      ports:
       - containerPort: 80
```
