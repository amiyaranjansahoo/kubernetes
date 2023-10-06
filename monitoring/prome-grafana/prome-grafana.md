### Expose to access by LoadBalancer or NodePort
```sh
kubectl edit svc monitoring-kube-prometheus-prometheus -n monitoring # Edit the service from ClusreIP to LoadBalancer
kubectl edit svc monitoring-grafana -n monitoring # Edit the service from ClusreIP to LoadBalancer

# In case NodePort
kubectl edit svc monitoring-kube-prometheus-prometheus -n monitoring # Edit the service from ClusreIP to NodePort
kubectl edit svc monitoring-grafana -n monitoring # Edit the service from ClusreIP to NodePort

Promeheus URL: http://<LB>:9090
Grafana URL: http://<LB>
Grafana Access: admin / prom-operator
```
