### Install the Deployment and Services
```sh
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app1-deployment
  labels:
    app: app1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: app1
  template:
    metadata:
      labels:
        app: app1
    spec:
      containers:
        - name: app1
          image: amiyaranjansahoo/ingressdemo:v1
          ports:
            - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: app1
  labels:
    app: app1
spec:
  type: NodePort # Not working with ClusterIP
  selector:
    app: app1
  ports:
    - port: 8080
      targetPort: 8080
##==================================
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app2-deployment
  labels:
    app: app2
spec:
  replicas: 1
  selector:
    matchLabels:
      app: app2
  template:
    metadata:
      labels:
        app: app2
    spec:
      containers:
        - name: app2
          image: amiyaranjansahoo/ingressdemo:v2
          ports:
            - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: app2
  labels:
    app: app2
spec:
  type: NodePort # Not working with ClusterIP
  selector:
    app: app2
  ports:
    - port: 8080
      targetPort: 8080
```
#### How to access: 
```sh
http://<lb dns>/app1/
http://<lb dns>/app2/
```
