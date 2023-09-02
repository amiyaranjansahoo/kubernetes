
### First, create a namespace
```sh
kubectl create namespace argocd
```

### Let's apply the yaml configuration files for ArgoCd:
```sh
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Verify all the pods RUNNING
kubectl get po -n argocd

# Expose a service to access the argocd pod:
kubectl expose deploy/argocd-server --type=NodePort --name=arg-svc -n argocd
kubectl expose deploy/argocd-server --type=LoadBalancer --name=argcd-svc -n argocd

# Fetching the intial admin password
kubectl get secret
kubectl get secret argocd-initial-admin-secret -n argocd -o yaml
echo "" | base64 --decode
```

### Fetch the eks end point
aws eks describe-cluster --name dev --query "cluster.endpoint"

### Install argocd CLI
```sh
# Login as root
curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
chmod +x /usr/local/bin/argocd

# Login to argocd 
argocd login <argocdip>:<port> #argocd login 3.236.82.139:32525

# List all clusters contexts and  Adding the k8s cluster to argocd
kubectl config get-contexts -o name
argocd cluster add <k8s context arn>

# Modify the conext 
kubectl config set-context --current --namespace=argocd

# Create the application using the following command

argocd app create myapp --repo <git repo name> --path . --revision master --dest-server <EKS cluster end point> --dest-namespace default

# argocd app create myapp --repo https://github.com/argoproj/argocd-example-apps.git --path . --revision master --dest-server https://05E04E5DBEC80B1A4659C5E69FBB50D0.gr7.us-east-1.eks.amazonaws.com --dest-namespace default
```
