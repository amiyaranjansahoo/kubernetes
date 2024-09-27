## Login to Killerkoda account (https://killercoda.com/) or any k8s custer
#### How many PODs exist on the system?
```sh
4
3
0
2
1
```
#### How many ReplicaSets exist on the k8s cluster?
```sh
4
3
0
2
1
```
#### Run the below command and calculate no of pods and no of ReplicaSets
```sh
cat > rs.yml << EOF
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: replicaset-1
spec:
  replicas: 2
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      labels:
        tier: frontend
    spec:
      containers:
      - name: nginx
        image: nginx
EOF
```

#### How many PODs are DESIRED in the replicaset-1?
```sh
4
3
0
2
1
```
#### Run the below command and calculate no of pods
```sh
kubectl delete -f rs.yml
4
3
0
2
1
```
#### Execute the below command, it will create a file: rs.yml
#### Then execute the command: kubectl apply -f rs.yml
```sh
cat > rs.yml << EOF
kind: ReplicaSet               
apiVersion: apps/v1
metadata:
  name: myreplica
spec:
  replicas: 3            
  selector:
    matchLabels:  
      envt: test                             
  template:                
    metadata:
      name: rcpod
      labels:            
        envt: test
    spec:
     containers:
       - name: mynginx
         image: nginx
         ports:
           - containerPort: 80
EOF

How many pods are running?

A) 5
B) 2
C) 3
D) 4
```

