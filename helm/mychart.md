#### Values.yaml
```sh
replicaCount: 1
image:
  repository: nginx
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
        - name: nginx
          image: {{ .Values.image.repository }}
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
