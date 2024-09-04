#### What is RBAC?
```sh
RBAC remains a crucial component of container security.
It allows you to define who has access to what resources in your cluster.
```
#### What is k8s Service Account
```sh
Whenever you access your Kubernetes cluster with kubectl, you are authenticated by Kubernetes
with your user account. User accounts are meant to be used by humans. But when a pod running
in the cluster wants to access the Kubernetes API server, it needs to use a service account
instead. Service accounts are just like user accounts but for non-humans.
```
#### User Account details
```sh
kubectl config view -o json  | jq ".users" | grep "name" | awk '{print $2}' | tr -d "\"" | tr -d ","
````
#### Why k8s Service Account is Required
````sh
Pods are not humans, so it’s good to have a distinction from user accounts.
It’s especially important for security reasons as well.
Many cloud-native tools also need access to your Kubernetes API to do their jobs,
such as logging or monitoring applications.
````
#### What is Default Service Account
```sh
Kubernetes comes with a predefined service account called “default.”
And by default, every created pod has that service account assigned to it.
````
#### Create a Pod to validate the default service account
```sh
kind: Pod
apiVersion: v1
metadata:
  name: mypod
  labels:
    envt: dev
spec:
  containers:
    - name: mynginx
      image: nginx
      ports:
        - containerPort: 80
````
#### Validate the default SA using the kubectl command
```sh
kubectl describe po mypod # Service Account:  default
````

![image](https://github.com/amiyaranjansahoo/kubernetes/assets/24844782/f2cd8d6d-29ba-46d8-8eba-c7698ac0d364)

