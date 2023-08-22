
### List out the nodes:
kubectl get nodes

### Taint the node, replacing <NODE_NAME> with one of the worker node names returned in the previous command:
kubectl taint node <NODE_NAME> node-type=prod:PreferNoSchedule

### Scale up the deployment:
kubectl scale deployment/prod --replicas=3
