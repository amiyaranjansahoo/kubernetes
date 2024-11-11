### Deployment
```sh
Replication controller Replica set is not able to do update and rollback apps in the cluster.
A deployment object acts as a supervisor for pods, giving you fine-grained control over how and when a new pod is rolled out, updated or rolled back to a previous state.
A deployment provides declarative updates for pods and replicaset.
k8s then monitors, if the node hosting an instance goes down or pod is deleted then the deployment controller replaces it.
This provides a self-healing mechanism to address machine failure or maintenance.
```
### Deployment Use Case
```sh
•	Create a deployment to rollout a replicaSet.
•	Rollback to an earlier deployment revision
•	Scale up the deployment to facilitates more load
•	Pause the deployment to apply multiple fixes to its PodTemplateSpec and then name it to a new rollout
•	Clean-up the older replicaSet which is not required anymore
```
### Imperative
```sh
kubectl create deploy mydeploy --image=nginx --dry-run -oyaml
kubectl create deploy mydeploy --image=nginx 
kubectl create deploy mydeploy --image=nginx --replicas=2
```
### Deployment commands
```sh
kubectl decribe deploy <deployment name>
kubectl scale --replicas=1 deploy <deployment name> # To scale up or scale down
Kubectl exec <pod_name> -it -- /bin/bash # Accessing the pod container
```
### Deployment Rollout Status
```sh
kubectl rollout status deployment <deployment name>
```
###  Deployment history
```sh
kubectl rollout history deployment <deployment name>
```
### Rollout the version from v1 to v2
```sh
# Create one more deployment manifest with new image name (Case 1)
# Edit the deployment name inside yaml (Case 2)
kubectl edit deploy <deployment name>
# Edit the image and apply again the manifest (Case 3)
kubectl set image deployment/nginx-deployment nginx=nginx:1.161
```
### To add a change cause
```sh
kubectl annotate deployment/mydeployments kubernetes.io/change-cause="update image version from v1 to v2"
```
### Deployment Rollback
```sh
kubectl rollout undo deployment <deployment name>
```
### To see the details of each revision
```sh
kubectl rollout history deployment/<deployment name> --revision=3
kubectl rollout history deployment/<deployment name> --revision=2
kubectl rollout history deployment/<deployment name> --revision=1
```
### Deployment Rollback to a specific version
```sh
kubectl rollout undo deployment <deployment name> --to-revision=1
```
