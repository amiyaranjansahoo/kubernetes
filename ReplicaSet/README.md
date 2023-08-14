### Replica Set:
```sh
1. Replica set is a next generation replication controller
2. The replication controller only supports equality based selector whereas the replica set supports 
      equality based selector  + set-based selector i.e. filtering according to set off values.# env in dev,test, pt etc etc
3. Replica set rather than the replication controller is used by other object like deployment.
4. We need to mention kind as ReplicaSet  # kind: ReplicaSet
5. And the api version is apps/v1 instead of v1 # apiVersion: apps/v1
6. We can use set based selector as explained above.
```
