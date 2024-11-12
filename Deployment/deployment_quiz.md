## Login to Killerkoda account (https://killercoda.com/) or any k8s custer
#### How many PODs exist on the system?
```sh
4
3
0
2
1
```

How many ReplicaSets exist on the system?
```sh
4
3
0
2
1
```

How many Deployments exist on the system?
```sh
4
3
0
2
1
```


#### Run the below command 
```sh
cat > mydeployment.yml << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mydeployments
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: javahome
        image: javahomecloud:1.22
        ports:
        - containerPort: 80
EOF
```
#### Run the below command 
```sh
kubectl apply -f mydeployment.yml
```

How many Deployments exist on the system now?
```sh
4
3
0
2
1
```


How many ReplicaSets exist on the system now?
```sh
4
3
0
2
1
```

How many PODs exist on the system now?
```sh
4
3
0
2
1
```



Out of all the existing PODs, how many are ready?
```sh
4
3
0
2
1
```


What is the image used to create the pods in the mydeployments?
```sh
nginx:1.22
tomcat:1.22
javahomecloud:1.22
busybox:1.22
```


Why do you think the deployment is not ready?
```sh
The image javahomecloud:1.22 does not exist 
Deployment is not created correctly
Application has errors
Kubernetes is faulty
```

#### Run the below command 
```sh
cat > mydeploy.yml << EOF
apiVersion: apps/v1
kind: deployment
metadata:
  name: deployment-1
spec:
  replicas: 2
  selector:
    matchLabels:
      name: busybox-pod
  template:
    metadata:
      labels:
        name: busybox-live
    spec:
      containers:
      - name: busybox-container
        image: nginx
        command:
        - sh
        - "-c"
        - echo Hello Kubernetes! && sleep 3600
EOF
```
#### Run the below command 
```sh
kubectl apply -f mydeploy.yml
Fix the Error in above deployment manifest file
```

Create a new Deployment with the below attributes using your own deployment definition file.
```sh
Name: httpd-frontend;
Replicas: 3;
Image: httpd:2.4-alpine
```

Now delete all the Deployments and verify that all pods, replcaset and deployment were deleted?
