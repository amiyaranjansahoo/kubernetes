## k8s probes
```sh
1. In Kubernetes, a probe is a diagnostic mechanism used by the kubelet to check the health and state of a container.
2. k8s Probes performes the health checks at regular intervals. 
3. There are three main types of probes in Kubernetes: Liveness Probe, Readiness Probe, and Startup Probe. 
4. Each serves a different purpose and helps ensure that applications run smoothly and efficiently within a Kubernetes cluster.
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

