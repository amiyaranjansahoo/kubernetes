### Deploy the metric server
```sh
kubectl apply -f https://raw.githubusercontent.com/amiyaranjansahoo/kubernetes/main/hpa/metrics-server-components.yaml
```
### Deploy the auto scale
```sh
kubectl autoscale deployment mydeploy --cpu-percent=20 --min=1 --max=10
```
### Manually Increase the load
```sh
kubectl exec <pod name> --it -- /bin/bash
apt update # run continuously
```
