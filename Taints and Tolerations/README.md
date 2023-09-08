
### List out the nodes:
kubectl get nodes

### Taint the node, replacing <NODE_NAME> with one of the worker node names returned in the previous command:

#### taint-effect could be NoSchedule, PreferNoSchdeule and NoExecute
kubectl taint node <NODE_NAME> node-type=prod:NoSchedule
Example: kubectl taint nodes <node name> key=value:taint-effect
kubectl taint node <NODE_NAME> node-type=prod:NoSchedule-

### Scale up the deployment:
kubectl scale deployment/prod --replicas=3
