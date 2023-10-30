### What is Container Insight
```sh
1. A fully managed observability service for monitoring, troubleshooting and 
   alarming on our containerized applications.
2. Container Insights to collect, aggregate, and summarize metrics and logs from 
   our containerized applications and microservices.
3. The metrics include utilization for resources such as CPU, memory, disk, and network. 
4. It also provides diagnostic information, such as container restart failures, to help 
   us isolate issues and resolve them quickly. 
5. We can also set CloudWatch alarms on metrics that Container Insights collects.
6. The metrics that Container Insights collects are available in CloudWatch 
   automatic dashboards. 
7. We can analyze and troubleshoot container performance and logs data with 
   CloudWatch Logs Insights
```
### Add access to the worker node IAM role to push logs to the cloudwatch
```sh
Go to Services -> EC2 -> Worker Node EC2 Instance -> IAM Role -> Click on that role
=> Add the CloudWatchAgentServerPolicy 
````
### How to Deploy
```sh
# Template
curl -s https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluentd-quickstart.yaml | sed "s/{{cluster_name}}/<REPLACE_CLUSTER_NAME>/;s/{{region_name}}/<REPLACE-AWS_REGION>/" | kubectl apply -f -


# Replaced Cluster Name and Region

curl -s https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluentd-quickstart.yaml | sed "s/{{cluster_name}}/dev/;s/{{region_name}}/us-east-1/" | kubectl apply -f –
```
#### Verify
```sh
# List Daemonsets
kubectl -n amazon-cloudwatch get daemonsets
````
### Deploy an application
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample-nginx-deployment
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
  name: sample-nginx-service
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
kubectl run --generator=run-pod/v1 apache-bench -i --tty --rm --image=httpd -- ab -n 500000 -c 1000 http://sample-nginx-service.default.svc.cluster.local/
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

Reference: Container Insights metrics
https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Container-Insights-view-metrics.html
