#### Create a Service Account
```sh
apiVersion: v1
kind: ServiceAccount
metadata:
  name: app1serviceaccount
````
#### Create a Role
```sh
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-creator
  namespace: default
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["create", "get", "watch", "list"]
````
#### Create a Role Binding
```sh
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: pod-creator
  namespace: default
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: pod-creator
subjects:
- kind: ServiceAccount
  name: app1serviceaccount
````
