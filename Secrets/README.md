### Creating the Secrets
```sh
apiVersion: v1
kind: Pod
metadata:
  name: myapp
  labels:
    name: myapp
spec:
  containers:
    - name: myweb
      image: amiyaranjansahoo/myapp:v1
      ports:
        - containerPort: 8080
      envFrom:
        - secretRef:
            name: app-secret

kubectl create secret generic  <secret-name> --from-literal=key1=value1
kubectl create secret generic  app-secret --from-literal=DB_Host=mysql
kubectl create secret generic  app-secret --from-literal=DB_Host=mysql --from-literal=DB_User=root	--from-literal=DB_Password=paswrd
kubectl create secret generic <secret-name> --from-file=<path-to-file>
kubectl create secret generic app-secret --from-file=app_secret.properties
kubectl exec testpod -it -- /bin/bash

apiVersion: v1
kind: Secret
metadata:
  name: app-secret
data:
  DB_Host: bXlzcWw=
  DB_User: cm9vdA==
  DB_Password: cGFzd3Jk
```
