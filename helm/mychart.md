#### Values.yaml
```sh
replicaCount: 2
image: httpd
```
#### deployment.yaml
```sh
kind: Deployment
apiVersion: apps/v1
metadata:
   name: {{ .Release.Name }}-nginx
spec:
   replicas: {{ .Values.replicaCount }}
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
          image: {{ .Values.image }}
          ports:
          - containerPort: 80
```
#### service.yaml
```sh
kind: Service
apiVersion: v1
metadata:
  name: {{ .Release.Name }}-svc
spec:
  ports:
    - port: 80
      targetPort: 80
  selector:
    name: deployment
  type: ClusterIP
```
