## Implementing the configMap
#### Deploy the storage class, sql deployment and None Service
```sh
---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ebs-sc
provisioner: ebs.csi.aws.com
volumeBindingMode: WaitForFirstConsumer
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ebs-mysql-pv-claim
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: ebs-sc
  resources:
    requests:
      storage: 4Gi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
        - name: mysql
          image: mysql:5.6
          env:
            - name: MYSQL_ROOT_PASSWORD
              value: dbpassword11
          ports:
            - containerPort: 3306
              name: mysql
          volumeMounts:
            - name: mysql-persistent-storage
              mountPath: /var/lib/mysql
      volumes:
        - name: mysql-persistent-storage
          persistentVolumeClaim:
            claimName: ebs-mysql-pv-claim
---
apiVersion: v1
kind: Service
metadata:
  name: mysql
spec:
  selector:
    app: mysql
  ports:
    - port: 3306
  clusterIP: None # This means we are going to use Pod IP
```
#### Connect to MYSQL Database
```sh
kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -- mysql -h mysql -pdbpassword11

# Verify usermgmt schema got created which we provided in ConfigMap
mysql> show schemas;
CREATE DATABASE usermgmt;
use usermgmt;
show tables;
select * from users;
```

#
#### Deploy the second part: appliation deployment and Nodeport service
#
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: usermgmt-microservice
  labels:
    app: usermgmt-restapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: usermgmt-restapp
  template:
    metadata:
      labels:
        app: usermgmt-restapp
    spec:
      containers:
        - name: usermgmt-restapp
          image: amiyaranjansahoo/microsvc:v1
          ports:
            - containerPort: 8095
          envFrom:
            - configMapRef:
                name: myconfigmap
---
apiVersion: v1
kind: Service
metadata:
  name: usermgmt-restapp-service
  labels:
    app: usermgmt-restapp
spec:
  type: NodePort
  selector:
    app: usermgmt-restapp
  ports:
    - port: 8095 # When access using the LB (service type), please use port =>  http://LBDNS:8095
      targetPort: 8095
      nodePort: 31231
---
kind: ConfigMap
apiVersion: v1
metadata:
  name: myconfigmap
data:
  # Configuration values can be set as key-value properties
  DB_HOSTNAME: mysql
  DB_PORT: "3306"
  DB_NAME: usermgmt
  DB_USERNAME: root
  DB_PASSWORD: dbpassword11
```
#### How to access
```sh
http://3.231.149.112:31231/usermgmt/health-status
```
