```sh
kind: Pod
apiVersion: v1
metadata:
  name: myapl
  labels:
    name: deployment
spec:
  containers:
    - name: myapl
      image: amiyaranjansahoo/myapp:v1
      ports:
        - containerPort: 8080           
---
kind: Service
apiVersion: v1
metadata:
  name: javahomeservice
spec:
  ports:
    - port: 8080
      targetPort: 8080
  selector:
    name: deployment
  type: NodePort
```
