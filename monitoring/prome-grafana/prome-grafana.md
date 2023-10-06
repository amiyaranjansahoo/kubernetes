### Expose to access by LoadBalancer or NodePort
```sh
kubectl edit svc monitoring-kube-prometheus-prometheus -n monitoring
kubectl edit svc monitoring-grafana -n monitoring

```
