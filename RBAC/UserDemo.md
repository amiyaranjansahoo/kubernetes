#### Generating Key
```sh
openssl genrsa -out appuser.key 2048
```
#### Generaing Certificate Signing request (csr):
```sh
openssl req -new -key appuser.key -out appuser.csr -subj "/CN=appuser"
```
#### Singing CSR using K8s Cluster "Certificate" and "Key"
```sh
openssl x509 -req -in appuser.csr \
        -CA /etc/kubernetes/pki/ca.crt \
        -CAkey /etc/kubernetes/pki/ca.key \
        -CAcreateserial \
        -out appuser.crt -days 300
```
#### Adding user credentials to "kubeconfig" file
```sh
kubectl config set-credentials appuser  --client-certificate=appuser.crt --client-key=appuser.key
```
#### Creating context for this user and associating it with our cluster:
```sh
kubectl config set-context appuser-context --cluster=kubernetes --user=appuser
```
#### Creating the  Namespace:
```sh
kubectl create ns dev-ns
```
#### Creating a Pod
```sh
kubectl run nginx-pod --image=nginx -n dev-ns
kubectl get pods -n dev-ns
```
#### Test Before Deploying
```sh
kubectl get pods -n dev-ns --user=appuser
```
### Creating the "Role" & "RoleBinding":
#### Creating the "Role" :
```sh
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: dev-ns
  name: pod-reader
rules:
- apiGroups: [""] 
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```
#### Creating the "RoleBinding"
```sh
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: read-pods
  namespace: dev-ns
subjects:
- kind: User
  name: appuser 
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role 
  name: pod-reader 
  apiGroup: rbac.authorization.k8s.io
```
#### Display Role and RoleBinding:
```sh
kubectl get role -n dev-ns
kubectl get rolebinding -n dev-ns
kubectl describe role -n dev-ns
kubectl describe rolebinding -n dev-ns
```
### Testing RBAC
```sh
kubectl auth can-i get pods -n dev-ns --user=appuser
kubectl auth can-i list pods -n dev-ns --user=appuser

kubectl get pod nginx-pod -n dev-ns --user=appuser
kubectl get pods -n dev-ns --user=appuser
```
#### Negative scenario: Delete the pod from the user appuser
```sh
kubectl delete pod nginx-pod -n dev-ns --user=appuser
```
