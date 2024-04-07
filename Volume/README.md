
#### Types of Storage:
```sh
emptyDir
HostPath
Persistent Volume
````
#### Usage of emptyDir
```sh
Temporary Files or Cache:
Communication Between Containers:
Batch Processing or ETL Pipelines:
````
#### Storage Location
```sh
/var/lib/kubelet/pods/{podid}/volumes/kubernetes.io~empty-dir/ 
Pod id
kubectl get pods -n <namespace> <pod-name> -o jsonpath='{.metadata.uid}'
````
#### Access modes:
````sh
ReadWriteOnce
ReadOnlyMany
ReadWriteMany
ReadWriteOncePod
````
