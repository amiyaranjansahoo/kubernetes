###
```sh
Question 1:
What is the purpose of a ReplicaSet in Kubernetes?

A) To scale pods horizontally by adding or removing replicas based on a defined specification.
B) To provide high availability by distributing pods across multiple nodes in a cluster.
C) To manage rolling updates by gradually replacing existing pods with new ones.
D) To ensure resource isolation by segregating pods into separate namespaces.

Question 2:
Which Kubernetes resource is responsible for ensuring a specified number of identical pod replicas are running concurrently?

A) Deployment
B) ReplicaSet
C) StatefulSet
D) PodDisruptionBudget

Question 3:
What happens if the number of replicas specified in a ReplicaSet's configuration exceeds the actual number of running pods?
A) Kubernetes automatically scales down the number of replicas to match the configured value.
B) Kubernetes automatically scales up the number of replicas to match the configured value.
C) Kubernetes creates additional pods to match the configured number of replicas.
D) Kubernetes deletes the ReplicaSet and its associated pods.

Question 4:
Which command is used to create a ReplicaSet from a YAML file in Kubernetes?
A) kubectl create pod
B) kubectl apply -f
C) kubectl create replicaset
D) kubectl run

Question 5:
What happens if a pod managed by a ReplicaSet is manually deleted?
A) Kubernetes automatically recreates the deleted pod.
B) The ReplicaSet scales down to match the configured number of replicas.
C) The ReplicaSet continues to operate with fewer replicas until manually adjusted.
D) The entire ReplicaSet is deleted along with its associated pods.
```


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

