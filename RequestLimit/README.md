### Deploy the metric server
```sh
kubectl apply -f https://raw.githubusercontent.com/amiyaranjansahoo/kubernetes/main/hpa/metrics-server-components.yaml
```
#### Request and Limit
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
#### LimitRange
```sh
apiVersion: v1
kind: LimitRange
metadata:
  name: example-limits
  namespace: default  # Namespace where it applies
spec:
  limits:
    - type: Container
      default:
        cpu: "500m"           # Default limit: 500 millicores
        memory: "512Mi"       # Default limit: 512 MiB of memory
      defaultRequest:
        cpu: "200m"           # Default request: 200 millicores
        memory: "256Mi"       # Default request: 256 MiB
      max:
        cpu: "1"              # Max allowed: 1 core
        memory: "1Gi"         # Max allowed: 1 GiB
      min:
        cpu: "100m"           # Minimum required: 100 millicores
        memory: "128Mi"       # Minimum required: 128 MiB
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: pod-without-limits
  namespace: default
spec:
  containers:
    - name: app
      image: nginx
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: pod-exceeding-limits
  namespace: default
spec:
  containers:
    - name: app
      image: nginx
      resources:
        requests:
          cpu: "2"      # Exceeds max CPU (1)
          memory: "2Gi" # Exceeds max memory (1Gi)
```
#### ResourceQuota
```sh
apiVersion: v1
kind: ResourceQuota
metadata:
  name: namespace-quota
  namespace: default
spec:
  hard:
    requests.cpu: "10"
    requests.memory: "20Gi"
    limits.cpu: "20"
    limits.memory: "40Gi"
    pods: "1"
```
