### What is Container Insight

### How to Deploy
```sh
# Template
curl -s https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluentd-quickstart.yaml | sed "s/{{cluster_name}}/<REPLACE_CLUSTER_NAME>/;s/{{region_name}}/<REPLACE-AWS_REGION>/" | kubectl apply -f -


# Replaced Cluster Name and Region

curl -s https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluentd-quickstart.yaml | sed "s/{{cluster_name}}/dev/;s/{{region_name}}/us-east-1/" | kubectl apply -f –
```
### Deploy an application
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mydeployment
  labels:
    app: sample-nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sample-nginx
  template:
    metadata:
      labels:
        app: sample-nginx
    spec:
      containers:
        - name: sample-nginx
          image: nginx
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: myservice
  labels:
    app: sample-nginx
spec:
  selector:
    app: sample-nginx
  ports:
  - port: 80
    targetPort: 80
```
### Generate The Load
```sh
kubectl run --generator=run-pod/v1 apache-bench -i --tty --rm --image=httpd -- ab -n 500000 -c 1000 http://myservice.default.svc.cluster.local/
```
### Create Graph for Avg Node CPU Utlization # /aws/containerinsights/eksdemo1/performance
```sh
STATS avg(node_cpu_utilization) as avg_node_cpu_utilization by NodeName
| SORT avg_node_cpu_utilization DESC
```
### Average No of Container Restart
```sh
STATS avg(number_of_container_restarts) as avg_number_of_container_restarts by PodName | SORT avg_number_of_container_restarts DESC
```
