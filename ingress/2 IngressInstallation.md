### Install the Ingress
```sh
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-cpr-demo
  annotations:
    # Load Balancer Name
    alb.ingress.kubernetes.io/load-balancer-name: cpr-ingress
    # Ingress Core Settings
    #kubernetes.io/ingress.class: "alb" (OLD INGRESS CLASS NOTATION - STILL WORKS BUT RECOMMENDED TO USE IngressClass Resource)
    alb.ingress.kubernetes.io/scheme: internet-facing
   # Health Check Settings
    alb.ingress.kubernetes.io/healthcheck-protocol: HTTP 
    alb.ingress.kubernetes.io/healthcheck-port: traffic-port
    #Important Note:  Need to add health check path annotations in service level if we are planning to use multiple targets in a load balancer    
    alb.ingress.kubernetes.io/healthcheck-interval-seconds: '15'
    alb.ingress.kubernetes.io/healthcheck-timeout-seconds: '5'
    alb.ingress.kubernetes.io/success-codes: '200'
    alb.ingress.kubernetes.io/healthy-threshold-count: '2'
    alb.ingress.kubernetes.io/unhealthy-threshold-count: '2'	
spec:
  ingressClassName: alb   # Ingress Class                       
  rules:
    - http:
        paths:           
          - path: /app1
            pathType: Prefix
            backend:
              service:
                name: app1 # amiyaranjansahoo/ingressdemo:v1
                port: 
                  number: 8080
          - path: /app2
            pathType: Prefix
            backend:
              service:
                name: app2 # amiyaranjansahoo/ingressdemo:v2
                port: 
                  number: 8080
```
