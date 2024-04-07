```sh
apiVersion: v1
kind: PersistentVolume
metadata:
  name: myebsvol
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Delete # Retain - Delete - Recycle (depreciated ) 
  awsElasticBlockStore:
    volumeID:           # take the volume id and add here
    fsType: ext4
```
