#### What is helm
```sh
1. Helm is the package manager for Kubernetes.
2. As an operating system package manager makes it easy to install tools on an OS, Helm makes it easy to install applications
   and resources into Kubernetes clusters
2. It lets us treat our Kubernetes apps as apps instead of just a collection of objects, and this takes a huge burden from our
   shoulders as we don't have to micromanage each Kubernetes object anymore.
3. Using HELM we can install, upgrade, rollback and uninstall the most complicated k8s application  easily without any overhead.
```

#### helm commands:
```sh
helm / helm --help# Display the helm help commands
helm repo --help # Display the helm repo help commands
helm repo list # 
helm repo add <repo name>
helm repo update
helm list # List all release details
helm uninstall <release name> # Uninstall a specific release
helm delete <release name> # This also Uninstall a specific release
# Upgrade a release, thats creates a revision
helm upgrade <release name> [CHART]
helm upgrade r5400 ./nginx/ # Example
# Rollback, thats creates a revision
helm rollback <release name> #helm rollback r5400
```
