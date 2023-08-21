### Deployment
```sh
•	Replication controller Replica set is not able to do update and rollback apps in the cluster.
•	A deployment object acts as a supervisor for pods, giving you fine-grained control over how
  and when a new pod is rolled out, updated or rolled back to a previous state.
•	When using the deployment object, we first define the state of the app, then k8s cluster
   schedules mentioned app instances onto specific individual nodes.
•	A deployment provides declarative updates for pods and replicaset.
•	k8s then monitors, if the node hosting an instance goes down or pod is deleted then the
   deployment controller replaces it.
•	This provides a self-healing mechanism to address machine failure or maintenance.
```
### Deployment Use Case
```sh
•	Create a deployment to rollout a replicaSet.
•	Declare the new state of the pods
•	Rollback to an earlier deployment revision
•	Scale up the deployment to facilitates more load
•	Pause the deployment to apply multiple fixes to its PodTemplateSpec and then name it to a new rollout
•	Clean-up the older replicaSet which is not required anymore
```
### Deployment commands
```sh
kubectl decribe deploy mydeployment
kubectl scale --replicas=1 deploy mydeployment # To scale up or scale down
Kubectl exec <pod_name> -it -- /bin/bash # Accessing the pods
```
