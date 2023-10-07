### Creating pod with environment variable
```sh
apiVersion: v1
kind: Pod
metadata:
  name: testpod
  labels:
    envt: dev
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
      env:
        - name: database
          value: mongodb
        - name: database_uri
          value: mongodb://localhost:27017
```
### Creating the configmap
```sh
apiVersion: v1
kind: Pod
metadata:
  name: testpod
  labels:
    envt: dev
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
      envFrom:
        - configMapRef:
            name: dbdetails

kubectl create configmap dbdetails --from-literal=database=mongodb
kubectl create configmap dbdetails --from-literal=database=mongodb --from-literal=database_uri=mongodb://localhost:27017
kubectl create configmap dbdetails --from-file=input.txt
kubectl exec testpod -it -- /bin/bash

kind: ConfigMap 
apiVersion: v1 
metadata:
  name: dbdetails 
data:
  # Configuration values can be set as key-value properties
  database: mongodb
  database_uri: mongodb://localhost:27017
```
