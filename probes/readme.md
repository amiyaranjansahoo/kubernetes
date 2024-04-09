## k8s probes
```sh
•	It’s all about to track/monitor the status of the application deploy inside the container.
•	In order to verify if a container in a POD is healthy and ready to serve traffic,
kuberenets provides for a range of health checking mechanism
•	Health checks or probes are carried out by the kubelet to determine when to restart/recreate a container
(for liveness probe) and used by services and deployments to determine if a POD should receive traffic.
```

#### liveness probes
```sh
•	The kubelet uses liveness probes to know when to restart a container. 
•	For example, liveness probes could catch a deadlock, where an application is running, but unable to make progress. 
•	Restarting a container in such a state can help to make the application more available despite bugs.
```

#### readiness probes
```sh
•	The kubelet uses readiness probes to know when a container is ready to start accepting traffic. 
•	A Pod is considered ready when all of its containers are ready. 
•	One use of this signal is to control which Pods are used as backends for Services. 
•	When a Pod is not ready, it is removed from Service load balancers.
```

#### startup probes
```sh
•	The kubelet uses startup probes to know when a container application has started. 
•	If such a probe is configured, it disables liveness and readiness checks until it succeeds,
making sure those probes don't interfere with the application startup. 
•	This can be used to adopt liveness checks on slow starting containers, avoiding them getting killed
by the kubelet before they are up and running
```

