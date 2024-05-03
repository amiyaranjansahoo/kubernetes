```sh
kind: Deployment
apiVersion: apps/v1
metadata:
   name: dev-nginx
spec:
   replicas: 2
   selector:      
    matchLabels:
     name: deployment
   template:
     metadata:
       name: testpod1
       labels:
         name: deployment
     spec:
      containers:
        - name: apache
          image: nginx
          ports:
          - containerPort: 80
---
kind: Service
apiVersion: v1
metadata:
  name: dev-svc
spec:
  ports:
    - port: 80
      targetPort: 80
  selector:
    name: deployment
  type: ClusterIP
```
