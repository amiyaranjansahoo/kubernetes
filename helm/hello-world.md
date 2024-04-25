#### Deployment of hello-world application
```sh
# Add the Repo:
helm repo add hello-world https://ayazuddin007.github.io/Helm3/
# Pull the Repo:
helm pull  hello-world/hello-world
# List the Repo:
help repo list
# Install the hello-world with release1 : 
helm install release1 ./hello-world/
helm install release2 hello-world/hello-world --version 0.2.0 # Alternative to install the application
kubectl get po
# Add a NodePort service to access from outside
```
