## Login to Killerkoda account (https://killercoda.com/) or any k8s custer
#### How many PODs exist on the system?
```sh
4
3
0
2
1
```
#### How many ReplicaSets exist on the system?
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

#### How many PODs are DESIRED in the new-replica-set?
```sh
4
3
0
2
1
```
