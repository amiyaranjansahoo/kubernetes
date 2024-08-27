### What is k8s Service?
```sh
The service resources lets you expose an application running in pods to be reachable from outside your cluster.
```
### How to create a service using imperative method
```sh
kubectl expose deploy/argocd-server --type=NodePort --name=<custom service name> -n <namespace name>
kubectl expose deploy/argocd-server --type=LoadBalancer --name=<custom service name> -n <namespace name>
```
apt-get update -y && apt-get install dnsutils -y
