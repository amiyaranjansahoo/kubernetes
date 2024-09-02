### Deploy the metric server
```sh
kubectl apply -f https://raw.githubusercontent.com/amiyaranjansahoo/kubernetes/main/hpa/metrics-server-components.yaml
```

```sh
apiVersion: v1
kind: Pod
metadata:
  name: frontend
spec:
  containers:
  - name: app
    image: nginx
    resources:
      requests:
        memory: "10Mi"
        cpu: "250m"
      limits:
        memory: "12Mi"
        cpu: "500m"
```
